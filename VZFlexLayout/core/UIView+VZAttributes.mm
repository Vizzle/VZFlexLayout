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
#import "VZFTextNodeBackingView.h"
#import "VZFTextNodeRenderer.h"
#import "VZFImageNode.h"
#import "VZFImageNodeSpecs.h"
#import "VZFIndicatorNode.h"
#import "VZFIndicatorNodeSpecs.h"
#import "VZFLineNode.h"
#import "VZFLineNodeSpecs.h"
#import "VZFLineView.h"
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
#import "VZFTextFieldNodeSpecs.h"
#import "VZFTextFieldNode.h"
#import "VZFTextField.h"
#import "VZFViewReusePool.h"
#import <objc/runtime.h>
#import "VZFImageNodeBackingView.h"
#import "VZFImageNodeRenderer.h"
#import "VZFButtonNodeBackingView.h"
#import "VZFBackingViewProtocol.h"
#import "VZFSwitchNode.h"
#import "VZFSwitch.h"
#import "VZFPickerNode.h"
#import "VZFPickerView.h"
#import "VZFSegmentedControlNode.h"
#import "VZFSegmentedControl.h"

@implementation UIView (VZAttributes)

- (void)applyAttributes{

    VZFNode* node = self.node;
    
    [self _applyAttributes:node.specs];
    
    [self _applyGestures:node.specs];
    
    // TODO: 待 async display 的代码合入再做优化
    if ([node isKindOfClass:[VZFImageNode class]])
    {
        [self _applyImageAttributes:((VZFImageNode* )node).imageSpecs];
    }
    else if ([node isKindOfClass:[VZFButtonNode class]])
    {
        [self _applyButtonAttributes:((VZFButtonNode* )node).buttonSpecs];
    }
    [self vz_applyNodeAttributes:self.node];
    [self _applyRendererAttributes:node.specs];

}

