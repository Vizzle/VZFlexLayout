//
//  VZFPagingView.m
//  O2OReact
//
//  Created by Sleen on 16/5/13.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import "VZFPagingView.h"
#import "VZFActionWrapper.h"
#import "UIView+VZAttributes.h"
#import "VZFPagingNode.h"
#import "VZFNodeLayoutManager.h"
#import "VZFNodeInternal.h"
#import "VZFlexNode.h"
#import "VZFMacros.h"

static NSString *const kO2OPagingNodeReuseId = @"VZFPagingViewCell";


@interface VZFPagingTimerWrapper : NSObject
@end
@implementation VZFPagingTimerWrapper
{
    __weak id _target;
    SEL _selector;
}

- (instancetype)initWithTarget:(id)target selector:(SEL)selector {
    if (self = [super init]) {
        _target = target;
        _selector = selector;
    }
    return self;
}

- (void)timerDidFire:(NSTimer *)timer
{
    if(_target && _selector)
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [_target performSelector:_selector withObject:timer];
#pragma clang diagnostic pop
    }
    else
    {
        [timer invalidate];
    }
}
@end


@interface VZFPagingScrollView : UIScrollView
@end
@implementation VZFPagingScrollView

- (BOOL)isAccessibilityElement{
    return NO;
}


- (NSInteger)accessibilityElementCount{
    return self.subviews.count;
};

//这两个方法是可以不复写的, 也能满足需求。实践并验证是以下两个方式有默认的内容
- (nullable id)accessibilityElementAtIndex:(NSInteger)index{
    return self.subviews[index];
};

- (NSInteger)indexOfAccessibilityElement:(id)element{
    return [self.subviews indexOfObject:element];
};


- (BOOL)accessibilityScroll:(UIAccessibilityScrollDirection)direction{
    
    BOOL isSupportedScroll = false;
    
    if (![self.superview isKindOfClass:[VZFPagingView class]]
        || ![self.superview respondsToSelector:@selector(scrollToPreviousItem)]
        || ![self.superview respondsToSelector:@selector(scrollToNextItem)]) {
        return false;
    }
    
    VZFPagingView* superView = (VZFPagingView*)self.superview;
    
    switch (direction) {
        case UIAccessibilityScrollDirectionRight:
            [superView scrollToPreviousItem];
            isSupportedScroll = true;
            break;
        case UIAccessibilityScrollDirectionLeft:
            [superView  scrollToNextItem];
            isSupportedScroll = true;
            break;
        default:
            break;
    }
    
    return isSupportedScroll;
}

@end


@interface VZFPagingView () <UIScrollViewDelegate>

@property (nonatomic, strong) NSSet *visibleIndexes;

@end


@implementation VZFPagingView
{
    NSArray<UIView *> *_childViews;
    NSTimer *_timer;
    
    BOOL _isActive;     // 应用是否在前台
    BOOL _isVisible;    // 是否可见
    
    BOOL _autoScrollAnimated;
    
    CGFloat _lastContentOffset;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _isActive = YES;
        _lastContentOffset = FLT_MIN;
        _scroll = YES;
        _pagingEnabled = YES;
        _loopScroll = NO;
        _autoScroll = 0;
        _autoScrollAnimated = YES;
        _scrollView = [[VZFPagingScrollView alloc] initWithFrame:self.bounds];
        _scrollView.delegate = self;
        _scrollView.scrollsToTop = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = YES;
        _scrollView.scrollEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.backgroundColor = [UIColor clearColor];
        [self addSubview:_scrollView];
        self.backgroundColor = [UIColor clearColor];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willResignActive) name:UIApplicationWillResignActiveNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
    }
    return self;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self stopTimer];
    
    // 避免一个 crash，详见 http://stackoverflow.com/a/26104397
    self.scrollView.delegate = nil;
}

- (void)willResignActive {
    _isActive = NO;
    [self resetTimer];
}

- (void)didBecomeActive {
    _isActive = YES;
    [self resetTimer];
}

