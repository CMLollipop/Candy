//
//  WebViewController.m
//  Candy
//
//  Created by caiming on 15/10/10.
//  Copyright © 2015年 caiming. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@property(nonatomic,strong)UIWebView *webView;

@end

@implementation WebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.webView];
    NSURL *url = [NSURL URLWithString:_URLString];
    
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    [self.webView loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIWebView *)webView
{
    if (_webView) {
        
        return _webView;
    }
    
    _webView = [[UIWebView alloc]initWithFrame:SCREEN_BOUNDS];
    
    return _webView;
}

@end
