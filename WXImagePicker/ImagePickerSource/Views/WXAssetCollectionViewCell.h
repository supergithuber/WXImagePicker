//
//  WXAssetCollectionViewCell.h
//  WXImagePicker
//
//  Created by HFY on 2018/12/7.
//  Copyright © 2018年 wuxi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class WXAssetCollectionViewCell;
@class WXAsset;

@protocol WXAssetCollectionViewCellDelegate <NSObject>

@optional
- (void)didSelectItemAssetViewCell:(WXAssetCollectionViewCell *)assetCell;
- (void)didDeselectItemAssetViewCell:(WXAssetCollectionViewCell *)assetCell;

@end

@interface WXAssetCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong)WXAsset *asset;

@property (nonatomic, assign)BOOL isSelected;
@property (nonatomic, weak, nullable)id<WXAssetCollectionViewCellDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
