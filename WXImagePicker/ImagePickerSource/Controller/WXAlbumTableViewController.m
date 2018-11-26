//
//  WXAlbumTableViewController.m
//  WXImagePicker
//
//  Created by Wuxi on 2018/11/9.
//  Copyright © 2018年 wuxi. All rights reserved.
//

#import "WXAlbumTableViewController.h"
#import "UIViewController+NavigationBarItem.h"
#import "WXImagePickerViewController.h"
#import "WXImageCollectionViewController.h"
#import "WXImagePickerHelper.h"
#import "WXAlbumTableviewCell.h"
#import "WXAlbum.h"

static NSString* const wxAlbumTableViewCellReuseIdentifier = @"com.sivanwu.albumTableViewCellIdentifier";

@interface WXAlbumTableViewController ()

@property (nonatomic, strong) NSArray *albumArray;

@end

@implementation WXAlbumTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
    [self requestAlbum];
}

- (void)setupView {
    self.title = @"Album";
    [self createBarButtonItemAtPosition:WXNavigationBarPositionRight title:@"cancel" action:@selector(cancelAction:)];
    [self.tableView registerClass:[WXAlbumTableViewCell class] forCellReuseIdentifier:wxAlbumTableViewCellReuseIdentifier];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    self.tableView.tableFooterView = view;
}

- (void)requestAlbum {
    [WXImagePickerHelper requestAlbumListWithCompleteHandler:^(NSArray<WXAlbum *> * _Nonnull albumList) {
        if (albumList){
            self.albumArray = [albumList copy];
            [self.tableView reloadData];
        }
    }];
}

- (void)cancelAction:(id)sender {
    WXImagePickerViewController *navigationController = [self imagePickerViewController];
    if (navigationController && [navigationController.imagePickerDelegate respondsToSelector:@selector(wxImagePickerControllerDidCancel:)]){
        [navigationController.imagePickerDelegate wxImagePickerControllerDidCancel:navigationController];
    }
}

- (WXImagePickerViewController *)imagePickerViewController {
    if (!self.navigationController || ![self.navigationController isKindOfClass:[WXImagePickerViewController class]]){
        NSAssert(false, @"nil or error navigationController");
    }
    return (WXImagePickerViewController *)self.navigationController;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.albumArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WXAlbumTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:wxAlbumTableViewCellReuseIdentifier];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    WXAlbum *album = self.albumArray[indexPath.row];
    cell.titleLabel.attributedText = album.albumAttributedString;
    [album fetchImageWithImageSize:CGSizeMake(100, 100) imageResultHandler:^(UIImage * _Nonnull image) {
        if (image){
            cell.postImageView.image = image;
        }else{
            cell.postImageView.image = [UIImage imageNamed:@"placeholder_picture" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
        }
    }];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64;
}

//MARK: - tableview Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WXAlbum *album = self.albumArray[indexPath.row];
    WXImageCollectionViewController *controller = [[WXImageCollectionViewController alloc] initWithAlbum:album];
    [self.navigationController pushViewController:controller animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
