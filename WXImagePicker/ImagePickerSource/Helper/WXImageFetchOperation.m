//
//  WXImageFetchOperation.m
//  WXImagePicker
//
//  Created by HFY on 2018/11/9.
//  Copyright © 2018年 wuxi. All rights reserved.
//

#import "WXImageFetchOperation.h"

@interface WXImageFetchOperation ()

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

@end
