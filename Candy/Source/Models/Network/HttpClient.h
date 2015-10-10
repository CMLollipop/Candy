//
//  HttpClient.h
//  Children
//
//  Created by caiming on 15/3/25.
//  Copyright (c) 2015年 caiming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpClient : NSObject

+ (id)share;

- (void)doGet:(NSString *)URLString
       params:(NSDictionary *)params
      success:(void(^)(NSDictionary *responseObject))success
      failure:(void(^)(NSString *errorCode,
                       NSString*errorMsg,
                       NSDictionary*responseObject))failure;

- (void)doPost:(NSString *)URLString
        params:(NSDictionary *)params
       success:(void(^)(NSDictionary *responseObject))success
       failure:(void(^)(NSString *errorCode,
                        NSString*errorMsg,
                        NSDictionary*responseObject))failure;


- (void)uploadResource:(NSString *)URLString
                params:(NSDictionary *)params
              resource:(NSArray *)resources
               success:(void(^)(NSDictionary *responseObject))success
               failure:(void(^)(NSString *errorCode,
                                NSString*errorMsg,
                                NSDictionary*responseObject))failure;

@end
