//
//  WXImageFetchOperation.h
//  WXImagePicker
//
//  Created by HFY on 2018/11/9.
//  Copyright © 2018年 wuxi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class PHAsset;

NS_ASSUME_NONNULL_BEGIN

@interface WXImageFetchOperation : NSOperation

@property (nonatomic, strong, nullable, readonly) PHAsset *asset;

@property (assign, nonatomic, getter = isExecuting) BOOL executing;
@property (assign, nonatomic, getter = isFinished) BOOL finished;

@end

NS_ASSUME_NONNULL_END
