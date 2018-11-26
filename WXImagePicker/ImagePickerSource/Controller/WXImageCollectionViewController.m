//
//  WXImageCollectionViewController.m
//  WXImagePicker
//
//  Created by Wuxi on 2018/11/9.
//  Copyright © 2018年 wuxi. All rights reserved.
//

#import "WXImageCollectionViewController.h"
#import "UIViewController+NavigationBarItem.h"
#import "WXImagePickerViewController.h"
#import "WXSendButton.h"

@interface WXImageCollectionViewController ()
//init
@property (nonatomic, strong)WXAlbum *album;
@property (nonatomic, copy)NSString *albumIdentifier;
//data
@property (nonatomic, strong)NSMutableArray *assetsArray;
@property (nonatomic, strong)NSMutableArray *selectedAssetsArray;
//view
@property (nonatomic, strong)WXSendButton *sendButton;
@end

@implementation WXImageCollectionViewController


- (instancetype)initWithAlbumIdentifier:(NSString *)identifier {
    self = [super init];
    if (self){
        _assetsArray = [NSMutableArray array];
        _selectedAssetsArray = [NSMutableArray array];
        _albumIdentifier = identifier;
    }
    return self;
}

- (instancetype)initWithAlbum:(WXAlbum *)album {
    self = [super init];
    if (self){
        _assetsArray = [NSMutableArray array];
        _selectedAssetsArray = [NSMutableArray array];
        _album = album;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)setupView {
    self.view.backgroundColor = [UIColor whiteColor];
    [self createBarButtonItemAtPosition:WXNavigationBarPositionLeft
                            normalImage:[UIImage imageNamed:@"back_normal" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil]
                       highlightedImage:[UIImage imageNamed:@"back_highlight" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil]
                                 action:@selector(backButtonAction:)];
    [self createBarButtonItemAtPosition:WXNavigationBarPositionRight
                                  title:@"取消"
                                 action:@selector(cancelAction:)];
    [self setupToolBar];
}

- (void)setupToolBar {
    UIBarButtonItem *previewButton = [[UIBarButtonItem alloc] initWithTitle:@"预览"
                                                                      style:UIBarButtonItemStylePlain
                                                                     target:self
                                                                     action:@selector(previewAction:)];
    [previewButton setTintColor:[UIColor blackColor]];
    previewButton.enabled = NO;
    
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *item3 = [[UIBarButtonItem alloc] initWithCustomView:self.sendButton];
    
    UIBarButtonItem *item4 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    item4.width = -10;
    [self setToolbarItems:@[previewButton, item2, item3, item4] animated:NO];
    
}

//MARK: - button Action
- (void)backButtonAction:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)cancelAction:(UIBarButtonItem *)sender {
    WXImagePickerViewController * controller = [self wxImagePickerController];
    if (controller && [controller.imagePickerDelegate respondsToSelector:@selector(wxImagePickerControllerDidCancel:)]){
        [controller.imagePickerDelegate wxImagePickerControllerDidCancel:controller];
    }
}
- (void)previewAction:(UIBarButtonItem *)sender {
    
}

//MARK: help
- (WXImagePickerViewController *)wxImagePickerController {
    if (!self.navigationController
        ||
        ![self.navigationController isKindOfClass:[WXImagePickerViewController class]])
    {
        NSAssert(false, @"check the navigation controller");
    }
    return (WXImagePickerViewController *)self.navigationController;
}
@end
