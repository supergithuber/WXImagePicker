//
//  WXImageCollectionViewController.m
//  WXImagePicker
//
//  Created by Wuxi on 2018/11/9.
//  Copyright © 2018年 wuxi. All rights reserved.
//

#import "WXImageCollectionViewController.h"
#import "UIViewController+NavigationBarItem.h"

@interface WXImageCollectionViewController ()

@property (nonatomic, strong)WXAlbum *album;
@property (nonatomic, copy)NSString *albumIdentifier;

@property (nonatomic, strong)NSMutableArray *assetsArray;
@property (nonatomic, strong)NSMutableArray *selectedAssetsArray;

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
}

//MARK: - button Action
- (void)backButtonAction:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
