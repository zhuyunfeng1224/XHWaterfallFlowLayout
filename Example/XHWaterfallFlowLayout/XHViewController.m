//
//  XHViewController.m
//  XHWaterfallFlowLayout
//
//  Created by echo on 09/08/2016.
//  Copyright (c) 2016 echo. All rights reserved.
//

#import "XHViewController.h"
#import <XHWaterfallFlowLayout/XHWaterfallFlowLayout.h>

@interface XHViewController ()
<UICollectionViewDataSource, UICollectionViewDelegate, XHWaterfallFlowLayoutDelegate>

@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, strong) XHWaterfallFlowLayout *flowLayout;

@end

@implementation XHViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupCollectionView];
}

- (void)setupCollectionView
{
    _flowLayout = [[XHWaterfallFlowLayout alloc] init];
    _flowLayout.columnCount = 2;
    _flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    _flowLayout.minimumInteritemSpacing = 10;
    _flowLayout.minimumLineSpacing = 10;
    _flowLayout.sDelegate = self;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) collectionViewLayout:_flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    [self.view addSubview:_collectionView];
    
    [_collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    CGFloat red = (CGFloat)(arc4random() % 255)/255.0;
    CGFloat green = (CGFloat)(arc4random() % 255)/255.0;
    CGFloat blue = (CGFloat)(arc4random() % 255)/255.0;
    
    UIColor *color = [[UIColor alloc] initWithRed:red green:green blue:blue alpha:0.5];
    cell.backgroundColor = color;
    
    return cell;
}

#pragma mark - XHWaterfallFlowLayoutDelegate

- (CGFloat)getHeightExceptImageAtIndex:(NSIndexPath *)indexPath
{
    return 80;
}

- (CGFloat)getImageRatioOfWidthAndHeight:(NSIndexPath *)indexPath
{
    CGFloat ratio = (CGFloat)(arc4random() % 10)/10;
    return ratio;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
