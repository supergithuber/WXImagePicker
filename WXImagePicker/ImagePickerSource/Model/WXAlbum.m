//
//  WXAlbum.m
//  WXImagePicker
//
//  Created by Wuxi on 2018/11/7.
//  Copyright © 2018年 wuxi. All rights reserved.
//

#import "WXAlbum.h"
#import <Photos/Photos.h>

@implementation WXAlbum

- (instancetype)init {
    self = [super init];
    if (self) {
        _albumTitle = @"";
        _identifier = @"";
        _count = 0;
    }
    return self;
}

+ (instancetype)albumWithAssetCollection:(PHAssetCollection *)collection results:(PHFetchResult *)results{
    WXAlbum *album = [[WXAlbum alloc] init];
    if (!collection || !results) {
        return album;
    }
    album.count = results.count;
    album.results = results;
    album.albumTitle = collection.localizedTitle;
    album.identifier = collection.localIdentifier;
    return album;
}

@end
