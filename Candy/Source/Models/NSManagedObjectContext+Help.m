//
//  NSManagedObjectContext+Help.m
//  Children
//
//  Created by caiming on 15/5/8.
//  Copyright (c) 2015年 caiming. All rights reserved.
//

#import "NSManagedObjectContext+Help.h"

@implementation NSManagedObjectContext (Help)

- (id)createEntity:(NSString *)entityName
{
    return [NSEntityDescription insertNewObjectForEntityForName:entityName
                                         inManagedObjectContext:self];
}

- (void)saveContext
{
    NSError *error ;
    if ([self hasChanges] && [self save:&error]) {
        
    }
}


@end
