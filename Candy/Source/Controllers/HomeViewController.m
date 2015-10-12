//
//  HomeViewController.m
//  Candy
//
//  Created by caiming on 15/10/9.
//  Copyright © 2015年 caiming. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeTableViewCell.h"

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *myTableView;
@property(nonatomic,strong)NSArray *dataSource;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.myTableView];
    
    [[Core share]httpGetMeinvListWithNum:@20
                                 success:^(NSDictionary *responseObject) {
                                     
                                     _dataSource = [responseObject objectForKey:@"meinvList"];
                                     [_myTableView reloadData];
                                     
    } failure:^(NSString *errorCode, NSString *errorMsg, NSDictionary *responseObject) {
        
        
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"UITableViewCell";
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"HomeTableViewCell" owner:self options:nil]lastObject];
        
    }
    [cell reloadData:_dataSource[indexPath.row]];
    
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
    return _myTableView;
    
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
