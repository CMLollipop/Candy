//
//
//  AutomaticCoder
//
//  Created by caiming
//  Copyright (c) 2015年 cm. All rights reserved.
//

#import "MeinvModel.h"

NSString *const kMeinvModelMTitle = @"title";
NSString *const kMeinvModelMObjectId = @"objectId";
NSString *const kMeinvModelMDescription = @"description";
NSString *const kMeinvModelMUrl = @"url";
NSString *const kMeinvModelMPicUrl = @"picUrl";



@implementation MeinvModel

+ (NSArray*)modelObjectListWithArray:(NSArray *)arr
{
    NSMutableArray *array = [NSMutableArray array];

    if ([arr isKindOfClass:[NSArray class]]) {

        for (NSDictionary *dict in arr) {

            [array addObject:[MeinvModel modelObjectWithDictionary:dict]];
        }
    }

    return array;
}

+ (NSArray *)arrayWithModelObjectList:(NSArray *)arr
{
    NSMutableArray *array = [NSMutableArray array];
    
    if ([arr isKindOfClass:[NSArray class]]) {
        
        for (MeinvModel *model in arr) {
            
            [array addObject:[model dictionaryRepresentation]];
        }
    }
    return array;
}



+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (id)initWithDictionary:(NSDictionary *)json;
{
    self = [super init];

    if(self && [json isKindOfClass:[NSDictionary class]])
    {

        self.mTitle  = [self objectOrNilForKey:kMeinvModelMTitle fromDictionary:json];
 self.mObjectId  = [self objectOrNilForKey:kMeinvModelMObjectId fromDictionary:json];
 self.mDescription  = [self objectOrNilForKey:kMeinvModelMDescription fromDictionary:json];
 self.mUrl  = [self objectOrNilForKey:kMeinvModelMUrl fromDictionary:json];
 self.mPicUrl  = [self objectOrNilForKey:kMeinvModelMPicUrl fromDictionary:json];
 

    }

    return self;
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}

#pragma mark - description Method

- (NSString *)description
{
        return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];

    [mutableDict setValue:self.mTitle forKey:[self uppercaseFirstChar:kMeinvModelMTitle]];
    [mutableDict setValue:self.mObjectId forKey:[self uppercaseFirstChar:kMeinvModelMObjectId]];
    [mutableDict setValue:self.mDescription forKey:[self uppercaseFirstChar:kMeinvModelMDescription]];
    [mutableDict setValue:self.mUrl forKey:[self uppercaseFirstChar:kMeinvModelMUrl]];
    [mutableDict setValue:self.mPicUrl forKey:[self uppercaseFirstChar:kMeinvModelMPicUrl]];
    return [NSDictionary dictionaryWithDictionary:mutableDict];
}



-(NSString *)uppercaseFirstChar:(NSString *)str
{
    return [NSString stringWithFormat:@"m%@%@",[[str substringToIndex:1] uppercaseString],[str substringWithRange:NSMakeRange(1, str.length-1)]];
}

@end
