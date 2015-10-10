//
//  MeinvListService.m
//  Candy
//
//  Created by caiming on 15/10/10.
//  Copyright © 2015年 caiming. All rights reserved.
//

#import "MeinvListService.h"
#import "HttpClient.h"

@implementation MeinvListService

- (void)getMeinvListWithParam:(NSDictionary *)param
                    success:(void(^)(NSDictionary *responseObject))success
                    failure:(void(^)(NSString *errorCode,
                                     NSString*errorMsg,
                                     NSDictionary*responseObject))failure
{

    [[HttpClient share]doGet:@"http://apis.baidu.com/txapi/mvtp/meinv"
                      params:param
                     success:^(NSDictionary *responseObject) {
                         
        
    } failure:^(NSString *errorCode,
                NSString *errorMsg,
                NSDictionary *responseObject) {
        
        
    }];
}
@end
