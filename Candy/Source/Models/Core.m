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
                   lastObjectId:(NSNumber *)objectId
                        success:(void(^)(NSDictionary *responseObject))success
                        failure:(void(^)(NSString *errorCode,
                                         NSString*errorMsg,
                                         NSDictionary*responseObject))failure
{
    MeinvListService *service = [[MeinvListService alloc]init];
//    NSDictionary *param = @{@"num":num,@"objectId":objectId};
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:num forKey:@"num"];
    
    if (objectId) {
        
        [param setObject:objectId forKey:@"objectId"];
    }
    
    [service getMeinvListWithParam:param
                           success:success
                           failure:failure];
}

- (void)httpGetTiyuListWithNum:(NSNumber *)num
                  lastObjectId:(NSNumber *)objectId
                       success:(void(^)(NSDictionary *responseObject))success
                       failure:(void(^)(NSString *errorCode,
                                        NSString*errorMsg,
                                        NSDictionary*responseObject))failure
{
    MeinvListService *service = [[MeinvListService alloc]init];
    //    NSDictionary *param = @{@"num":num,@"objectId":objectId};
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:num forKey:@"num"];
    
    if (objectId) {
        
        [param setObject:objectId forKey:@"objectId"];
    }
    
    [service getTiyuListWithParam:param
                           success:success
                           failure:failure];
}

@end