- (void)vz_applyNodeAttributes:(VZFNode *)node {
    // Backing views implement ...
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
    CGFloat top_left = std::min(top_left_x, top_left_y);
    CGFloat top_right = std::min(top_right_x, top_right_y);
    CGFloat bottom_left = std::min(bottom_left_x, bottom_left_y);
    CGFloat bottom_right = std::min(bottom_right_x, bottom_right_y);
    
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

- (void)_applyRendererAttributes:(const NodeSpecs&)vs {
    if ([self conformsToProtocol:@protocol(VZFBackingViewProtocol)]) {
        VZFBaseRenderer *renderer = [(id<VZFBackingViewProtocol>)self renderer];
        if (renderer) {
            renderer.backgroundColor = vs.backgroundColor;
            renderer.borderWidth = vs.borderWidth;
            renderer.borderColor = vs.borderColor;
            renderer.cornerRadius = vs.cornerRadius;
            renderer.clip = vs.clip;
        }
        [(id<VZFBackingViewProtocol>)self setLayerNeedsAsyncDisplay];
    }
}

- (void)_applyAttributes:(const NodeSpecs&)vs {
    self.tag                    = vs.tag;
    self.backgroundColor        = vs.backgroundColor;
    self.clipsToBounds          = vs.clip;
    self.alpha                  = vs.alpha;
    
    if (vs.isAccessibilityElement != VZF_BOOL_UNDEFINED) {
        self.isAccessibilityElement = vs.isAccessibilityElement;
    }
    
    if (vs.accessibilityLabel) {
        self.accessibilityLabel     = vs.accessibilityLabel;
    }
    
    int userInteractionEnabled = vs.userInteractionEnabled;
    if (userInteractionEnabled != VZF_BOOL_UNDEFINED) {
        self.userInteractionEnabled = userInteractionEnabled;
    }
    
    [self _applyBorder:vs];
    
    if (vs.contents.CGImage) {
        self.layer.contents     = (__bridge id)vs.contents.CGImage;
    }
    
    if ([self isKindOfClass:[VZFStackView class]]) {
        VZFStackView* stackView = (VZFStackView* )self;
        stackView.defaultColor = vs.backgroundColor;
        stackView.highlightColor = vs.highlightBackgroundColor;
    }
    
    self.unapplicator = vs.unapplicator;
    if (vs.applicator) {
        vs.applicator(self);
    }

}

- (void)_applyBorder:(const NodeSpecs&)vs {
    static const void* _id = &_id;
    // 移除重用的 layer
    [self.layer.sublayers.copy enumerateObjectsUsingBlock:^(__kindof CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (objc_getAssociatedObject(obj, _id)) {
            [obj removeFromSuperlayer];
        }
    }];
    
    CGFloat cornerRadiusTopLeft = vs.cornerRadiusTopLeft != VZ::FlexValue::Undefined() ? vs.cornerRadiusTopLeft.value : vs.cornerRadius;
    CGFloat cornerRadiusTopRight = vs.cornerRadiusTopRight != VZ::FlexValue::Undefined() ? vs.cornerRadiusTopRight.value : vs.cornerRadius;
    CGFloat cornerRadiusBottomLeft = vs.cornerRadiusBottomLeft != VZ::FlexValue::Undefined() ? vs.cornerRadiusBottomLeft.value : vs.cornerRadius;
    CGFloat cornerRadiusBottomRight = vs.cornerRadiusBottomRight != VZ::FlexValue::Undefined() ? vs.cornerRadiusBottomRight.value : vs.cornerRadius;
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
        if (vs.borderWidth > 0 && vs.borderColor) {
            CAShapeLayer *strokeLayer = [CAShapeLayer layer];
            strokeLayer.path = path.CGPath;
            strokeLayer.fillColor = [UIColor clearColor].CGColor;
            strokeLayer.strokeColor = vs.borderColor.CGColor;
            strokeLayer.lineWidth = vs.borderWidth * 2;
            objc_setAssociatedObject(strokeLayer, _id, @YES, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            [self.layer addSublayer:strokeLayer];
        }
        // 这里由于有 clip，所以阴影显示有问题
        self.layer.shadowPath = path.CGPath;
    }
    else {
        [self setLayerBorder:vs.borderColor.CGColor borderWidth:vs.borderWidth cornerRadius:cornerRadiusTopLeft];
    }
}

-(void)setLayerBorder:(CGColorRef)color borderWidth:(CGFloat)borderWidth cornerRadius:(CGFloat)cornerRadius{
    self.layer.cornerRadius     = cornerRadius;
    self.layer.borderColor      = color;
    self.layer.borderWidth      = borderWidth;
    self.layer.mask = nil;
}

- (void)_applyGestures:(const NodeSpecs&)vs{
    
    VZFBlockGesture *gesture = vs.gesture;
    
    if (gesture && vs.userInteractionEnabled == INT_MIN) {
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
    if (gesture) {
        UIGestureRecognizer *gestureRecognizer = [[gesture.gestureClass alloc] initWithTarget:nil action:nil];
        [gestureArray addObject:gesture];
        [gestureRecognizer addTarget:gesture action:@selector(invoke:)];
        
        // 使 stack 在轻按的时候有点击效果
        if (gesture.gestureClass == [UITapGestureRecognizer class] && [self isKindOfClass:[VZFStackView class]]) {
            gestureRecognizer.cancelsTouchesInView = NO;
        }
        
        // 标记这个recognizer是根据nodeSpec生成的
        objc_setAssociatedObject(gestureRecognizer, _id, @YES, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self addGestureRecognizer:gestureRecognizer];
    }
}


- (void)_applyButtonAttributes:(const ButtonNodeSpecs& )buttonNodeSpecs{
    
    VZFButtonView* btn = (VZFButtonView* )self;
    
    
    
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
    VZFBlockAction *action = buttonNodeSpecs.action;
    if (action) {
        [actionArray addObject:action];
        [btn addTarget:buttonNodeSpecs.action action:@selector(invoke:event:) forControlEvents:action.controlEvents];
    }
    
    if([btn isKindOfClass:[VZFButtonNodeBackingView class]]){
        [(VZFButtonNodeBackingView *)btn setTitleFont:buttonNodeSpecs.getFont()];
        [(VZFButtonNodeBackingView *)btn setButtonStatus:UIControlStateNormal];
    }else{
        btn.titleLabel.font = buttonNodeSpecs.getFont();
    }
}

- (void)_applyImageAttributes:(const ImageNodeSpecs& )imageSpec{
    
    id<VZFNetworkImageDownloadProtocol> networkImageView = nil;
    
    //gif重复次数，context里拿到设置给imageView。setImage: 中会使用 animationRepeatCount，因此要先设置。
    NSDictionary *ctx = [imageSpec.context isKindOfClass:[NSDictionary class]] ? (NSDictionary *)imageSpec.context : @{};
    int animateCount = [ctx[@"animate-count"] intValue]?:0;
    
    if ([self isKindOfClass:[VZFImageNodeBackingView class]]) {
        VZFImageNodeBackingView *view = (VZFImageNodeBackingView *)self;
        VZFImageNode* imageNode = (VZFImageNode* )self.node;
        imageNode.renderer.animateCount = animateCount;
        imageNode.renderer.scale = self.contentScaleFactor;
        
        view.imageRenderer = imageNode.renderer;
        view.contentMode = imageSpec.contentMode;
        
        networkImageView = view;
        
        if (imageSpec.imageUrl.length <= 0) {
            view.image = imageSpec.image;
        } else {
            view.image = nil;
        }
    } else {
        UIImageView<VZFNetworkImageDownloadProtocol>* view = (UIImageView<VZFNetworkImageDownloadProtocol>* )self;
        view.animationRepeatCount = animateCount;
        view.image = imageSpec.image;
        view.contentMode = imageSpec.contentMode;

        networkImageView = view;
    }
    
    // 这里不做判空，可能会在方法内做清理操作，避免复用可能会导致的图片错乱
    //just call protocol
    
    //FIXED
    NSAssert(!imageSpec.imageUrl ||[imageSpec.imageUrl isKindOfClass:[NSString class]], @"ImageNodeSpecs imageUrl should be a string");

    if ([imageSpec.imageUrl isKindOfClass:[NSString class]]){
        
        [networkImageView vz_setImageWithURL:[NSURL URLWithString:imageSpec.imageUrl]
                                        size:self.bounds.size
                            placeholderImage:imageSpec.image
                                  errorImage:imageSpec.errorImage
                                     context:imageSpec.context
                             completionBlock:imageSpec.completion];
    }
}

@end
