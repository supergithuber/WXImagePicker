//
//  WXAlbum.m
//  WXImagePicker
//
//  Created by Wuxi on 2018/11/7.
//  Copyright © 2018年 wuxi. All rights reserved.
//

#import "WXAlbum.h"
#import <Photos/Photos.h>
#import "WXImagePickerHelper.h"
#import "WXAsset.h"

@interface WXAlbum()

@property (nonatomic, strong) NSAttributedString *albumAttributedString;

@end

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

- (void)fetchImageWithImageSize:(CGSize)size
             imageResultHandler:(void (^)(UIImage * _Nonnull))handler {
    [WXImagePickerHelper fetchImageWithAsset:[WXAsset assetWithPHAsset:self.results.lastObject]
                                  targetSize:size
                           imageResutHandler:^(UIImage * _Nonnull image) {
                               handler(image);
    }];
}

- (NSAttributedString *)albumAttributedString {
    if (!_albumAttributedString) {
        NSString *numberString = [NSString stringWithFormat:@"  (%@)",@(self.count)];
        NSString *cellTitleString = [NSString stringWithFormat:@"%@%@",self.albumTitle,numberString];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:cellTitleString];
        [attributedString setAttributes: @{
                                           NSFontAttributeName : [UIFont systemFontOfSize:16.0f],
                                           NSForegroundColorAttributeName : [UIColor blackColor],
                                           }
                                  range:NSMakeRange(0, self.albumTitle.length)];
        [attributedString setAttributes:@{
                                          NSFontAttributeName : [UIFont systemFontOfSize:16.0f],
                                          NSForegroundColorAttributeName : [UIColor grayColor],
                                          } range:NSMakeRange(self.albumTitle.length, numberString.length)];
        _albumAttributedString = attributedString;
    }
    return _albumAttributedString;
}
@end
