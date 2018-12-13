//
//  WXAssetCollectionViewCell.m
//  WXImagePicker
//
//  Created by HFY on 2018/12/7.
//  Copyright © 2018年 wuxi. All rights reserved.
//

#import "WXAssetCollectionViewCell.h"
#import "WXImagePickerHelper.h"

@interface WXAssetCollectionViewCell ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *checkButton;
@property (nonatomic, strong) UIImageView *checkImageView;

@end

@implementation WXAssetCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self setupView];
        [self addContentConstraint];
    }
    return self;
}

- (void)setupView {
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.checkButton];
    [self.contentView addSubview:self.checkImageView];
}

- (void)addContentConstraint {
    //imageView
    NSLayoutConstraint *imageConstraintsBottom = [NSLayoutConstraint
                                                  constraintWithItem:self.imageView
                                                  attribute:NSLayoutAttributeBottom
                                                  relatedBy:NSLayoutRelationEqual
                                                  toItem:self.contentView
                                                  attribute:NSLayoutAttributeBottom
                                                  multiplier:1.0f
                                                  constant:0];
    
    NSLayoutConstraint *imageConstraintsleading = [NSLayoutConstraint
                                                   constraintWithItem:self.imageView
                                                   attribute:NSLayoutAttributeLeading
                                                   relatedBy:NSLayoutRelationEqual
                                                   toItem:self.contentView
                                                   attribute:NSLayoutAttributeLeading
                                                   multiplier:1.0
                                                   constant:0];
    
    NSLayoutConstraint *imageContraintsTop = [NSLayoutConstraint
                                              constraintWithItem:self.imageView
                                              attribute:NSLayoutAttributeTop
                                              relatedBy:NSLayoutRelationEqual
                                              toItem:self.contentView
                                              attribute:NSLayoutAttributeTop
                                              multiplier:1.0
                                              constant:0];
    
    NSLayoutConstraint *imageViewConstraintTrailing = [NSLayoutConstraint
                                                       constraintWithItem:self.imageView
                                                       attribute:NSLayoutAttributeTrailing
                                                       relatedBy:NSLayoutRelationEqual
                                                       toItem:self.contentView
                                                       attribute:NSLayoutAttributeTrailing
                                                       multiplier:1.0
                                                       constant:0];
    
    [self addConstraints:@[imageConstraintsBottom,imageConstraintsleading,imageContraintsTop,imageViewConstraintTrailing]];
    //checkButton
    NSLayoutConstraint *checkConstraitRight = [NSLayoutConstraint
                                               constraintWithItem:self.checkButton
                                               attribute:NSLayoutAttributeTrailing
                                               relatedBy:NSLayoutRelationEqual
                                               toItem:self.contentView
                                               attribute:NSLayoutAttributeTrailing
                                               multiplier:1.0f
                                               constant:0];
    
    NSLayoutConstraint *checkConstraitTop = [NSLayoutConstraint
                                             constraintWithItem:self.checkButton
                                             attribute:NSLayoutAttributeTop
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.contentView
                                             attribute:NSLayoutAttributeTop
                                             multiplier:1.0f
                                             constant:0];
    
    NSLayoutConstraint *chekBtViewConsraintWidth = [NSLayoutConstraint
                                                    constraintWithItem:self.checkButton
                                                    attribute:NSLayoutAttributeWidth
                                                    relatedBy:NSLayoutRelationEqual
                                                    toItem:self.imageView
                                                    attribute:NSLayoutAttributeHeight
                                                    multiplier:0.5f
                                                    constant:0];
    
    NSLayoutConstraint *chekBtViewConsraintHeight = [NSLayoutConstraint
                                                     constraintWithItem:self.checkButton
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                     toItem:self.checkButton
                                                     attribute:NSLayoutAttributeWidth
                                                     multiplier:1.0
                                                     constant:0];
    
    [self.contentView addConstraints:@[checkConstraitRight,checkConstraitTop,chekBtViewConsraintWidth,chekBtViewConsraintHeight]];
    //checkImageView
    NSDictionary *checkImageViewMetric = @{@"sideLength":@25};
    NSString *checkImageViewVFLH = @"H:[_checkImageView(sideLength)]-3-|";
    NSString *checkImageVIewVFLV = @"V:|-3-[_checkImageView(sideLength)]";
    NSArray *checkImageConstraintsH = [NSLayoutConstraint constraintsWithVisualFormat:checkImageViewVFLH options:0 metrics:checkImageViewMetric views:NSDictionaryOfVariableBindings(_checkImageView)];
    NSArray *checkImageConstraintsV = [NSLayoutConstraint constraintsWithVisualFormat:checkImageVIewVFLV options:0 metrics:checkImageViewMetric views:NSDictionaryOfVariableBindings(_checkImageView)];
    
    [self.contentView addConstraints:checkImageConstraintsH];
    [self.contentView addConstraints:checkImageConstraintsV];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    if (self.asset){
        [WXImagePickerHelper cancelFetchWithAsset:self.asset];
    }
    _asset = nil;
    _isSelected = NO;
    _delegate = nil;
}

- (void)setupCellWithAsset:(WXAsset *)asset isSelected:(BOOL)isSelected{
    
}

//MARK: action
- (void)checkButtonAction:(id)sender {
    if (self.checkButton.selected) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(didDeselectItemAssetViewCell:)]) {
            [self.delegate didDeselectItemAssetViewCell:self];
        }
    } else {
        if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectItemAssetViewCell:)]) {
            [self.delegate didSelectItemAssetViewCell:self];
        }
    }
}

//MARK: Getter
- (UIImageView *)imageView {
    if (_imageView){
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [_imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    return _imageView;
}

- (UIButton *)checkButton {
    if (!_checkButton) {
        _checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_checkButton addTarget:self action:@selector(checkButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_checkButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    return _checkButton;
}

- (UIImageView *)checkImageView {
    if (!_checkImageView) {
        _checkImageView = [UIImageView new];
        _checkImageView.contentMode = UIViewContentModeScaleAspectFit;
        [_checkImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    return _checkImageView;
}
@end
