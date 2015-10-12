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

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *myTableView;
@property(nonatomic,strong)NSArray *dataSource;
@property(nonatomic,strong)NSFetchedResultsController *fetchResult;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.myTableView];
    [_myTableView.header beginRefreshing];
    NSError *error;
    
    if (![self.fetchResult performFetch:&error]) {
        
        NSLog(@"%@",error);
    }
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
    MeinvModel *model = _dataSource[indexPath.row];
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
    _fetchResult = [self.myTableView fetchResultWithEntityName:@"Meinv" predicate:nil SortDescriptors:@[sort]];
    
    return _fetchResult;
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
