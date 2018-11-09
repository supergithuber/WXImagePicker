//
//  UIViewController+NavigationBarItem.m
//  WXImagePicker
//
//  Created by Wuxi on 2018/11/9.
//  Copyright © 2018年 wuxi. All rights reserved.
//

#import "UIViewController+NavigationBarItem.h"
#import "UIColor+Hex.h"

@implementation UIViewController (NavigationBarItem)

- (void)createBarButtonItemAtPosition:(WXNavigationBarPosition)position
                          normalImage:(UIImage *)normalImage
                     highlightedImage:(UIImage *)highlightedImage
                               action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIEdgeInsets insets = UIEdgeInsetsZero;
    switch (position) {
        case WXNavigationBarPositionLeft:
            insets = UIEdgeInsetsMake(0, -20, 0, 20);
            break;
        case WXNavigationBarPositionRight:
            insets = UIEdgeInsetsMake(0, 13, 0, -13);
            break;
        default:
            break;
    }
    
    [button setImageEdgeInsets:insets];
    [button setFrame:CGRectMake(0, 0, 44, 44)];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [button setImage:normalImage forState:UIControlStateNormal];
    [button setImage:highlightedImage forState:UIControlStateHighlighted];
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    switch (position) {
        case WXNavigationBarPositionLeft:
            self.navigationItem.leftBarButtonItem = barButtonItem;
            break;
        case WXNavigationBarPositionRight:
            self.navigationItem.rightBarButtonItem = barButtonItem;
            break;
        default:
            break;
    }
}
- (void)createBarButtonItemAtPosition:(WXNavigationBarPosition)position
                                title:(NSString *)title
                               action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIEdgeInsets insets = UIEdgeInsetsZero;
    switch (position) {
        case WXNavigationBarPositionLeft:
            insets = UIEdgeInsetsMake(0, -49 + 26, 0, 19);
            break;
        case WXNavigationBarPositionRight:
            insets = UIEdgeInsetsMake(0, 49 - 26, 0, -19);
            break;
        default:
            break;
    }
    
    [button setTitleEdgeInsets:insets];
    [button setFrame:CGRectMake(0, 0, 64, 30)];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor wx_hexStringToColor:@"#808080"] forState:UIControlStateHighlighted];
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    switch (position) {
        case WXNavigationBarPositionLeft:
            self.navigationItem.leftBarButtonItem = barButtonItem;
            break;
        case WXNavigationBarPositionRight:
            self.navigationItem.rightBarButtonItem = barButtonItem;
            break;
        default:
            break;
    }
}
- (void)createBackBarButtonItemWithNormalImage:(UIImage *)normalImage
                              highlightedImage:(UIImage *)highlightedImage
                                         title:(NSString *)title
                                        action:(SEL)action {
    
}
@end
