//
//  WXImageFetchOperation.m
//  WXImagePicker
//
//  Created by HFY on 2018/11/9.
//  Copyright © 2018年 wuxi. All rights reserved.
//

#import "WXImageFetchOperation.h"
#import <Photos/PHAsset.h>
#import <Photos/PHImageManager.h>

typedef void(^WXImageResultHandler)(UIImage *image);

@interface WXImageFetchOperation ()

@property (nonatomic, assign) CGSize targetSize;
@property (nonatomic, assign) BOOL isHighQuality;
@property (nonatomic, copy) WXImageResultHandler resultHandler;
@property (nonatomic, strong, nullable) PHAsset *asset;
@property (nonatomic, assign) PHImageRequestID requestID;

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

- (void)start{
    @synchronized (self) {
        if (self.isCancelled || !self.asset){
            self.finished = YES;
            [self reset];
            return;
        }
        PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
        if (self.isHighQuality) {
            options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
        } else {
            options.resizeMode = PHImageRequestOptionsResizeModeExact;
        }
        self.requestID = [[PHImageManager defaultManager] requestImageForAsset:self.asset targetSize:self.targetSize contentMode:PHImageContentModeAspectFill options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (self.resultHandler) {
                    self.resultHandler(result);
                }
                [self done];
            });
        }];
        self.executing = YES;
    }
}

- (void)cancel {
    @synchronized (self) {
        if (self.isFinished) return;
        [super cancel];
        
        if (self.asset && self.requestID != PHInvalidImageRequestID) {
            [[PHCachingImageManager defaultManager] cancelImageRequest:self.requestID];
            if (self.isExecuting) self.executing = NO;
            if (!self.isFinished) self.finished = YES;
        }
        [self reset];
    }
}

- (void)done {
    self.finished = YES;
    self.executing = NO;
    [self reset];
}

- (void)reset {
    self.asset = nil;
}

- (BOOL)isConcurrent {
    return YES;
}

- (void)setFinished:(BOOL)finished {
    [self willChangeValueForKey:@"isFinished"];
    _finished = finished;
    [self didChangeValueForKey:@"isFinished"];
}

- (void)setExecuting:(BOOL)executing {
    [self willChangeValueForKey:@"isExecuting"];
    _executing = executing;
    [self didChangeValueForKey:@"isExecuting"];
}
@end
