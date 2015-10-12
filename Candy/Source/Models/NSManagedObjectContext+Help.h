//
//  NSManagedObjectContext+Help.h
//  Children
//
//  Created by caiming on 15/5/8.
//  Copyright (c) 2015年 caiming. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObjectContext (Help)

- (id)createEntity:(NSString *)entityName;

- (void)saveContext;

@end
