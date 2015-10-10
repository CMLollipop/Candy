//
//  Core.m
//  Candy
//
//  Created by caiming on 15/10/9.
//  Copyright © 2015年 caiming. All rights reserved.
//

#import "Core.h"
#import "MeinvListService.h"

@implementation Core


+ (id)share
{
    static Core *client;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        client = [[Core alloc]init];
    });
    return client;
}

- (void)httpGetMeinvListWithNum:(NSNumber *)num
                        success:(void(^)(NSDictionary *responseObject))success
                        failure:(void(^)(NSString *errorCode,
                                         NSString*errorMsg,
                                         NSDictionary*responseObject))failure
{
    MeinvListService *service = [[MeinvListService alloc]init];
    NSDictionary *param = @{@"num":num};
    [service getMeinvListWithParam:param
                           success:^(NSDictionary *responseObject) {
        
    } failure:^(NSString *errorCode,
                NSString *errorMsg,
                NSDictionary *responseObject) {
        
    }];
}

@end
