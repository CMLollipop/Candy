//
//  MeinvListService.h
//  Candy
//
//  Created by caiming on 15/10/10.
//  Copyright © 2015年 caiming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MeinvListService : NSObject

- (void)getMeinvListWithParam:(NSDictionary *)param
                    success:(void(^)(NSDictionary *responseObject))success
                    failure:(void(^)(NSString *errorCode,
                                     NSString*errorMsg,
                                     NSDictionary*responseObject))failure;

- (void)getTiyuListWithParam:(NSDictionary *)param
                      success:(void(^)(NSDictionary *responseObject))success
                      failure:(void(^)(NSString *errorCode,
                                       NSString*errorMsg,
                                       NSDictionary*responseObject))failure;



@end
