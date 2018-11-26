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
    [self.sendButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

- (void)setupViews {
    _backGroudView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    _backGroudView.center = CGPointMake(_backGroudView.center.x, self.center.y);
    _backGroudView.backgroundColor = [UIColor wx_hexStringToColor:kSendButtonTintNormalColor];
    _backGroudView.layer.cornerRadius = _backGroudView.frame.size.height/2;
    [self addSubview:_backGroudView];
    
    _badgeValueLabel = [[UILabel alloc] initWithFrame:_backGroudView.frame];
    _badgeValueLabel.backgroundColor = [UIColor clearColor];
    _badgeValueLabel.textColor = [UIColor whiteColor];
    _badgeValueLabel.font = [UIFont systemFontOfSize:15.0f];
    _badgeValueLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_badgeValueLabel];
    
    _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _sendButton.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    [_sendButton setTitle:NSLocalizedStringFromTable(@"send", @"DNImagePicker", @"发送")
                 forState:UIControlStateNormal];
    [_sendButton setTitleColor:[UIColor wx_hexStringToColor:kSendButtonTintNormalColor] forState:UIControlStateNormal];
    [_sendButton setTitleColor:[UIColor wx_hexStringToColor:kSendButtonTintAbnormalColor] forState:UIControlStateHighlighted];
    [_sendButton setTitleColor:[UIColor wx_hexStringToColor:kSendButtonTintAbnormalColor] forState:UIControlStateDisabled];
    _sendButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    _sendButton.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    _sendButton.backgroundColor = [UIColor clearColor];
    [self addSubview:_sendButton];
}

- (void)setBadgeValue:(NSString *)badgeValue {
    CGRect rect = [badgeValue boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:kSendButtonFont} context:nil];
    self.badgeValueLabel.frame = CGRectMake(self.badgeValueLabel.frame.origin.x, self.badgeValueLabel.frame.origin.y, (rect.size.width + 9) > 20?(rect.size.width + 9):20, 20);
    self.backGroudView.bounds = CGRectMake(0, 0, self.badgeValueLabel.frame.size.width, self.badgeValueLabel.frame.size.height);
    
    CGRect buttonFrame = self.sendButton.frame;
    buttonFrame.size.width = self.badgeValueLabel.frame.size.width + kSendButtonTextWitdh;
    self.sendButton.frame = buttonFrame;
    
    CGRect frame = self.frame;
    frame.size.width = self.badgeValueLabel.frame.size.width + kSendButtonTextWitdh;
    self.frame = frame;
    
    self.badgeValueLabel.text = badgeValue;
    
    if (badgeValue.integerValue > 0) {
        [self showBadgeValue];
        self.backGroudView.transform =CGAffineTransformMakeScale(0, 0);
        [UIView animateWithDuration:0.2 animations:^{
            self.backGroudView.transform = CGAffineTransformMakeScale(1.1, 1.1);
        }
                         completion:^(BOOL finished){
                             [UIView animateWithDuration:0.1 animations:^{
                                 self.backGroudView.transform = CGAffineTransformMakeScale(1.0, 1.0);
                             }];
                         }];
        
    } else {
        [self hideBadgeValue];
    }
}
- (void)showBadgeValue
{
    self.badgeValueLabel.hidden = NO;
    self.backGroudView.hidden = NO;
}

- (void)hideBadgeValue
{
    self.badgeValueLabel.hidden = YES;
    self.backGroudView.hidden = YES;
    self.sendButton.adjustsImageWhenDisabled = YES;
}
@end
