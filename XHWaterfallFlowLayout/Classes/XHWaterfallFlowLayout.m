//
//  LNWaterfallFlowLayout.m
//  WaterfallFlowDemo
//
//  Created by echo on 09/08/2016.
//  Copyright (c) 2016 echo. All rights reserved.
//

#import "XHWaterfallFlowLayout.h"

#define PADDING 10

@interface XHWaterfallFlowLayout ()
// 所有item的属性的数组
@property (nonatomic, strong) NSArray *layoutAttributesArray;
@property (nonatomic, assign) CGFloat contentHeight;
@property (nonatomic, strong) UICollectionViewLayoutAttributes *headerAttr;
@property (nonatomic, strong) UICollectionViewLayoutAttributes *footerAttr;

@end

@implementation XHWaterfallFlowLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.sectionInset = UIEdgeInsetsMake(PADDING, PADDING, PADDING, PADDING);
        self.minimumInteritemSpacing = PADDING;
    }
    return self;
}
/**
 *  布局准备方法 当collectionView的布局发生变化时 会被调用
 *  通常是做布局的准备工作 itemSize.....
 *  UICollectionView 的 contentSize 是根据 itemSize 动态计算出来的
 */
- (void)prepareLayout {
    [super prepareLayout];
    // 根据列数 计算item的宽度 宽度是一样的
    CGFloat contentWidth = self.collectionView.bounds.size.width - self.sectionInset.left - self.sectionInset.right;
    CGFloat marginX = self.minimumInteritemSpacing;
    CGFloat itemWidth = (contentWidth - marginX * (self.columnCount - 1)) / self.columnCount;
    [self computeAttributesWithItemWidth:itemWidth];
}

/**
 *  根据itemWidth计算布局属性
 */
- (void)computeAttributesWithItemWidth:(CGFloat)itemWidth {
    
    self.contentHeight = 0;
    // 定义一个列高数组 记录每一列的总高度
    CGFloat *columnHeight = (CGFloat *) malloc(self.columnCount * sizeof(CGFloat));
    // 定义一个记录每一列的总item个数的数组
    NSInteger *columnItemCount = (NSInteger *) malloc(self.columnCount * sizeof(NSInteger));
    
    // 初始化
    for (int i = 0; i < self.columnCount; i++) {
        columnHeight[i] = self.sectionInset.top;
        columnItemCount[i] = 0;
    }
    
    NSUInteger count = [self.collectionView numberOfItemsInSection:0];
    // 遍历 goodsList 数组计算相关的属性
    NSMutableArray *attributesArray = [NSMutableArray arrayWithCapacity:count];
    // 添加页首属性
    if (self.headerReferenceSize.height > 0)
    {
        NSIndexPath *headerIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
        _headerAttr = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:headerIndexPath];
        self.headerAttr.frame = CGRectMake(0, 0, self.headerReferenceSize.width, self.headerReferenceSize.height);
        [attributesArray addObject:self.headerAttr];
    }
    
    for (NSUInteger index = 0; index < count; index++) {
        //            CYGImageModel *imgModel = self.imageList[index];
        
        // 建立布局属性
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        
        // 找出最短列号
        NSInteger column = [self shortestColumn:columnHeight];
        // 数据追加在最短列
        columnItemCount[column]++;
        // X值
        CGFloat itemX = (itemWidth + self.minimumInteritemSpacing) * column + self.sectionInset.left;
        // Y值
        CGFloat itemY = columnHeight[column] + self.headerReferenceSize.height;
        CGFloat extraHeight = 0;
        if ([self.sDelegate respondsToSelector:@selector(getHeightExceptImageAtIndex:)]) {
            
            extraHeight = [self.sDelegate getHeightExceptImageAtIndex:[NSIndexPath
                                                                       indexPathForRow:index
                                                                       inSection:0]];
        }
        
        // 等比例缩放 计算item的高度
        CGFloat imageRatio = 0;
        if ([self.sDelegate respondsToSelector:@selector(getImageRatioOfWidthAndHeight:)]) {
            
            imageRatio = [self.sDelegate getImageRatioOfWidthAndHeight:indexPath];
        }
        CGFloat itemH = (imageRatio == 0? 0 : (itemWidth / imageRatio))+ extraHeight;
        
        // 设置frame
        attributes.frame = CGRectMake(itemX, itemY, itemWidth, itemH);
        [attributesArray addObject:attributes];
        
        // 累加列高
        columnHeight[column] += (itemH + self.minimumLineSpacing);
        
        if (columnHeight[column] > self.contentHeight)
        {
            self.contentHeight = columnHeight[column];
        }
    }

    // 添加页脚属性
    if (self.footerReferenceSize.height > 0)
    {
        NSIndexPath *footerIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
        _footerAttr = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter withIndexPath:footerIndexPath];
        self.footerAttr.frame = CGRectMake(0, self.contentHeight, self.footerReferenceSize.width, self.footerReferenceSize.height);
        [attributesArray addObject:self.footerAttr];
    }
    // 给属性数组设置数值
    self.layoutAttributesArray = attributesArray.copy;
}

/**
 *  找出columnHeight数组中最短列号 追加数据的时候追加在最短列中
 */
- (NSInteger)shortestColumn:(CGFloat *)columnHeight {
    
    CGFloat max = CGFLOAT_MAX;
    NSInteger column = 0;
    for (int i = 0; i < self.columnCount; i++) {
        if (columnHeight[i] < max) {
            max = columnHeight[i];
            column = i;
        }
    }
    return column;
}


/**
 *  找出columnHeight数组中最高列号
 */
- (NSInteger)highestColumn:(CGFloat *)columnHeight {
    CGFloat min = 0;
    NSInteger column = 0;
    for (int i = 0; i < self.columnCount; i++) {
        if (columnHeight[i] > min) {
            min = columnHeight[i];
            column = i;
        }
    }
    return column;
}


/**
 *  跟踪效果：当到达要显示的区域时 会计算所有显示item的属性
 *           一旦计算完成 所有的属性会被缓存 不会再次计算
 *  @return 返回布局属性(UICollectionViewLayoutAttributes)数组
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    if (!self.layoutAttributesArray) {
        self.layoutAttributesArray = [super layoutAttributesForElementsInRect:rect];
    }
    // 直接返回计算好的布局属性数组
    return self.layoutAttributesArray;
}

- (CGSize)collectionViewContentSize
{
    [super collectionViewContentSize];
    CGFloat contentHeight = self.contentHeight + self.footerReferenceSize.height + self.headerReferenceSize.height;
    if (contentHeight <= CGRectGetHeight(self.collectionView.frame)) {
        contentHeight = CGRectGetHeight(self.collectionView.frame) + 1;
    }
    return CGSizeMake(self.collectionView.frame.size.width, contentHeight);
}

@end
