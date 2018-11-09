//
//  UIColor+Hex.h
//  WXImagePicker
//
//  Created by Wuxi on 2018/11/9.
//  Copyright © 2018年 wuxi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Hex)

+ (UIColor *)wx_hexStringToColor:(NSString *)stringToConvert;
+ (UIColor *)wx_colorWithHexNumber:(NSUInteger)hexColor;

@end

NS_ASSUME_NONNULL_END