- (void)willMoveToWindow:(UIWindow *)newWindow {
    _isVisible = !!newWindow;
    [self resetTimer];
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [_scrollView setFrame:self.bounds];
}

- (void)setPageControlEnabled:(BOOL)pageControlEnabled {
    if (_pageControlEnabled == pageControlEnabled) {
        return;
    }
    
    _pageControlEnabled = pageControlEnabled;
    if (_pageControl && !pageControlEnabled) {
        [_pageControl removeFromSuperview];
        _pageControl = nil;
    }
    if (pageControlEnabled && !_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.isAccessibilityElement = NO;
        [self addSubview:_pageControl];
    }
}

- (void)setPagingEnabled:(BOOL)pagingEnabled {
    _pagingEnabled = pagingEnabled;
    _scrollView.pagingEnabled = pagingEnabled;
}

- (void)setAutoScroll:(NSTimeInterval)autoScroll {
    _autoScroll = autoScroll;
    [self resetTimer];
}

- (void)reloadViews {
    [_scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSMutableSet *visibleIndexes = [NSMutableSet set];
    for (int i=0;i<_childViews.count;i++) {
        [visibleIndexes addObject:@([self virtualIndexForViewIndex:i])];
        [_scrollView addSubview:_childViews[i]];
    }
    self.visibleIndexes = nil;
    self.visibleIndexes = visibleIndexes;
    CGSize size = self.bounds.size;
    CGFloat virtualPageCount = [self loopScroll] ? _childViews.count + 2 : _childViews.count;
    (_vertical ? size.height : size.width) *= virtualPageCount;
    _scrollView.contentSize = size;
}

- (void)setLoopScroll:(BOOL)loopScroll {
    _loopScroll = loopScroll;
    [self reloadViews];
}

- (void)setScroll:(BOOL)scroll {
    _scroll = scroll;
    _scrollView.scrollEnabled = [self scrollEnabled];
}

- (void)setVertical:(BOOL)vertical {
    _vertical = vertical;
    if (_vertical) {
        _scrollView.alwaysBounceHorizontal = NO;
        _scrollView.alwaysBounceVertical = YES;
    } else {
        _scrollView.alwaysBounceHorizontal = YES;
        _scrollView.alwaysBounceVertical = NO;
    }
}

- (CGRect)rectForIndex:(NSUInteger)index {
    CGRect rect = self.bounds;
    if (_vertical) {
        rect.origin.y = index * rect.size.height;
    }
    else {
        rect.origin.x = index * rect.size.width;
    }
    return rect;
}

- (NSInteger)numberOfPages {
    return _childViews.count;
}

- (void)setChildrenViews:(NSArray *)childrenViews {
    _childViews = childrenViews;
    _scrollView.scrollEnabled = [self scrollEnabled];
    [self reloadViews];
    if (self.currentPage >= _childViews.count) {
        self.currentPage = 0;
    }
    if (_childViews.count > 0) {
        [_scrollView scrollRectToVisible:[self rectForIndex:_currentPage + ([self loopScrollEnabled] ? 1 : 0)] animated:NO];
    }
    else {
        _scrollView.contentOffset = CGPointZero;
    }
    [self resetTimer];
}

- (void)resetTimer
{
    [self stopTimer];
    if (_isActive && _isVisible && [self autoScrollEnabled]) {
        VZFPagingTimerWrapper *wrapper = [[VZFPagingTimerWrapper alloc] initWithTarget:self selector:@selector(scrollToNextItem)];
        _timer = [NSTimer timerWithTimeInterval:MAX(1, _autoScroll) target:wrapper selector:@selector(timerDidFire:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
}

- (void)stopTimer
{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (BOOL)scrollEnabled
{
    return _scroll && _childViews.count > 1;
}

- (BOOL)autoScrollEnabled
{
    return _autoScroll > 0.1 && _childViews.count > 1;
}

- (BOOL)loopScrollEnabled
{
    return _loopScroll && _childViews.count > 1;
}

- (void)scrollToPreviousItem
{
    if (_scrollView.isTracking || _scrollView.isDragging || _scrollView.isDecelerating) {
        return;
    }
    
    NSInteger preIndex = _currentPage - 1;
    if ([self loopScrollEnabled]) {
        preIndex += 1;
    } else if (preIndex < 0) {
        preIndex = _childViews.count - 1;
    }
    
    [_scrollView scrollRectToVisible:[self rectForIndex:preIndex] animated:_autoScrollAnimated];
}

- (void)scrollToNextItem
{
    if (_scrollView.isTracking || _scrollView.isDragging || _scrollView.isDecelerating) {
        return;
    }
    
    NSInteger nextIndex = _currentPage + 1;
    if ([self loopScrollEnabled]) {
        nextIndex += 1;
    } else if (nextIndex == _childViews.count) {
        nextIndex = 0;
    }
    
    [_scrollView scrollRectToVisible:[self rectForIndex:nextIndex] animated:_autoScrollAnimated];
}

- (void)scrollToPage:(NSInteger)pageIndex {
    if (_scrollView.isTracking || _scrollView.isDragging || _scrollView.isDecelerating) {
        return;
    }
    if (pageIndex == self.currentPage) {
        return;
    }
    NSInteger targetPageIndex = pageIndex;
    if ([self loopScrollEnabled]) {
        targetPageIndex += 1;
    } else if (targetPageIndex == _childViews.count) {
        targetPageIndex = 0;
    }
    [_scrollView scrollRectToVisible:[self rectForIndex:targetPageIndex] animated:_autoScrollAnimated];
}

- (void)setCurrentPage:(NSInteger)currentPage
{
    
    if (_currentPage != currentPage) {
        _currentPage = currentPage;
        [self.switched invoke:self withCustomParam:self];
    }
    
    _currentPage = currentPage;
    if (_pageControl && _pageControl.currentPage != currentPage) {
        _pageControl.currentPage = currentPage;
    }
}

/*

                |<--------- contentSize.width --------->|

                + - - - +-------+-------+-------+ - - - +
                |       |       |       |       |       |
                        |       |       |       |        
                | Page3 | Page1 | Page2 | Page3 | Page1 |
                        |       |       |       |        
                |       |       |       |       |       |
                + - - - +-------+-------+-------+ - - - +

 View Index         2       0       1       2       0
(Page Index)

Virtual Index       0       1       2       3       4

*/
- (NSInteger)viewIndexForVirtualIndex:(NSInteger)index
{
    if ([self loopScrollEnabled]) {
        if (index == 0) {
            return _childViews.count - 1;
        } else if (index == _childViews.count + 1) {
            return 0;
        } else {
            return index - 1;
        }
    }
    return index;
}

- (NSInteger)virtualIndexForViewIndex:(NSInteger)index
{
    if ([self loopScrollEnabled]) {
        return index + 1;
    }
    return index;
}

- (void)setVisibleIndexes:(NSSet *)visibleIndexes {
    NSMutableSet *newIndexes = visibleIndexes.mutableCopy;
    if (_visibleIndexes) [newIndexes minusSet:_visibleIndexes];
    for (NSNumber *index in newIndexes) {
        NSUInteger i = index.unsignedIntegerValue;
        _childViews[[self viewIndexForVirtualIndex:i]].frame = [self rectForIndex:i];
    }
    _visibleIndexes = visibleIndexes;
}

- (void)updateCurrentPage:(UIScrollView *)scrollView {
    CGFloat pageLength = _vertical ? scrollView.frame.size.height : scrollView.frame.size.width;
    NSInteger index = round((float)_lastContentOffset / pageLength);
    self.currentPage = [self viewIndexForVirtualIndex:index];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self updateCurrentPage:scrollView];
    [self resetTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [self scrollViewDidEndDecelerating:scrollView];
    }
}

//reference: https://github.com/RungeZhai/SeamlessCyclicScrollView

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat currentOffsetX = scrollView.contentOffset.x;
    CGFloat currentOffsetY = scrollView.contentOffset.y;
    
    CGFloat *currentOffset = _vertical ? &currentOffsetY : &currentOffsetX;
    
    if (_lastContentOffset == *currentOffset) {
        return;
    }
    
    // We can ignore the first time scroll,
    // because it is caused by the call scrollToItemAtIndexPath: in ViewWillAppear
    if (FLT_MIN == _lastContentOffset) {
        _lastContentOffset = *currentOffset;
        return;
    }
    
    CGFloat pageLength = _vertical ? scrollView.frame.size.height : scrollView.frame.size.width;
    CGFloat offset = pageLength * _childViews.count;
    
    if ([self loopScrollEnabled]) {
        // the first page(showing the last item) is visible and user's finger is still scrolling to the right
        if (*currentOffset < pageLength && _lastContentOffset > *currentOffset) {
            _lastContentOffset = *currentOffset += offset;
            scrollView.contentOffset = (CGPoint){currentOffsetX, currentOffsetY};
        }
        // the last page (showing the first item) is visible and the user's finger is still scrolling to the left
        else if (*currentOffset > offset && _lastContentOffset < *currentOffset) {
            _lastContentOffset = *currentOffset -= offset;
            scrollView.contentOffset = (CGPoint){currentOffsetX, currentOffsetY};
        } else {
            _lastContentOffset = *currentOffset;
        }
        
        CGFloat currentPage = *currentOffset / pageLength;
        NSMutableSet *visibleIndexes = [NSMutableSet set];
        [visibleIndexes addObject:@(floor(currentPage))];
        [visibleIndexes addObject:@(ceil(currentPage))];
        self.visibleIndexes = visibleIndexes;
    } else {
        _lastContentOffset = *currentOffset;
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self updateCurrentPage:scrollView];
}

/////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - backing view interface 

- (void)resetState{
    _lastContentOffset = FLT_MIN;
    self.currentPage = 0;
}


- (void)vz_applyNodeAttributes:(VZFNode *)node {
    VZFPagingNode *pagingNode = (VZFPagingNode* )node;
    PagingNodeSpecs specs = pagingNode.pagingNodeSpecs;
    self.scroll = specs.scrollEnabled;
    self.autoScroll = specs.autoScroll;
    self.loopScroll = specs.infiniteLoop;
    self.vertical = specs.direction == PagingVertical;
    self.pagingEnabled = specs.paging;
    
    self.pageControlEnabled = specs.paging && specs.pageControl;
    if (specs.pageControl) {
        UIPageControl *pageControl = self.pageControl;
        pageControl.backgroundColor = [UIColor clearColor];
        pageControl.userInteractionEnabled = NO;
        pageControl.hidesForSinglePage = YES;
        pageControl.frame = pagingNode.pageControlNode.flexNode.resultFrame;
        pageControl.transform = CGAffineTransformMakeScale(specs.pageControlScale, specs.pageControlScale);
        pageControl.pageIndicatorTintColor = specs.pageControlColor;
        pageControl.currentPageIndicatorTintColor = specs.pageControlSelectedColor;
        pageControl.numberOfPages = pagingNode.children.size();
    }
    
    if (pagingNode.viewsCache) {
        for (int i=0;i<pagingNode.childrenLayout.size();i++) {
            layoutRootNodeInContainer(pagingNode.childrenLayout[i], pagingNode.viewsCache[i], nil, nil);
        }
        [self setChildrenViews:pagingNode.viewsCache];
    }
    else {
        NSMutableArray *subviews = [NSMutableArray array];
        for (const auto& layout : pagingNode.childrenLayout) {
            
            UIView* view = viewForRootNode(layout, self.frame.size);
            
            [subviews addObject:view];
        }
        [self setChildrenViews:subviews];
        pagingNode.viewsCache = subviews;
    }
    
    self.switched = specs.switched;
    
    [self setNeedsLayout];
}

@end
