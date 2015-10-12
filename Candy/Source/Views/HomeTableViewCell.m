//
//  HomeTableViewCell.m
//  Candy
//
//  Created by caiming on 15/10/10.
//  Copyright © 2015年 caiming. All rights reserved.
//

#import "HomeTableViewCell.h"
#import <UIImageView+AFNetworking.h>

@interface HomeTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;

@end

@implementation HomeTableViewCell

- (void)awakeFromNib {
    // Initialization code
    UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onImageTap)];
    [_imageV addGestureRecognizer:tap];
    _imageV.userInteractionEnabled = YES;
}

- (void)onImageTap
{
    if ([self.delegate respondsToSelector:@selector(homeTableViewCellDidSelectImage:)]) {
        
        [self.delegate homeTableViewCellDidSelectImage:self];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)reloadData:(Meinv *)model
{
    _model = model;
    NSLog(@"%@",model.mDescription);
//    _imageV 
    _contentLab.numberOfLines = 0;
    _contentLab.text = model.mDescription;
    _titleLab.text = model.mTitle;
    [_contentLab sizeToFit];
    NSURL *url = [NSURL URLWithString:model.mPicUrl];
    [_imageV setImageWithURL:url placeholderImage:nil];
    _imageV.layer.masksToBounds = YES;
}

@end
