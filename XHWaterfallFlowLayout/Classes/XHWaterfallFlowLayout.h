//
//  LNWaterfallFlowLayout.h
//  WaterfallFlowDemo
//
//  Created by echo on 09/08/2016.
//  Copyright (c) 2016 echo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XHWaterfallFlowLayoutDelegate <NSObject>

@optional
- (CGFloat)getHeightExceptImageAtIndex:(NSIndexPath *)indexPath;
- (CGFloat)getImageRatioOfWidthAndHeight:(NSIndexPath *)indexPath;

@end

@interface XHWaterfallFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, weak) id<XHWaterfallFlowLayoutDelegate> sDelegate;

// 总列数
@property (nonatomic, assign) NSInteger columnCount;

@end