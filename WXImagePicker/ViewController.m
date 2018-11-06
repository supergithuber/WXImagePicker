//
//  ViewController.m
//  WXImagePicker
//
//  Created by Wuxi on 2018/11/6.
//  Copyright © 2018年 wuxi. All rights reserved.
//

#import "ViewController.h"
#import "WXImagePickerViewController.h"

@interface ViewController ()<WXImagePickerControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)setupView {
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 200, 100);
    button.center = CGPointMake(CGRectGetWidth(self.view.bounds) / 2.0, CGRectGetHeight(self.view.bounds) / 2.0);
    [button setTitle:@"open Album" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(openAlbum:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor redColor];
    button.layer.cornerRadius = 4;
    button.layer.masksToBounds = YES;
    [self.view addSubview:button];
}

- (void)openAlbum:(UIButton *)sender{
    WXImagePickerViewController *imagePicker = [[WXImagePickerViewController alloc] init];
    imagePicker.imagePickerDelegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

//MARK: - WXImagePickerControllerDelegate
- (void)wxImagePickerController:(WXImagePickerViewController *)imagePickerController
                 selectedImages:(NSArray *)imageAssets
                isOriginalImage:(BOOL)originalImage{
    
}
- (void)wxImagePickerControllerDidCancel:(WXImagePickerViewController *)imagePickerController{
    
}

@end
