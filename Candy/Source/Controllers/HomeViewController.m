//
//  HomeViewController.m
//  Candy
//
//  Created by caiming on 15/10/9.
//  Copyright © 2015年 caiming. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeTableViewCell.h"
#import "ManageCoreData.h"
#import "UITableView+FetchResult.h"
#import "Meinv.h"
#import <MJPhotoBrowser.h>
#import <MJPhoto.h>
#import "DMAdView.h"

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate,HomeTableViewCellDelegate,DMAdViewDelegate>

@property(nonatomic,strong)UITableView *myTableView;
@property(nonatomic,strong)NSArray *dataSource;
@property(nonatomic,strong)NSFetchedResultsController *fetchResult;
@property(nonatomic,strong)DMAdView *dmAdView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.myTableView];
    self.navigationItem.title = @"每日美女";
    [_myTableView.header beginRefreshing];
    NSError *error;
    
    if (![self.fetchResult performFetch:&error]) {
        
        NSLog(@"%@",error);
    }
    [self.view addSubview:self.dmAdView];
    [_dmAdView loadAd];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _dmAdView.frame = CGRectMake(0, SCREEN_HEIGHT-self.tabBarController.tabBar.frame.size.height-FLEXIBLE_SIZE.height, SCREEN_WIDTH, FLEXIBLE_SIZE.height);
    self.myTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-FLEXIBLE_SIZE.height);
}

- (DMAdView *)dmAdView
{
    if (_dmAdView) {
        
        return _dmAdView;
    }
    _dmAdView = [[DMAdView alloc]initWithPublisherId:@"56OJwpEYuN3njp+UlJ" placementId:@"16TLuvsaApnrPNUvZGjhlIts"];
    _dmAdView.frame = CGRectMake(0, 20, SCREEN_WIDTH, FLEXIBLE_SIZE.height);
    _dmAdView.delegate = self;
    _dmAdView.rootViewController = self;
    return _dmAdView;
}

- (void)httpListMeinv:(NSNumber *)lastObjectId
{
    [[Core share]httpGetMeinvListWithNum:@10
                            lastObjectId:lastObjectId
                                 success:^(NSDictionary *responseObject) {
                                     
                                     if (lastObjectId)
                                     {
                                         [_myTableView.footer endRefreshing];
                                     }else
                                     {
                                         [_myTableView.header endRefreshing];
                                         
                                     }
                                     
                                 } failure:^(NSString *errorCode, NSString *errorMsg, NSDictionary *responseObject) {
                                     
                                     if (lastObjectId)
                                     {
                                         [_myTableView.footer endRefreshing];
                                     }else
                                     {
                                         [_myTableView.header endRefreshing];

                                     }
                                     
                                 }];

}


- (void)refresh
{
    [self httpListMeinv:nil];
}

- (void)loadMore
{
    Meinv *object = self.fetchResult.fetchedObjects.lastObject;
    [self httpListMeinv:object.mObjectId];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.fetchResult sections]count];
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    id<NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchResult sections] objectAtIndex:section];
    return  [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"UITableViewCell";
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"HomeTableViewCell" owner:self options:nil]lastObject];
        
    }
    cell.delegate = self;
    [cell reloadData:[self.fetchResult objectAtIndexPath:indexPath]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Meinv *model = [self.fetchResult objectAtIndexPath:indexPath];
    [[XYRouter sharedInstance]showViewController:@"WebViewController" param:@{@"URLString":model.mUrl}];
}

- (UITableView *)myTableView
{
    if (_myTableView) {
        
        return _myTableView;
    }
    _myTableView = [[UITableView alloc]initWithFrame:SCREEN_BOUNDS style:UITableViewStylePlain];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    [_myTableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    [_myTableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(loadMore)];

    return _myTableView;
    
}

- (NSFetchedResultsController *)fetchResult
{
    if (_fetchResult) {
        
        return _fetchResult;
    }
    
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"mObjectId" ascending:NO];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"mType == %@",@1];
    _fetchResult = [self.myTableView fetchResultWithEntityName:@"Meinv" predicate:predicate SortDescriptors:@[sort]];
    
    return _fetchResult;
}

- (void)homeTableViewCellDidSelectImage:(HomeTableViewCell *)cell
{
    MJPhoto *photo = [[MJPhoto alloc]init];
    photo.srcImageView = cell.imageV;
    photo.url = [NSURL URLWithString:cell.model.mPicUrl];
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = 0;
    browser.photos = @[photo].mutableCopy;
    [browser show];
}


// Sent when an ad request success to loaded an ad
- (void)dmAdViewSuccessToLoadAd:(DMAdView *)adView
{
    NSLog(@"done");

}
// Sent when an ad request fail to loaded an ad
- (void)dmAdViewFailToLoadAd:(DMAdView *)adView withError:(NSError *)error
{
    NSLog(@"done");

}
// Sent when the ad view is clicked
- (void)dmAdViewDidClicked:(DMAdView *)adView
{
    NSLog(@"done");

}
// Sent just before presenting the user a modal view
- (void)dmWillPresentModalViewFromAd:(DMAdView *)adView
{
    NSLog(@"done");

}
// Sent just after dismissing the modal view
- (void)dmDidDismissModalViewFromAd:(DMAdView *)adView
{
    NSLog(@"done");

}
// Sent just before the application will background or terminate because the user's action
// (Such as the user clicked on an ad that will launch App Store).
- (void)dmApplicationWillEnterBackgroundFromAd:(DMAdView *)adView
{
    NSLog(@"done");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
