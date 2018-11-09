//
//  UIViewController+NavigationBarItem.h
//  WXImagePicker
//
//  Created by Wuxi on 2018/11/9.
//  Copyright © 2018年 wuxi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, WXNavigationBarPosition) {
    WXNavigationBarPositionLeft,
    WXNavigationBarPositionRight,
};

@interface UIViewController (NavigationBarItem)

//给位置，普通图，高亮图，方法
- (void)createBarButtonItemAtPosition:(WXNavigationBarPosition)position
                          normalImage:(UIImage *)normalImage
                     highlightedImage:(UIImage *)highlightedImage
                               action:(SEL)action;
//给位置，标题，方法
- (void)createBarButtonItemAtPosition:(WXNavigationBarPosition)position
                                title:(NSString *)title
                               action:(SEL)action;
//返回按钮普通图，高亮图，标题，方法
- (void)createBackBarButtonItemWithNormalImage:(UIImage *)normalImage
                              highlightedImage:(UIImage *)highlightedImage
                                         title:(NSString *)title
                                        action:(SEL)action;
@end

NS_ASSUME_NONNULL_END
