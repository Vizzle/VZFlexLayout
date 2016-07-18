//
//  UIView+VZAttributes.m
//  O2OReact
//
//  Created by moxin on 16/4/29.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import "UIView+VZAttributes.h"
#import "VZFNodeInternal.h"
#import "VZFNodeViewManager.h"
#import "VZFNodeSpecs.h"
#import "VZFNodeViewClass.h"
#import "VZFButtonNode.h"
#import "VZFButtonNodeSpecs.h"
#import "VZFTextNode.h"
#import "VZFTextNodeSpecs.h"
#import "VZFImageNode.h"
#import "VZFImageNodeSpecs.h"
#import "VZFIndicatorNode.h"
#import "VZFIndicatorNodeSpecs.h"
#import "VZFActionWrapper.h"
#import "VZFScrollNode.h"
#import "VZFScrollNodeSpecs.h"
#import "VZFPagingNode.h"
#import "VZFPagingNodeSpecs.h"
#import "VZFPagingView.h"
#import "VZFButtonView.h"
#import "VZFlexNode.h"
#import "VZFNodeLayoutManager.h"
#import "VZFStackNode.h"
#import "VZFStackNodeSpecs.h"
#import "VZFStackView.h"
#import <objc/runtime.h>

@implementation UIView (VZAttributes)

- (void)applyAttributes{

    VZFNode* node = self.node;
    
    [self _applyAttributes:node.specs.view];
    
    [self _applyGestures:node.specs.gesture];
    
    if ([node isKindOfClass:[VZFImageNode class]])
    {
        [self _applyImageAttributes:((VZFImageNode* )node).imageSpecs];
    }
    else if ([node isKindOfClass:[VZFButtonNode class]])
    {
        [self _applyButtonAttributes:((VZFButtonNode* )node).buttonSpecs];
    }
    else if ([node isKindOfClass:[VZFTextNode class]])
    {
        [self _applyTextAttributes:((VZFTextNode* )node).textSpecs];
    }
    else if ([node isKindOfClass:[VZFScrollNode class]])
    {
        [self _applyScrollAttributes:((VZFScrollNode* )node).scrollNodeSpecs];
    }
    else if ([node isKindOfClass:[VZFPagingNode class]])
    {
        [self _applyPagingAttributes:((VZFPagingNode* )node).pagingNodeSpecs];
    }
    else if ([node isKindOfClass:[VZFIndicatorNode class]])
    {
        [self _applyIndicatorAttributes:((VZFIndicatorNode* )node).indicatorSpecs];
    }
}

- (UIBezierPath *)_roundRectPathWithWidth:(CGFloat)width
                                   height:(CGFloat)height
                            topLeftRadius:(CGFloat)topLeftRadius
                           topRightRadius:(CGFloat)topRightRadius
                         bottomLeftRadius:(CGFloat)bottomLeftRadius
                        bottomRightRadius:(CGFloat)bottomRightRadius
{
    CGFloat top_left_x = topLeftRadius;
    CGFloat top_left_y = topLeftRadius;
    CGFloat top_right_x = topRightRadius;
    CGFloat top_right_y = topRightRadius;
    CGFloat bottom_left_x = bottomLeftRadius;
    CGFloat bottom_left_y = bottomLeftRadius;
    CGFloat bottom_right_x = bottomRightRadius;
    CGFloat bottom_right_y = bottomRightRadius;
    if (top_left_x + top_right_x > width) {
        CGFloat factor = width / (top_left_x + top_right_x);
        top_left_x *= factor;
        top_right_x *= factor;
    }
    if (bottom_left_x + bottom_right_x > width) {
        CGFloat factor = width / (bottom_left_x + bottom_right_x);
        bottom_left_x *= factor;
        bottom_right_x *= factor;
    }
    if (top_left_y + bottom_left_y > height) {
        CGFloat factor = height / (top_left_y + bottom_left_y);
        top_left_y *= factor;
        bottom_left_y *= factor;
    }
    if (top_right_y + bottom_right_y > height) {
        CGFloat factor = height / (top_right_y + bottom_right_y);
        top_right_y *= factor;
        bottom_right_y *= factor;
    }
    CGFloat top_left = MIN(top_left_x, top_left_y);
    CGFloat top_right = MIN(top_right_x, top_right_y);
    CGFloat bottom_left = MIN(bottom_left_x, bottom_left_y);
    CGFloat bottom_right = MIN(bottom_right_x, bottom_right_y);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(top_left, 0)];
    [path addLineToPoint:CGPointMake(width - top_right, 0)];
    if (top_right > 0) {
        [path addArcWithCenter:CGPointMake(width - top_right, top_right) radius:top_right startAngle:-M_PI_2 endAngle:0 clockwise:YES];
    }
    [path addLineToPoint:CGPointMake(width, height - bottom_right)];
    if (bottom_right > 0) {
        [path addArcWithCenter:CGPointMake(width - bottom_right, height - bottom_right) radius:bottom_right startAngle:0 endAngle:M_PI_2 clockwise:YES];
    }
    [path addLineToPoint:CGPointMake(bottom_left, height)];
    if (bottom_left > 0) {
        [path addArcWithCenter:CGPointMake(bottom_left, height - bottom_left) radius:bottom_left startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
    }
    [path addLineToPoint:CGPointMake(0, top_left)];
    if (top_left > 0) {
        [path addArcWithCenter:CGPointMake(top_left, top_left) radius:top_left startAngle:M_PI endAngle:M_PI_2 * 3 clockwise:YES];
    }
    [path closePath];
    
    return path;
}

