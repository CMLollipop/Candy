//
//  HttpClient.m
//  Children
//
//  Created by caiming on 15/3/25.
//  Copyright (c) 2015年 caiming. All rights reserved.
//

#import "HttpClient.h"
#import <AFNetworking.h>
#import <AFNetworkActivityIndicatorManager.h>

#define NotReachableCode @"999"
#define NotReachableMsg  @"网络不可用,请确认网络链接是否正确."

#define NotResponseCode  @"404"
#define NotResponseMsg   @"服务器无应答,请稍后再试."


@interface HttpClient()

@property(nonatomic, strong)AFHTTPSessionManager *manager;
@property(nonatomic, strong)NSString *appAgent;

@end

@implementation HttpClient

+ (id)share
{
    static HttpClient *client;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        client = [[HttpClient alloc]init];
        client.manager = [AFHTTPSessionManager manager];
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    });
    
    return client;
}



- (void)doGet:(NSString *)URLString
       params:(NSDictionary *)params
      success:(void(^)(NSDictionary *responseObject))success
      failure:(void(^)(NSString *errorCode,
                       NSString*errorMsg,
                       NSDictionary*responseObject))failure
{
//    if ([URLString hasPrefix:@"https"])   // 生产https
//    {
//        _manager.securityPolicy = [AFSecurityPolicy defaultPolicy];
//        _manager.securityPolicy.allowInvalidCertificates = YES;
//    }
    
    NSLog(@"%@",URLString);
    NSLog(@"%@",params);
    

   [_manager.requestSerializer setValue:@"49ccbfa622911467983aeaf9294950a5" forHTTPHeaderField:@"apikey"];
    _manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", nil];

   [_manager GET:URLString parameters:params
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
              NSLog(@"%@",_manager.requestSerializer.HTTPRequestHeaders);
              NSLog(@"%@",responseObject);
              success(responseObject);
              
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
        NSLog(@"%@",_manager.requestSerializer.HTTPRequestHeaders);
        NSLog(@"%@",error);
        failure(NotReachableCode,NotReachableMsg,nil);
    }];
    
    
    
    
//    [_manager GET:URLString
//      parameters:params
//         success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
////             NSLog(@"%@",_manager.requestSerializer.HTTPRequestHeaders);
//
////             NSLog(@"Success:%@",responseObject);
//             NSLog(@"%@",operation.responseString);
//             success(responseObject);
//             
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        NSLog(@"error:%@",error);
//
//        if (operation.response.statusCode == 0) {
//            
//            failure(NotReachableCode,NotReachableMsg,@{});
//            
//        }else
//        {
//            failure(NotResponseCode,NotResponseMsg,@{});
//
//        }
//        
//    }];
}

//- (void)doPost:(NSString *)URLString
//        params:(NSDictionary *)params
//       success:(void(^)(NSDictionary *responseObject))success
//       failure:(void(^)(NSString *errorCode,
//                        NSString*errorMsg,
//                        NSDictionary*responseObject))failure
//{
//    
//    if ([URLString hasPrefix:@"https"])   // 生产https
//    {
//        _manager.securityPolicy = [AFSecurityPolicy defaultPolicy];
//        _manager.securityPolicy.allowInvalidCertificates = YES;
//    }
//    
//    NSLog(@"%@",URLString);
//    NSLog(@"%@",params);
//    
//    [_manager POST:URLString
//        parameters:params
//           success:^(AFHTTPRequestOperation *operation, id responseObject) {
//               
////               NSLog(@"Success:%@",responseObject);
//               NSLog(@"%@",operation.responseString);
//
////               NSLog(@"%@",_manager.requestSerializer.HTTPRequestHeaders);
//
//               success(responseObject);
//               
//           } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//               
//               NSLog(@"%@",_manager.requestSerializer.HTTPRequestHeaders);
//               NSLog(@"error:%@",error);
//               
//               if (operation.response.statusCode == 0) {
//                   
//                   failure(NotReachableCode,NotReachableMsg,@{});
//                   
//               }else
//               {
//                   failure(NotResponseCode,NotResponseMsg,@{});
//                   
//               }
//           }];
//
//}

//- (void)uploadResource:(NSString *)URLString
//                params:(NSDictionary *)params
//              resource:(NSArray *)resources
//               success:(void(^)(NSDictionary *responseObject))success
//               failure:(void(^)(NSString *errorCode,
//                                NSString*errorMsg,
//                                NSDictionary*responseObject))failure
//{
//    NSLog(@"%@",URLString);
//    NSLog(@"%@",params);
//    if ([URLString hasPrefix:@"https"])   // 生产https
//    {
//        _manager.securityPolicy = [AFSecurityPolicy defaultPolicy];
//        _manager.securityPolicy.allowInvalidCertificates = YES;
//    }
//    
//    [_manager POST:URLString
//        parameters:params
//constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
//    {
//        
//    for (NSData *data in resources) {
//
//        [formData appendPartWithFileData:data
//                                    name:@"file"
//                                fileName:@"file.jpg"
//                                mimeType:@"image/jpeg"];
//    }
//    
//    } success:^(AFHTTPRequestOperation *operation, id responseObject)
//    {
//        NSLog(@"Success:%@",responseObject);
//        success(responseObject);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
//    {
//        NSLog(@"%@",_manager.requestSerializer.HTTPRequestHeaders);
//        NSLog(@"error:%@",error);
//        
//        if (operation.response.statusCode == 0) {
//            
//            failure(NotReachableCode,NotReachableMsg,@{});
//            
//        }else
//        {
//            failure(NotResponseCode,NotResponseMsg,@{});
//            
//        }
//        
//    }];
//}

- (NSString *)appAgent
{
    if (_appAgent) {
        
        return _appAgent;
    }
    NSString *ap = [NSString stringWithFormat:@"%@/iOS%@;%@/%@",
                 [[UIDevice currentDevice] model],
                 [[UIDevice currentDevice] systemVersion],
                [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleNameKey] ?: [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleExecutableKey],
                 @"10"];
    
    if ([ap canBeConvertedToEncoding:NSUTF8StringEncoding]) {
        
        
        _appAgent = (NSString*)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(nil,
                                                                                    (CFStringRef)ap, nil,
                                                                                    (CFStringRef)@"!*'();:@&=+$,/ %#[]", kCFStringEncodingUTF8));
        
    }
    
    return _appAgent;
}

@end
