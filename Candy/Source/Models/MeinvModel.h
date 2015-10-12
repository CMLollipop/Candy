//
//  
//  AutomaticCoder
//
//  Created by caiming
//  Copyright (c) 2015年 cm. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface MeinvModel : NSObject

@property (nonatomic,strong) NSString *mTitle;
@property (nonatomic,strong) NSNumber *mObjectId;
@property (nonatomic,strong) NSString *mDescription;
@property (nonatomic,strong) NSString *mUrl;
@property (nonatomic,strong) NSString *mPicUrl;
 

+ (NSArray *)modelObjectListWithArray:(NSArray *)array;
+ (NSArray *)arrayWithModelObjectList:(NSArray *)array;
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
