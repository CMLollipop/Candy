//
//  MeinvListService.m
//  Candy
//
//  Created by caiming on 15/10/10.
//  Copyright © 2015年 caiming. All rights reserved.
//

#import "MeinvListService.h"
#import "HttpClient.h"
#import "MeinvModel.h"

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
                         
                         NSString * code = [responseObject objectForKey:@"code"];
                         NSString * msg =  [responseObject objectForKey:@"msg"];
                         if (code.integerValue == 200) {
                             
                             NSMutableArray *array = [NSMutableArray array];
                             
                             for (NSInteger i = 0; i<10; i++) {
                                 
                                 NSString *key = [NSString stringWithFormat:@"%li",(long)i];
                                 id object = [responseObject objectForKey:key];
                                 if (object) {
                                     [array addObject:object];
                                 }
                             }
                             
                             NSArray *objectList = [MeinvModel modelObjectListWithArray:array];
                             success(@{@"meinvList":objectList});
                         }else
                         {
                             failure(code,msg,responseObject);
                         }
        
    } failure:^(NSString *errorCode,
                NSString *errorMsg,
                NSDictionary *responseObject) {
        
        failure(errorCode,errorMsg,responseObject);

    }];
}
@end
