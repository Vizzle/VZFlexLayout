//
//  VZFPagingView.m
//  O2OReact
//
//  Created by Sleen on 16/5/13.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import "VZFPagingView.h"
#import "VZFActionWrapper.h"

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


@interface VZFPagingView () <UICollectionViewDataSource, UICollectionViewDelegate>

@end


@implementation VZFPagingView
{
    UICollectionViewFlowLayout *_flowLayout;
    NSArray<UIView *> *_childViews;
    NSTimer *_timer;
    
    BOOL _autoScrollAnimated;
    
    CGFloat _lastContentOffset;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _lastContentOffset = FLT_MIN;
        _scroll = YES;
        _loopScroll = NO;
        _autoScroll = 0;
        _autoScrollAnimated = YES;
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _flowLayout.minimumInteritemSpacing = 0;
        _flowLayout.minimumLineSpacing = 0;
        _flowLayout.itemSize = frame.size;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:_flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.scrollsToTop = NO;
        _collectionView.pagingEnabled = YES;
        _collectionView.bounces = YES;
        _collectionView.scrollEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kO2OPagingNodeReuseId];
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:_collectionView];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopTimer) name:UIApplicationDidEnterBackgroundNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetTimer) name:UIApplicationDidBecomeActiveNotification object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self stopTimer];
    
    // 避免一个 crash，详见 http://stackoverflow.com/a/26104397
    self.collectionView.delegate = nil;
    self.collectionView.dataSource = nil;
}

- (void)setFrame:(CGRect)frame
{
    // 如果 UICollectionView 的滚动方向上的尺寸不是整数，滚动时会出现空白的问题
    if ((!_vertical && (int)frame.size.width != frame.size.width)
        || (_vertical && (int)frame.size.height != frame.size.height)) {
        NSLog(@"VZFPagingView 滚动方向的尺寸必须是整数，现在是 %@", NSStringFromCGSize(frame.size));
        assert(false);  // 不知道为啥，用 NSAssert 的话，断下来的地方不对
        frame.size.width = ceil(frame.size.width);
        frame.size.height = ceil(frame.size.height);
    }
    
    [super setFrame:frame];
    [_collectionView setFrame:self.bounds];
    _flowLayout.itemSize = frame.size;
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
        [self addSubview:_pageControl];
    }
}

- (void)setAutoScroll:(NSTimeInterval)autoScroll {
    _autoScroll = autoScroll;
    [self resetTimer];
}

- (void)setLoopScroll:(BOOL)loopScroll {
    _loopScroll = loopScroll;
    [_collectionView reloadData];
}

- (void)setScroll:(BOOL)scroll {
    _scroll = scroll;
    _collectionView.scrollEnabled = [self scrollEnabled];
}

- (void)setVertical:(BOOL)vertical {
    _vertical = vertical;
    if (_vertical) {
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView.alwaysBounceHorizontal = NO;
        _collectionView.alwaysBounceVertical = YES;
    } else {
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView.alwaysBounceHorizontal = YES;
        _collectionView.alwaysBounceVertical = NO;
    }
}

- (void)setChildrenViews:(NSArray *)childrenViews {
    _childViews = childrenViews;
    _collectionView.scrollEnabled = [self scrollEnabled];
    [_collectionView reloadData];
    if (self.currentPage >= _childViews.count) {
        self.currentPage = 0;
    }
    if (_childViews.count > 0) {
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_currentPage + ([self loopScrollEnabled] ? 1 : 0) inSection:0] atScrollPosition:self.vertical ? UICollectionViewScrollPositionTop : UICollectionViewScrollPositionLeft animated:NO];
    }
    else {
        _collectionView.contentOffset = CGPointZero;
    }
    [self resetTimer];
}

- (void)resetTimer
{
    [self stopTimer];
    if ([self autoScrollEnabled]) {
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

- (void)scrollToNextItem
{
    if (_collectionView.isTracking || _collectionView.isDragging || _collectionView.isDecelerating) {
        return;
    }
    
    NSInteger nextIndex = _currentPage + 1;
    if ([self loopScrollEnabled]) {
        nextIndex += 1;
    } else if (![self loopScrollEnabled] && nextIndex == _childViews.count) {
        nextIndex = 0;
    }
    
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:nextIndex inSection:0] atScrollPosition:self.vertical ? UICollectionViewScrollPositionTop : UICollectionViewScrollPositionLeft animated:_autoScrollAnimated];
}

- (void)setCurrentPage:(NSInteger)currentPage
{
    
    if (![self autoScrollEnabled] && _currentPage != currentPage) {
        [self.switched invoke:self withCustomParam:self];
    }
    
    _currentPage = currentPage;
    if (_pageControl && _pageControl.currentPage != currentPage) {
        _pageControl.currentPage = currentPage;
    }
}

- (NSInteger)indexForCellIndex:(NSInteger)index
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

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self resetTimer];
}

//
// reference: https://github.com/RungeZhai/SeamlessCyclicScrollView
//
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    BOOL isVertical = _flowLayout.scrollDirection == UICollectionViewScrollDirectionVertical;
    
    CGFloat currentOffsetX = scrollView.contentOffset.x;
    CGFloat currentOffsetY = scrollView.contentOffset.y;
    
    CGFloat *currectOffset = isVertical ? &currentOffsetY : &currentOffsetX;
    
    // We can ignore the first time scroll,
    // because it is caused by the call scrollToItemAtIndexPath: in ViewWillAppear
    if (FLT_MIN == _lastContentOffset) {
        _lastContentOffset = *currectOffset;
        return;
    }
    
    CGFloat pageLength = isVertical ? scrollView.frame.size.height : scrollView.frame.size.width;
    CGFloat offset = pageLength * _childViews.count;
    
    if ([self loopScrollEnabled]) {
        // the first page(showing the last item) is visible and user's finger is still scrolling to the right
        if (*currectOffset < pageLength / 2 && _lastContentOffset > *currectOffset) {
            _lastContentOffset = *currectOffset + offset;
            *currectOffset = _lastContentOffset;
            scrollView.contentOffset = (CGPoint){currentOffsetX, currentOffsetY};
        }
        // the last page (showing the first item) is visible and the user's finger is still scrolling to the left
        else if (*currectOffset > offset + pageLength / 2 && _lastContentOffset < *currectOffset) {
            _lastContentOffset = *currectOffset - offset;
            *currectOffset = _lastContentOffset;
            scrollView.contentOffset = (CGPoint){currentOffsetX, currentOffsetY};
        } else {
            _lastContentOffset = *currectOffset;
        }
    } else {
        _lastContentOffset = *currectOffset;
    }
    
    NSInteger index = round((float)_lastContentOffset / pageLength);
    self.currentPage = [self indexForCellIndex:index];
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = [self indexForCellIndex:indexPath.item];
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kO2OPagingNodeReuseId forIndexPath:indexPath];
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [cell.contentView addSubview:_childViews[index]];
    cell.contentView.clipsToBounds = YES;
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger number = _childViews.count;
    if ([self loopScrollEnabled]) {
        number += 2;
    }
    return number;
}

/////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - backing view interface 

- (void)resetState{
    _lastContentOffset = FLT_MIN;
    self.currentPage = 0;
}

@end
