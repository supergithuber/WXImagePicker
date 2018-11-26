//
//  WXSendButton.h
//  WXImagePicker
//
//  Created by HFY on 2018/11/26.
//  Copyright © 2018年 wuxi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WXSendButton : UIView

@property (nonatomic, copy) NSString *badgeValue;

- (instancetype)initWithFrame:(CGRect)frame;

- (void)addTaget:(id)target action:(SEL)action;

@end

NS_ASSUME_NONNULL_END
