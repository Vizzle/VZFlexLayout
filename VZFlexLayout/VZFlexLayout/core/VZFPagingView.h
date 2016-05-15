//
//  VZFPagingView.h
//  O2OReact
//
//  Created by Sleen on 16/5/13.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VZFPagingView : UIView

@property (nonatomic, strong, readonly) UICollectionView *collectionView;
@property (nonatomic, strong, readonly) UIPageControl *pageControl;
@property (nonatomic) BOOL pageControlEnabled;
@property (nonatomic) BOOL scroll;
@property (nonatomic) NSTimeInterval autoScroll;
@property (nonatomic) BOOL loopScroll;
@property (nonatomic) BOOL vertical;

- (void)setChildrenViews:(NSArray *)childrenViews;

@end
