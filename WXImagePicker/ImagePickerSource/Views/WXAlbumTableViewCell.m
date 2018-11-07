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
    [self.postImageView addConstraints:@[imageWidthConstraint, imageHeightConstraint]];
    NSLayoutConstraint *imageLeftConstraint = [NSLayoutConstraint constraintWithItem:self.postImageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10];
    NSLayoutConstraint *imageTopConstraint = [NSLayoutConstraint constraintWithItem:self.postImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    [self.contentView addConstraints:@[imageLeftConstraint, imageTopConstraint]];
    
    NSLayoutConstraint *labelWidthConstraint = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:230.0];
    NSLayoutConstraint *labelHeightConstraint = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:64.0];
    [self.titleLabel addConstraints:@[labelWidthConstraint, labelHeightConstraint]];
    NSLayoutConstraint *labelLeftConstraint = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.postImageView attribute:NSLayoutAttributeRight multiplier:1.0 constant:10];
    NSLayoutConstraint *labelTopConstraint = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    [self.contentView addConstraints:@[labelLeftConstraint, labelTopConstraint]];
}
@end
