//
//  WXImageCollectionViewController.h
//  WXImagePicker
//
//  Created by Wuxi on 2018/11/9.
//  Copyright © 2018年 wuxi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WXAlbum;
NS_ASSUME_NONNULL_BEGIN

@interface WXImageCollectionViewController : UIViewController

- (instancetype)initWithAlbumIdentifier:(NSString *)identifier;

- (instancetype)initWithAlbum:(WXAlbum *)album;

@end

NS_ASSUME_NONNULL_END
