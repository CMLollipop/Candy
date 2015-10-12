//
//  ManageCoreData+Insert.m
//  Candy
//
//  Created by caiming on 15/10/12.
//  Copyright © 2015年 caiming. All rights reserved.
//


#define SuccessCode @"8888"

#import "ManageCoreData+Insert.h"
#import "NSManagedObject+EntityCreate.h"
#import "NSManagedObjectContext+Help.h"

@implementation ManageCoreData (Insert)

- (void)insertMeinvList:(NSArray *)objectList
                   type:(NSNumber *)type
           successBlock:(void(^)(NSDictionary *result))success
            failueBlock:(void(^)(NSDictionary *result))failue
{
    NSManagedObjectContext *moc = self.managedObjectContext;
    [moc performBlock:^{
        
        for (NSDictionary *dict in objectList) {
            NSManagedObject *entity = [moc createEntity:@"Meinv"];
            [entity setValuesForKeysWithDictionary:dict];
            [entity setValue:type forKey:@"mType"];
        }
        
        
        NSError *error;
        [moc save:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            success(@{SuccessCode:@"retunCode"});
            
        });
    }];
}

@end
