//
//  UITableView+FetchResult.h
//  Candy
//
//  Created by caiming on 15/10/12.
//  Copyright © 2015年 caiming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ManageCoreData.h"

@interface UITableView (FetchResult)<NSFetchedResultsControllerDelegate>

- (NSFetchedResultsController *)fetchResultWithEntityName:(NSString *)entityName predicate:(NSPredicate *)predicate SortDescriptors:(NSArray *)SortDescriptors;

@end
