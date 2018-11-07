//
//  WXImagePickerHelper.m
//  WXImagePicker
//
//  Created by HFY on 2018/11/7.
//  Copyright © 2018年 wuxi. All rights reserved.
//

#import "WXImagePickerHelper.h"
#import <Photos/Photos.h>
#import "WXAlbum.h"
#import "WXAsset.h"

static NSString *const kLastAlbumIdentifierKey = @"com.sivanwu.lastAlbumIdentifier";
static dispatch_queue_t imageFetchQueue() {
    static dispatch_queue_t queue = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = dispatch_queue_create("com.sivanwu.imageFetchQueue", DISPATCH_QUEUE_SERIAL);
    });
    return queue;
}

@implementation WXImagePickerHelper

+ (instancetype)sharedInstance{
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}
- (instancetype)init{
    self = [super init];
    
    return self;
}

+ (void)requestAlbumListWithCompleteHandler:(void (^)(NSArray<WXAlbum *> *))completeHandelr {
    dispatch_block_t block = ^{
        NSMutableArray *albums = [NSMutableArray arrayWithArray:[self fetchAlbumsResults]];
        if (!albums) {
            completeHandelr(nil);
            return;
        }
        PHFetchOptions *userAlbumsOptions = [[PHFetchOptions alloc] init];
        userAlbumsOptions.predicate = [NSPredicate predicateWithFormat:@"mediaType = %@",@(PHAssetMediaTypeImage)];
        userAlbumsOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
        
        NSMutableArray *list = [NSMutableArray array];
        for (PHFetchResult *result in albums) {
            [result enumerateObjectsUsingBlock:^(PHAssetCollection *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                PHFetchResult *assetResults = [PHAsset fetchAssetsInAssetCollection:obj options:userAlbumsOptions];
                NSInteger count = 0;
                switch (obj.assetCollectionType) {
                    case PHAssetCollectionTypeAlbum:
                    case PHAssetCollectionTypeSmartAlbum:
                        count = assetResults.count;
                        break;
                    default:
                        count = 0;
                        break;
                }
                if (count > 0) {
                    @autoreleasepool {
                        WXAlbum *album = [WXAlbum albumWithAssetCollection:obj results:assetResults];
                        [list addObject:album];
                    }
                }
            }];
        }
        
    };
    dispatch_async(imageFetchQueue(), block);
}

//获取相册列表
+ (NSArray *)fetchAlbumsResults {
    PHFetchOptions *userAlbumsOptions = [[PHFetchOptions alloc] init];
    userAlbumsOptions.predicate = [NSPredicate predicateWithFormat:@"estimatedAssetCount > 0"];
    userAlbumsOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"startDate" ascending:YES]];
    
    NSMutableArray *albumsArray = [NSMutableArray array];
    [albumsArray addObject:
     [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum
                                              subtype:PHAssetCollectionSubtypeAlbumRegular
                                              options:nil]];
    [albumsArray addObject:
     [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum
                                              subtype:PHAssetCollectionSubtypeAny
                                              options:userAlbumsOptions]];
    return albumsArray;
}
//获取图片
+ (void)fetchImageSizeWithAsset:(WXAsset *)asset
     imageSizeCompletionHandler:(void(^)(CGFloat sizeInBytes, NSString *sizeString))handler{
    if (!asset){
        handler(0, @"0M");
        return;
    }
    [[PHImageManager defaultManager] requestImageDataForAsset:asset.asset
                                                      options:nil
                                                resultHandler:^(NSData * _Nullable imageData,
                                                                NSString * _Nullable dataUTI,
                                                                UIImageOrientation orientation,
                                                                NSDictionary * _Nullable info) {
                                                    CGFloat imageSize = 0.0;
                                                    NSString *sizeString = @"0M";
                                                    if (!imageData){
                                                        handler(imageSize, sizeString);
                                                        return;
                                                    }
                                                    imageSize = imageData.length;
                                                    if (imageSize > pow(2, 20)){
                                                        CGFloat size = imageSize / (1024*1024);
                                                        sizeString = [NSString stringWithFormat:@"%.1fM", size];
                                                    }else{
                                                        CGFloat size = imageSize / 1024;
                                                        sizeString = [NSString stringWithFormat:@"%.1fK", size];
                                                    }
                                                    handler(imageSize, sizeString);
                                                    return;
    }];
}
+ (void)saveLastAblumIdentifier:(NSString *)identifier {
    if (identifier.length <= 0)  return;
    [[NSUserDefaults standardUserDefaults] setObject:identifier forKey:kLastAlbumIdentifierKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)albumIdentifier {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kLastAlbumIdentifierKey];
}
@end
