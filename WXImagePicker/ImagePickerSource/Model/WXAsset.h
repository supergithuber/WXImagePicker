//
//  WXAsset.h
//  WXImagePicker
//
//  Created by Wuxi on 2018/11/7.
//  Copyright © 2018年 wuxi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class PHAsset;

@interface WXAsset : NSObject

@property (nonatomic, copy)NSString *assetIdentifier;
@property (nonatomic, strong, readonly)PHAsset *asset;

+ (instancetype)initWithAsset:(PHAsset *)asset;

@end

NS_ASSUME_NONNULL_END
