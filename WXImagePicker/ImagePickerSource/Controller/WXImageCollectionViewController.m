//
//  WXImageCollectionViewController.m
//  WXImagePicker
//
//  Created by Wuxi on 2018/11/9.
//  Copyright © 2018年 wuxi. All rights reserved.
//

#import "WXImageCollectionViewController.h"
#import "UIViewController+NavigationBarItem.h"
#import "WXPhotoBrowserController.h"
#import "WXImagePickerViewController.h"
#import "WXSendButton.h"
#import "WXAssetCollectionViewCell.h"

@interface WXImageCollectionViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, WXAssetCollectionViewCellDelegate>
//init
@property (nonatomic, strong)WXAlbum *album;
@property (nonatomic, copy)NSString *albumIdentifier;
//data
@property (nonatomic, strong)NSMutableArray *assetsArray;
@property (nonatomic, strong)NSMutableArray *selectedAssetsArray;
//view
@property (nonatomic, strong)WXSendButton *sendButton;
@property (nonatomic, strong)UICollectionView *imageFlowCollectionView;
@end


static NSString* const kAssetCollectionViewCellReuseIdentifier = @"kAssetCollectionViewCell";

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
    
    [self.view addSubview:self.imageFlowCollectionView];
    
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

//MARK: get
#define kSizeThumbnailCollectionView  ([UIScreen mainScreen].bounds.size.width-10)/4
- (UICollectionView *)imageFlowCollectionView {
    if (!_imageFlowCollectionView){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 2.0;
        layout.minimumInteritemSpacing = 2.0;
        layout.itemSize = CGSizeMake(kSizeThumbnailCollectionView, kSizeThumbnailCollectionView);
        layout.sectionInset = UIEdgeInsetsMake(2, 2, 2, 2);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _imageFlowCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) collectionViewLayout:layout];
        _imageFlowCollectionView.backgroundColor = [UIColor clearColor];
        [_imageFlowCollectionView registerClass:[WXAssetCollectionViewCell class] forCellWithReuseIdentifier:kAssetCollectionViewCellReuseIdentifier];
        _imageFlowCollectionView.alwaysBounceVertical = YES;
        _imageFlowCollectionView.delegate = self;
        _imageFlowCollectionView.dataSource = self;
        _imageFlowCollectionView.showsHorizontalScrollIndicator = YES;
    }
    return _imageFlowCollectionView;
}

//MARK: dataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section{
    return self.assetsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WXAssetCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kAssetCollectionViewCellReuseIdentifier
                                                                                forIndexPath:indexPath];
    WXAsset *asset = self.assetsArray[indexPath.row];
    cell.delegate = self;
    [cell setupCellWithAsset:asset isSelected:[self.selectedAssetsArray containsObject:asset]];
    return cell;
}

//MARK: delegate
- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

//MARK: WXAssetCollectionViewCellDelegate


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
