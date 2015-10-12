//
//  ManageCoreData+Insert.h
//  Candy
//
//  Created by caiming on 15/10/12.
//  Copyright © 2015年 caiming. All rights reserved.
//

#import "ManageCoreData.h"

@interface ManageCoreData (Insert)

- (void)insertMeinvList:(NSArray *)objectList
           successBlock:(void(^)(NSDictionary *result))success
           failueBlock:(void(^)(NSDictionary *result))failue;


@end
