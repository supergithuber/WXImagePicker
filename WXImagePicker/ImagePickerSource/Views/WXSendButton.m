//
//  WXSendButton.m
//  WXImagePicker
//
//  Created by HFY on 2018/11/26.
//  Copyright © 2018年 wuxi. All rights reserved.
//

#import "WXSendButton.h"
#import "UIColor+Hex.h"

#define kSendButtonFont  [UIFont systemFontOfSize:15]

static NSString *const kSendButtonTintNormalColor = @"#1FB823";
static NSString *const kSendButtonTintAbnormalColor = @"#C9EFCA";

static CGFloat const kSendButtonTextWitdh = 38.0f;


@interface WXSendButton ()

@property (nonatomic, strong) UIButton *sendButton;
@property (nonatomic, strong) UILabel *badgeValueLabel;
@property (nonatomic, strong) UIView *backGroudView;

@end

@implementation WXSendButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(0, 0, 58, 26);
        [self setupViews];
        self.badgeValue = @"0";
    }
    return self;
}

- (void)addTaget:(id)target action:(SEL)action {
    [self.sendButton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
}

- (void)setupViews {
    
}

@end
