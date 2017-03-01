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
#import "UIBezierPath+extension.h"

@implementation UIView (VZAttributes)

- (void)applyAttributes{

    VZFNode* node = self.node;
    
    [self _applyAttributes:node.specs];
    
    [self _applyGestures:node.specs];

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
    return [UIBezierPath roundRectPathWithWidth:width height:height topLeftRadius:topLeftRadius topRightRadius:topRightRadius bottomLeftRadius:bottomLeftRadius bottomRightRadius:bottomRightRadius];
}

- (void)_applyRendererAttributes:(const NodeSpecs&)vs {
    if ([self conformsToProtocol:@protocol(VZFBackingViewProtocol)]) {
        VZFRenderer *renderer = [(id<VZFBackingViewProtocol>)self renderer];
        if (renderer) {
            renderer.backgroundColor = vs.backgroundColor;
            renderer.borderWidth = vs.borderWidth;
            renderer.borderColor = vs.borderColor;
            renderer.clip = vs.clip;
            
            //begin accessibility
            BOOL isTextRenderer = [renderer isKindOfClass:[VZFTextNodeRenderer class]];
            if (vs.isAccessibilityElement != VZF_BOOL_UNDEFINED) {
                renderer.isAccessibilityElement = vs.isAccessibilityElement;
            } else {
                //VZFTextNodeRenderer默认为YES
                renderer.isAccessibilityElement = isTextRenderer;
            }
            
            renderer.accessibilityLabel = vs.accessibilityLabel;
            if (renderer.accessibilityLabel.length <= 0
                && isTextRenderer) {
                renderer.accessibilityLabel = [[(VZFTextNodeRenderer *)renderer text] string];
            }
            //end accessibility
            
            //custom corner
            CGFloat cornerRadiusTopLeft = vs.cornerRadiusTopLeft != VZ::FlexValue::Undefined() ? vs.cornerRadiusTopLeft.value : vs.cornerRadius;
            CGFloat cornerRadiusTopRight = vs.cornerRadiusTopRight != VZ::FlexValue::Undefined() ? vs.cornerRadiusTopRight.value : vs.cornerRadius;
            CGFloat cornerRadiusBottomLeft = vs.cornerRadiusBottomLeft != VZ::FlexValue::Undefined() ? vs.cornerRadiusBottomLeft.value : vs.cornerRadius;
            CGFloat cornerRadiusBottomRight = vs.cornerRadiusBottomRight != VZ::FlexValue::Undefined() ? vs.cornerRadiusBottomRight.value : vs.cornerRadius;
            renderer.customCorner = {cornerRadiusTopLeft, cornerRadiusTopRight, cornerRadiusBottomLeft, cornerRadiusBottomRight};
            
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
    if ([self isKindOfClass:[VZFTextNodeBackingView class]]) {
        return;
    }
    
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
@end
