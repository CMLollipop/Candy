//
//  RootTabBarController.m
//  Candy
//
//  Created by caiming on 15/10/9.
//  Copyright © 2015年 caiming. All rights reserved.
//

#import "RootTabBarController.h"

@interface RootTabBarController ()

@end

@implementation RootTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self initSubviews];
}

- (void)initSubviews
{
    NSArray *viewControllerNames = @[@"HomeViewController",@"SecondViewController"];
    
    
    NSArray *tabBarImages = @[@"lingerie_L",@"article"];
    NSArray *tabBarTitles = @[@"每日美女",@"奇闻趣事"];


    NSMutableArray *controllers = [NSMutableArray array];
    
    NSInteger i = 0;
    for (NSString *controllerName in viewControllerNames) {
        UIViewController *vc = [[XYRouter sharedInstance]getViewControllerWithControllerName:controllerName];
        
        if (vc) {
            
            UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:vc];
            [controllers addObject:nvc];
            
            NSString *imageName = [tabBarImages objectAtIndex:i];
            NSString *selectImageName = [NSString stringWithFormat:@"%@_sel",imageName];
            NSString *title = [tabBarTitles objectAtIndex:i];
            [self setViewController:nvc
            tabBarItemImageWithName:imageName
         tabBarItemSelImageWithName:selectImageName
                    tabBarItemTitle:title];
        }
        i++;

    }
    


    
    self.viewControllers = controllers.copy;
}


-  (void)setViewController:(UIViewController *)vc
   tabBarItemImageWithName:(NSString *)imageName
tabBarItemSelImageWithName:(NSString *)imageNameSel
           tabBarItemTitle:(NSString *)title;

{
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:imageNameSel]
                                   imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.image = [[UIImage imageNamed:imageName]
                           imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    NSDictionary *normal = [NSDictionary  dictionaryWithObjectsAndKeys:ColorWithWhite(116.0),NSForegroundColorAttributeName, nil];
//    [vc.tabBarItem setTitleTextAttributes:normal forState:UIControlStateNormal];
//    NSDictionary *select = [NSDictionary  dictionaryWithObjectsAndKeys:ColorWithRGB(253.0, 189.0, 54.0),NSForegroundColorAttributeName, nil];
//    [vc.tabBarItem setTitleTextAttributes:select forState:UIControlStateSelected];
    [vc.tabBarItem setTitle:title];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
