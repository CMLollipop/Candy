//
//  Meinv+CoreDataProperties.h
//  Candy
//
//  Created by caiming on 15/10/12.
//  Copyright © 2015年 caiming. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Meinv.h"

NS_ASSUME_NONNULL_BEGIN

@interface Meinv (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *mDescription;
@property (nullable, nonatomic, retain) NSNumber *mObjectId;
@property (nullable, nonatomic, retain) NSString *mPicUrl;
@property (nullable, nonatomic, retain) NSString *mTitle;
@property (nullable, nonatomic, retain) NSString *mUrl;
@property (nullable, nonatomic, retain) NSNumber *mType;

@end

NS_ASSUME_NONNULL_END