- (void)_applyAttributes:(const ViewAttrs&)vs {
    
    self.tag                    = vs.tag;
    self.backgroundColor        = vs.backgroundColor;
    self.clipsToBounds          = vs.clip;
    self.hidden                 = vs.hidden;
    
    int userInteractionEnabled = vs.userInteractionEnabled;
    if (userInteractionEnabled != INT_MIN) {
        self.userInteractionEnabled = YES;
    }
    
    static const void* _id = &_id;
    // 移除重用的 layer
    [self.layer.sublayers.copy enumerateObjectsUsingBlock:^(__kindof CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (objc_getAssociatedObject(obj, _id)) {
            [obj removeFromSuperlayer];
        }
    }];
    
    CGFloat cornerRadiusTopLeft = vs.layer.cornerRadiusTopLeft != VZ::FlexValue::Undefined ? vs.layer.cornerRadiusTopLeft.value : vs.layer.cornerRadius;
    CGFloat cornerRadiusTopRight = vs.layer.cornerRadiusTopRight != VZ::FlexValue::Undefined ? vs.layer.cornerRadiusTopRight.value : vs.layer.cornerRadius;
    CGFloat cornerRadiusBottomLeft = vs.layer.cornerRadiusBottomLeft != VZ::FlexValue::Undefined ? vs.layer.cornerRadiusBottomLeft.value : vs.layer.cornerRadius;
    CGFloat cornerRadiusBottomRight = vs.layer.cornerRadiusBottomRight != VZ::FlexValue::Undefined ? vs.layer.cornerRadiusBottomRight.value : vs.layer.cornerRadius;
    if (cornerRadiusTopLeft != cornerRadiusTopRight || cornerRadiusTopLeft != cornerRadiusBottomLeft || cornerRadiusTopLeft != cornerRadiusBottomRight) {
        self.layer.borderWidth      = 0;
        UIBezierPath *path = [self _roundRectPathWithWidth:self.bounds.size.width
                                                    height:self.bounds.size.height
                                             topLeftRadius:cornerRadiusTopLeft
                                            topRightRadius:cornerRadiusTopRight
                                          bottomLeftRadius:cornerRadiusBottomLeft
                                         bottomRightRadius:cornerRadiusBottomRight];
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.path = path.CGPath;
        objc_setAssociatedObject(maskLayer, _id, @YES, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self.layer addSublayer:maskLayer];
        self.layer.mask = maskLayer;
        if (vs.layer.borderWidth > 0 && vs.layer.borderColor) {
            CAShapeLayer *strokeLayer = [CAShapeLayer layer];
            strokeLayer.path = path.CGPath;
            strokeLayer.fillColor = [UIColor clearColor].CGColor;
            strokeLayer.strokeColor = vs.layer.borderColor.CGColor;
            strokeLayer.lineWidth = vs.layer.borderWidth * 2;
            objc_setAssociatedObject(strokeLayer, _id, @YES, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            [self.layer addSublayer:strokeLayer];
        }
    }
    else {
        self.layer.cornerRadius     = cornerRadiusTopLeft;
        self.layer.borderColor      = vs.layer.borderColor.CGColor;
        self.layer.borderWidth      = vs.layer.borderWidth;
        self.layer.mask = nil;
    }
    
    if (vs.layer.contents.CGImage) {
        self.layer.contents     = (__bridge id)vs.layer.contents.CGImage;
    }
    
    if ([self isKindOfClass:[VZFStackView class]]) {
        VZFStackView* stackView = (VZFStackView* )self;
        stackView.defaultColor = vs.backgroundColor;
        stackView.highlightColor = vs.highlightBackgroundColor;
    }
    
    if (vs.unapplicator) {
        vs.unapplicator(self);
    }
    
    if (vs.applicator) {
        vs.applicator(self);
    }

}


- (void)_applyGestures:(MultiMap<Class, ActionWrapper>)gestures{
    
    if (!gestures.empty()) {
        self.userInteractionEnabled = YES;
    }
    
    static const void* _id = &_id;
    // 移除重用的view上的recognizer
    [self.gestureRecognizers enumerateObjectsUsingBlock:^(__kindof UIGestureRecognizer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (objc_getAssociatedObject(obj, _id)) {
            [self removeGestureRecognizer:obj];
        }
    }];
    
    NSMutableArray *gestureArray = [NSMutableArray array];
    objc_setAssociatedObject(self, _id, gestureArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    for (auto iter=gestures.begin(); iter!=gestures.end(); iter=gestures.equal_range(iter->first).second){
        auto key = iter->first;
        UIGestureRecognizer *gestureRecognizer = [[key alloc] initWithTarget:nil action:nil];
        auto range = gestures.equal_range(key);
        for (auto it=range.first; it!=range.second; it++){
            id<VZFActionWrapper> wrapper = vz_actionWrapper(it->second);
            [gestureArray addObject:wrapper];
            [gestureRecognizer addTarget:wrapper action:@selector(invoke:)];
        }
        
        // 使 stack 在轻按的时候有点击效果
        if (key == [UITapGestureRecognizer class] && [self isKindOfClass:[VZFStackView class]]) {
            gestureRecognizer.cancelsTouchesInView = NO;
        }
        
        // 标记这个recognizer是根据nodeSpec生成的
        objc_setAssociatedObject(gestureRecognizer, _id, @YES, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self addGestureRecognizer:gestureRecognizer];
    }
}


- (void)_applyButtonAttributes:(const ButtonNodeSpecs& )buttonNodeSpecs{
    
    VZFButtonView* btn = (VZFButtonView* )self;
    
    btn.titleLabel.font = buttonNodeSpecs.getFont();
    
    // reset
    for (int state=UIControlStateNormal;state<=UIControlStateFocused;state++) {
        [btn setTitle:nil forState:state];
        [btn setTitleColor:nil forState:state];
        [btn setBackgroundImage:nil forState:state];
        [btn setImage:nil forState:state];
    }
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    for (auto title : buttonNodeSpecs.title) {
        [btn setTitle:title.second forState:title.first];
    }
    
    for (auto color : buttonNodeSpecs.titleColor) {
        [btn setTitleColor:color.second forState:color.first];
    }
    
    for (auto image : buttonNodeSpecs.backgroundImage) {
        [btn setBackgroundImage:image.second forState:image.first];
    }
    
    for (auto image : buttonNodeSpecs.image){
        [btn setImage:image.second forState:image.first];
    }
    
    //enlarge touch area
    if (!CGSizeEqualToSize(CGSizeZero,buttonNodeSpecs.enlargeSize))
    {
        btn.enlargeTouchSize = buttonNodeSpecs.enlargeSize;
    }
    else{
        btn.enlargeTouchSize = CGSizeZero;
    }
    
    [btn removeTarget:nil action:nil forControlEvents:UIControlEventAllEvents];
    static const void* _id = &_id;
    NSMutableArray * actionArray = objc_getAssociatedObject(btn, _id);
    if (actionArray == nil) {
        actionArray = [NSMutableArray array];
        objc_setAssociatedObject(btn, _id, actionArray, OBJC_ASSOCIATION_RETAIN);
    }
    for (auto action : buttonNodeSpecs.action) {
        id<VZFActionWrapper> wrapper = vz_actionWrapper(action.second);
        [actionArray addObject:wrapper];
        [btn addTarget:wrapper action:@selector(invoke:event:) forControlEvents:action.first];
    }
}

- (void)_applyTextAttributes:(const TextNodeSpecs& )textNodeSpecs{
    
    UILabel* label = (UILabel* )self;
    if (textNodeSpecs.attributedString) {
        label.attributedText = textNodeSpecs.attributedString;
    }
    else {
        if (textNodeSpecs.kern != 0 && textNodeSpecs.text.length > 0) {
            NSDictionary *dict = @{NSKernAttributeName:@(textNodeSpecs.kern),
                                   NSLigatureAttributeName:@0};
            label.attributedText = [[NSAttributedString alloc] initWithString:textNodeSpecs.text attributes:dict];
        }
        else {
            label.text = textNodeSpecs.text;
        }
        label.font = textNodeSpecs.getFont();
        label.textColor = textNodeSpecs.color;
    }
    label.textAlignment = textNodeSpecs.alignment;
    label.lineBreakMode = textNodeSpecs.lineBreakMode;
    label.numberOfLines = textNodeSpecs.lines;
}

- (void)_applyImageAttributes:(const ImageNodeSpecs& )imageSpec{
    
    UIImageView<VZFNetworkImageDownloadProtocol>* networkImageView = (UIImageView<VZFNetworkImageDownloadProtocol>* )self;
    networkImageView.image = imageSpec.image;
    networkImageView.contentMode = imageSpec.contentMode;
    
    if (imageSpec.imageUrl.length > 0) {
        //just call protocol
        [networkImageView vz_setImageWithURL:[NSURL URLWithString:imageSpec.imageUrl]
                                        size:self.bounds.size
                            placeholderImage:imageSpec.image
                                  errorImage:imageSpec.errorImage
                                     context:imageSpec.context
                             completionBlock:vz_actionWrapper(imageSpec.completion)];   
    }
    
}

- (void)_applyIndicatorAttributes:(const IndicatorNodeSpecs& )indicatorSpecs{
    
    UIActivityIndicatorView *indicatorView = (UIActivityIndicatorView *)self;
    indicatorView.color = indicatorSpecs.color;
    [indicatorView startAnimating];
    
}

- (void)_applyScrollAttributes:(const VZ::ScrollNodeSpecs& )scrollSpecs{
    
    UIScrollView* scrollView = (UIScrollView* )self;
    scrollView.scrollEnabled = scrollSpecs.scrollEnabled;
    scrollView.pagingEnabled = scrollSpecs.paging;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    VZFScrollNode* scrollNode = (VZFScrollNode* )scrollView.node;
    scrollView.contentSize = scrollNode.contentSize;
    [scrollView setNeedsLayout];
    
}

- (void)_applyPagingAttributes:(const VZ::PagingNodeSpecs& )pagingSpecs{
    
    VZFPagingView* pagingView = (VZFPagingView* )self;
    VZFPagingNode* pagingNode = (VZFPagingNode* )self.node;
    pagingView.scroll = pagingSpecs.scrollEnabled;
    pagingView.autoScroll = pagingSpecs.autoScroll;
    pagingView.loopScroll = pagingSpecs.infiniteLoop;
    pagingView.vertical = pagingSpecs.direction == PagingVertical;
    UICollectionView* collectionView = pagingView.collectionView;
    collectionView.pagingEnabled = pagingSpecs.paging;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    
    pagingView.pageControlEnabled = pagingSpecs.paging && pagingSpecs.pageControl;
    if (pagingSpecs.pageControl) {
        UIPageControl *pageControl = pagingView.pageControl;
        pageControl.backgroundColor = [UIColor clearColor];
        pageControl.userInteractionEnabled = NO;
        pageControl.hidesForSinglePage = YES;
        pageControl.frame = pagingNode.pageControlNode.flexNode.resultFrame;
        pageControl.transform = CGAffineTransformMakeScale(pagingSpecs.pageControlScale, pagingSpecs.pageControlScale);
        pageControl.pageIndicatorTintColor = pagingSpecs.pageControlColor;
        pageControl.currentPageIndicatorTintColor = pagingSpecs.pageControlSelectedColor;
        pageControl.numberOfPages = pagingNode.children.size();
    }
    
    NSMutableArray *subviews = [NSMutableArray array];
    for (const auto& layout : pagingNode.childrenLayout) {
        UIView* view = [[VZFNodeLayoutManager sharedInstance] viewForRootNode:layout ConstrainedSize:self.frame.size];
        [subviews addObject:view];
    }
    [pagingView setChildrenViews:subviews];
    
    [pagingView setNeedsLayout];
    
}

@end
