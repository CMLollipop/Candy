//
//  Core.h
//  Candy
//
//  Created by caiming on 15/10/9.
//  Copyright © 2015年 caiming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Core : NSObject

+ (id)share;


- (void)httpGetMeinvListWithNum:(NSNumber *)num
                   lastObjectId:(NSNumber *)objectId
                        success:(void(^)(NSDictionary *responseObject))success
                        failure:(void(^)(NSString *errorCode,
                                         NSString*errorMsg,
                                         NSDictionary*responseObject))failure;

- (void)httpGetTiyuListWithNum:(NSNumber *)num
                   lastObjectId:(NSNumber *)objectId
                        success:(void(^)(NSDictionary *responseObject))success
                        failure:(void(^)(NSString *errorCode,
                                         NSString*errorMsg,
                                         NSDictionary*responseObject))failure;

@end
