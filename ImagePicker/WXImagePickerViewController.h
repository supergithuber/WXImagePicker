//
//  WXImagePickerViewController.h
//  WXImagePicker
//
//  Created by Wuxi on 2018/11/6.
//  Copyright © 2018年 wuxi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, WXImagePickerFilterType) {
    WXImagePickerFilterTypeNone,
    WXImagePickerFilterTypePhotos,
    WXImagePickerFilterTypeVideos,
};
@class WXImagePickerController;
@protocol WXImagePickerControllerDelegate <NSObject>
@optional
/**
 *  imagePickerController‘s seleted photos
 *
 *  @param imagePickerController controller
 *  @param imageAssets           the seleted photos packaged DNAsset type instances
 *  @param originalImage             if the value is yes, the seleted photos is full image
 */
- (void)wxImagePickerController:(WXImagePickerController *)imagePickerController
                 selectedImages:(NSArray *)imageAssets
                isOriginalImage:(BOOL)originalImage;

- (void)wxImagePickerControllerDidCancel:(WXImagePickerController *)imagePickerController;
@end

@interface WXImagePickerViewController : UINavigationController

@property (nonatomic, assign) WXImagePickerFilterType filterType;
@property (nonatomic, weak) id<WXImagePickerControllerDelegate> imagePickerDelegate;

@end

NS_ASSUME_NONNULL_END
