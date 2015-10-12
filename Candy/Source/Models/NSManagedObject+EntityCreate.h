//
//  NSManagedObject+EntityCreate.h
//  Children
//
//  Created by caiming on 15/4/12.
//  Copyright (c) 2015年 caiming. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (EntityCreate)

- (id)createEntity:(NSString *)entityName;
//- (NSArray *)allKeys;
//- (NSArray *)commonKeys:(NSArray *)keys;

- (void)setValuesForKeysWithDictionary:(NSDictionary *)keyedValues;

@end
