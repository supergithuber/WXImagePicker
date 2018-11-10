//
//  WXAlbum.h
//  WXImagePicker
//
//  Created by Wuxi on 2018/11/7.
//  Copyright © 2018年 wuxi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class PHAssetCollection;
@class PHFetchResult;

NS_ASSUME_NONNULL_BEGIN

@interface WXAlbum : NSObject

@property (nonatomic, strong, nullable) PHFetchResult *results;

@property (nonatomic, copy, nullable) NSString *identifier;

@property (nonatomic, copy, nullable) NSString *albumTitle;

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, readonly, nullable) NSAttributedString *albumAttributedString;

+ (instancetype)albumWithAssetCollection:(PHAssetCollection *)collection
                                 results:(PHFetchResult *)results;
//获取代表相册的缩略图
- (void)fetchImageWithImageSize:(CGSize)size
             imageResultHandler:(void(^)(UIImage *))handler;
@end

NS_ASSUME_NONNULL_END
