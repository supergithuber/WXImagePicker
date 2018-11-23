//
//  WXImageFetchOperation.m
//  WXImagePicker
//
//  Created by HFY on 2018/11/9.
//  Copyright © 2018年 wuxi. All rights reserved.
//

#import "WXImageFetchOperation.h"

typedef void(^WXImageResultHandler)(UIImage *image);

@interface WXImageFetchOperation ()
@property (nonatomic, assign) CGSize targetSize;
@property (nonatomic, assign) BOOL isHighQuality;
@property (nonatomic, copy) WXImageResultHandler resultHandler;
@end

@implementation WXImageFetchOperation

@synthesize executing = _executing;
@synthesize finished = _finished;


- (instancetype)initWithAsset:(PHAsset *)asset {
    self = [super init];
    if (self) {
        _asset = asset;
        _executing = NO;
        _finished = NO;
    }
    return self;
}

- (void)fetchImageWithTargetSize:(CGSize)size
                 needHighQuality:(BOOL)isHighQuality
               imageResutHandler:(void (^)(UIImage * _Nonnull))handler{
    self.targetSize = size;
    self.isHighQuality = isHighQuality;
    self.resultHandler = handler;
}
- (BOOL)isConcurrent {
    return YES;
}
@end
