//
//  SecondViewController.m
//  Candy
//
//  Created by caiming on 15/10/9.
//  Copyright © 2015年 caiming. All rights reserved.
//

#import "SecondViewController.h"
#import "HomeTableViewCell.h"
#import "ManageCoreData.h"
#import "UITableView+FetchResult.h"
#import "Meinv.h"
#import <MJPhotoBrowser.h>
#import <MJPhoto.h>


@interface SecondViewController ()<UITableViewDataSource,UITableViewDelegate,HomeTableViewCellDelegate>

@property(nonatomic,strong)UITableView *myTableView;
@property(nonatomic,strong)NSArray *dataSource;
@property(nonatomic,strong)NSFetchedResultsController *fetchResult;


@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"奇闻趣事";
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.myTableView];
    [_myTableView.header beginRefreshing];
    NSError *error;
    
    if (![self.fetchResult performFetch:&error]) {
        
        NSLog(@"%@",error);
    }}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)httpListMeinv:(NSNumber *)lastObjectId
{
    [[Core share]httpGetTiyuListWithNum:@10
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
        cell.delegate= self;
    }
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
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"mType == %@",@2];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
