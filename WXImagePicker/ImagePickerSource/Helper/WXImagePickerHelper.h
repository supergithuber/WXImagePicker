//
//  WXImagePickerHelper.h
//  WXImagePicker
//
//  Created by Wuxi on 2018/11/7.
//  Copyright © 2018年 wuxi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class WXAlbum;
@class WXAsset;

@interface WXImagePickerHelper : NSObject

+ (instancetype)sharedInstance;

/**
 get album list
 */
+ (void)requestAlbumListWithCompleteHandler:(void (^)(NSArray<WXAlbum *> *))completeHandelr;

//根据asset获取image资源
+ (void)fetchImageSizeWithAsset:(WXAsset *)asset
         imageSizeCompletionHandler:(void (^)(CGFloat sizeInBytes, NSString * sizeString))handler;

+ (void)fetchImageWithAsset:(WXAsset *)asset
                 targetSize:(CGSize)targetSize
          imageResutHandler:(void (^)(UIImage *))handler;

+ (void)fetchImageWithAsset:(WXAsset *)asset
                 targetSize:(CGSize)targetSize
            needHighQuality:(BOOL)isHighQuality
          imageResutHandler:(void (^)(UIImage * image))handler;
@end

NS_ASSUME_NONNULL_END
