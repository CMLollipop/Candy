//
//  HomeTableViewCell.h
//  Candy
//
//  Created by caiming on 15/10/10.
//  Copyright © 2015年 caiming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MeinvModel.h"

@interface HomeTableViewCell : UITableViewCell

- (void)reloadData:(MeinvModel *)model;

@end
