//
//  ManageCoreData.h
//  impressly
//
//  Created by caiming on 13-12-29.
//  Copyright (c) 2013年 com.impressly. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *CoreDataModelName = @"Candy";
static NSString *CoreDataStoreName  = @"Candy.sqlite";

@interface ManageCoreData : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;

@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

-(void)saveContext;
+(ManageCoreData*)instance;

//- (User *)fetchUserWithMoc:(NSManagedObjectContext *)moc;
//- (User *)findUserWithUserId:(NSNumber *)userId;
//
- (NSManagedObjectContext *)backgroundContext;
//
//- (NSSet *)createEntityList:(NSString *)entityName
//          entityInfoList:(NSArray *)entityInfoList; // 单纯创建，插入， 不查找


@end
