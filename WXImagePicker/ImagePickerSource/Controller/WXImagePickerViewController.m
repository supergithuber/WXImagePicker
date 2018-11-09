//
//  WXImagePickerViewController.m
//  WXImagePicker
//
//  Created by Wuxi on 2018/11/6.
//  Copyright © 2018年 wuxi. All rights reserved.
//

#import "WXImagePickerViewController.h"
#import "WXAlbumTableViewController.h"
#import "WXImageCollectionViewController.h"

@interface WXImagePickerViewController ()<UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, assign) BOOL isDuringPushAnimation;

@end

@implementation WXImagePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!self.delegate) {
        self.delegate = self;
    }
    self.interactivePopGestureRecognizer.delegate = self;
    
    [self showAlbumViewController];
}

- (void)showAlbumViewController {
    WXAlbumTableViewController *albumViewController = [WXAlbumTableViewController new];
    [self setViewControllers:@[albumViewController]];
}

//MARK: - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        return [self.viewControllers count] > 1 && !self.isDuringPushAnimation;
    } else {
        return YES;
    }
}

@end
