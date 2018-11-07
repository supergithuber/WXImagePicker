//
//  WXAlbumTableViewCell.m
//  WXImagePicker
//
//  Created by HFY on 2018/11/7.
//  Copyright © 2018年 wuxi. All rights reserved.
//

#import "WXAlbumTableViewCell.h"

@implementation WXAlbumTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self setupView];
        [self setupConstraints];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupView{
    _postImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _postImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.contentView addSubview:_postImageView];
    [self.contentView addSubview:_titleLabel];
}

- (void)setupConstraints{
    NSLayoutConstraint *imageWidthConstraint = [NSLayoutConstraint constraintWithItem:self.postImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:64.0];
    NSLayoutConstraint *imageHeightConstraint = [NSLayoutConstraint constraintWithItem:self.postImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:64.0];
    // 添加 left 约束
    NSLayoutConstraint *imageLeftConstraint = [NSLayoutConstraint constraintWithItem:self.postImageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10];
    [self.contentView addConstraint:imageLeftConstraint];
    // 添加 top 约束
    NSLayoutConstraint *imageTopConstraint = [NSLayoutConstraint constraintWithItem:self.postImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    [self.contentView addConstraint:imageTopConstraint];
    [self.postImageView addConstraints:@[imageWidthConstraint, imageHeightConstraint]];
}
@end
