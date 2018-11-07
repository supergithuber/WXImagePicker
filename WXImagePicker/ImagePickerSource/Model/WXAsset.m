//
//  WXAsset.m
//  WXImagePicker
//
//  Created by HFY on 2018/11/7.
//  Copyright © 2018年 wuxi. All rights reserved.
//

#import <Photos/Photos.h>
#import "WXAsset.h"

@interface WXAsset ()
@property (nonatomic, strong, nullable) PHAsset *asset;
@end

@implementation WXAsset

- (instancetype)init{
    self = [super init];
    return self;
}

+ (instancetype)initWithAsset:(PHAsset *)asset{
    WXAsset *a = [[WXAsset alloc] init];
    if (!asset) {
        return a;
    }
    a.asset = asset;
    a.assetIdentifier = asset.localIdentifier;
    return a;
}

@end
