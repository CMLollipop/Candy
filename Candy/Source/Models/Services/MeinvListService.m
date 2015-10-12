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
#import "ManageCoreData+Insert.h"

@implementation MeinvListService

- (void)getMeinvListWithParam:(NSDictionary *)param
                    success:(void(^)(NSDictionary *responseObject))success
                    failure:(void(^)(NSString *errorCode,
                                     NSString*errorMsg,
                                     NSDictionary*responseObject))failure
{
    NSMutableDictionary *mParam = param.mutableCopy;
    NSNumber *objectId = param[@"objectId"];
    NSNumber *num = param[@"num"];
    if (objectId) {
        [mParam removeObjectForKey:@"objectId"];
    }
    
    [[HttpClient share]doGet:@"http://apis.baidu.com/txapi/mvtp/meinv"
                      params:mParam
                     success:^(NSDictionary *responseObject) {
                         
                         NSString * code = [responseObject objectForKey:@"code"];
                         NSString * msg =  [responseObject objectForKey:@"msg"];
                         if (code.integerValue == 200) {
                             
                             NSMutableArray *array = [NSMutableArray array];
                             
                             long long objectNum = [NSDate date].timeIntervalSince1970;
                             if (objectId) {
                                 objectNum = objectId.longLongValue;
                             }
                             
                             for (NSInteger i = 0; i<num.integerValue; i++) {
                                 
                                 NSString *key = [NSString stringWithFormat:@"%li",(long)i];
                                 id object = [responseObject objectForKey:key];
                                 
                                 if ([object isKindOfClass:[NSDictionary class]]) {
                                     
                                     NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithDictionary:object];
                                     if (objectId) {
                                         
                                         objectNum--;
                                         [mDict setObject:@(objectNum) forKey:@"objectId"];
                                         
                                     }else
                                     {
                                         objectNum++;
                                         [mDict setObject:@(objectNum) forKey:@"objectId"];
                                     }
                                     
                                     [array addObject:mDict];
                                 }
                             }
                             
                             NSArray *objectList = [MeinvModel modelObjectListWithArray:array];
                             
                             [[ManageCoreData instance]insertMeinvList:[MeinvModel arrayWithModelObjectList:objectList] successBlock:^(NSDictionary *result)
                              {
                                  success(@{@"meinvList":objectList});

                             } failueBlock:^(NSDictionary *result) {
                                 
                                 
                             }];
                             
                             
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
