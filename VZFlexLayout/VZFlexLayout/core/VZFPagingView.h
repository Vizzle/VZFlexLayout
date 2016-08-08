//
//  VZFPagingView.h
//  O2OReact
//
//  Created by Sleen on 16/5/13.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VZFNodeBackingViewInterface.h"

@protocol VZFActionWrapper;

@interface VZFPagingView : UIView<VZFNodeBackingViewInterface>

@property (nonatomic, strong, readonly) UICollectionView *collectionView;
@property (nonatomic, strong, readonly) UIPageControl *pageControl;
@property (nonatomic) BOOL pageControlEnabled;
@property (nonatomic) BOOL scroll;
@property (nonatomic) NSTimeInterval autoScroll;
@property (nonatomic) BOOL loopScroll;
@property (nonatomic) BOOL vertical;

@property (nonatomic) NSInteger currentPage;
@property (nonatomic, strong) id<VZFActionWrapper> switched;


- (void)setChildrenViews:(NSArray *)childrenViews;
- (void)resetTimer;

@end
