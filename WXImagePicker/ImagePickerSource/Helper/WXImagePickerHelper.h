//
//  WXImagePickerHelper.h
//  WXImagePicker
//
//  Created by Wuxi on 2018/11/7.
//  Copyright © 2018年 wuxi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class WXAlbum;

@interface WXImagePickerHelper : NSObject

+ (instancetype)sharedInstance;

/**
 get album list
 */
+ (void)requestAlbumListWithCompleteHandler:(void (^)(NSArray<WXAlbum *> *))completeHandelr;
@end

NS_ASSUME_NONNULL_END
