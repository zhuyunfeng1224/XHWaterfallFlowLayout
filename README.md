一个基于UICollectionViewFlowLayout的瀑布流布局 用于UICollectionView
经常做电商产品展示，需要用到瀑布流，这里整理下和大家分享～<br>
![image](https://github.com/zhuyunfeng1224/XHImageStore/blob/master/XHWaterfallFlowLayout/XHWaterfallFlowLayout_screenshot.gif)
# 使用方法
## 实现XHWaterfallFlowLayoutDelegate代理，并实现其中方法
```- (CGFloat)getHeightExceptImageAtIndex:(NSIndexPath *)indexPath;```
这个方法是返回除图片以外的高度

```- (CGFloat)getImageRatioOfWidthAndHeight:(NSIndexPath *)indexPath;```
这个方法返回图片宽高比例0-1
## 使用XHWaterfallFlowLayout同UICollectionViewFlowLayout
```
_flowLayout = [[XHWaterfallFlowLayout alloc] init];
    _flowLayout.columnCount = 2;    // 显示列数
    _flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    _flowLayout.minimumInteritemSpacing = 10;
    _flowLayout.minimumLineSpacing = 10;
    _flowLayout.sDelegate = self;
```
# 导入
## 手工导入
下载或clone到本地，导入XHWaterfallFlowLayout.h和XHWaterfallFlowLayout.m文件即可
内含demo

## cocoapods导入
```pod 'XHWaterfallFlowLayout', '~> 1.0.0'```

# License
MIT license.
