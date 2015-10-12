//
//  NSManagedObject+EntityCreate.m
//  Children
//
//  Created by caiming on 15/4/12.
//  Copyright (c) 2015年 caiming. All rights reserved.
//

#import "NSManagedObject+EntityCreate.h"
#import "NSManagedObjectContext+Help.h"
//#import <objc/runtime.h>

@implementation NSManagedObject (EntityCreate)

-(id)createEntity:(NSString *)entityName
{
    id obj = [self.managedObjectContext createEntity:entityName];
    
    return obj;
}


- (NSArray *)allKeys
{
    return [[[self entity]attributesByName]allKeys];
    
}

- (NSArray *)commonKeys:(NSArray *)keys
{
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSString *key in [self allKeys]) {
        
        if ([keys containsObject:key]) {
            
            [array addObject:key];
        }
    }
    return array.copy;
}

- (void)setValuesForKeysWithDictionary:(NSDictionary *)keyedValues
{
    NSArray *keys = [self commonKeys:[keyedValues allKeys]];
    NSDictionary *commonInfo = [keyedValues dictionaryWithValuesForKeys:keys];
    [super setValuesForKeysWithDictionary:commonInfo];
}

@end
