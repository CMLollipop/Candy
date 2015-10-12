//
//  HomeTableViewCell.h
//  Candy
//
//  Created by caiming on 15/10/10.
//  Copyright © 2015年 caiming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Meinv.h"

@class HomeTableViewCell;
@protocol HomeTableViewCellDelegate <NSObject>

- (void)homeTableViewCellDidSelectImage:(HomeTableViewCell *)cell;

@end

@interface HomeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property(nonatomic,weak)id<HomeTableViewCellDelegate> delegate;
@property(nonatomic,strong)Meinv *model;

- (void)reloadData:(Meinv *)model;


@end

