//
//  VZFRenderer.m
//  VZFlexLayout-Example
//
//  Created by heling on 2017/1/22.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import "VZFRenderer.h"
#import "UIBezierPath+vzextension.h"
#import "VZFNode.h"
#import <stack>
#import "VZFLocker.h"

VZFRendererCustomCorner vzfRoundedCorner(CGFloat cornerRadis) {
    return (VZFRendererCustomCorner){cornerRadis, cornerRadis, cornerRadis, cornerRadis};
};


@interface VZFRenderer()
{
    __weak VZFRenderer *_superRenderer;
    NSMutableArray<__kindof VZFRenderer *> *_subRenderers;
    
    VZ::RecursiveMutex _subRenderersLock; //

}

@end

@implementation VZFRenderer

-(void)setBackgroundColor:(UIColor *)backgroundColor{
    _backgroundColor = backgroundColor;
    [self updateOpaque];
}

- (void)setCustomCorner:(VZFRendererCustomCorner)customCorner {
    _customCorner = customCorner;
    [self updateOpaque];
}

- (BOOL)hasCorner {
    return _customCorner.topLeft > 0
    || _customCorner.topRight > 0
    || _customCorner.bottomLeft > 0
    || _customCorner.bottomRight > 0;
    
}

-(void)updateOpaque{
    CGFloat alpha = 0.0;
    if (_backgroundColor && ([_backgroundColor getRed:NULL green:NULL blue:NULL alpha:&alpha] ||
        [_backgroundColor getWhite:NULL alpha:&alpha] ||
        [_backgroundColor getHue:NULL saturation:NULL brightness:NULL alpha:&alpha])) {
        if (alpha == 1.0 && ![self hasCorner]) {
            //不透明 && 没有圆角才可以设置为不透明
            _opaque = YES;
            return;
        }
    }

    _opaque = NO;
}


//can not override by sub class
- (void)drawInContext:(CGContextRef)context bounds:(CGRect)bounds {
    CGContextSaveGState(context);
    bounds.origin.x = round(bounds.origin.x * VZ::Helper::screenScale())/VZ::Helper::screenScale();
    bounds.origin.y = round(bounds.origin.y * VZ::Helper::screenScale())/VZ::Helper::screenScale();
    
    UIBezierPath *borderPath = [self borderPathForBounds:bounds corner:self.customCorner];
    
    if (self.clip) {
        CGContextBeginPath(context);
        CGContextAddPath(context, borderPath.CGPath);
        CGContextClip(context);
    }

    //background should be clipped no matter if clip is YES or NO, so use border path to fill
    [self drawBackgroundColor:context path:borderPath];
    [self drawContentInContext:context bounds:bounds];
    
    NSArray<__kindof VZFRenderer *> *subRenderers = [self subRenderers];
    
    for (VZFRenderer *renderer in subRenderers) {
        CGRect frame = renderer.frame;
        CGContextTranslateCTM(context, frame.origin.x, frame.origin.y);
        
        [renderer drawInContext:context bounds:{{0, 0}, frame.size}];
        
        CGContextTranslateCTM(context, -frame.origin.x, -frame.origin.y);//restore
    }

    [self drawBorder:context path:borderPath];
    
    CGContextRestoreGState(context);

}

- (void)drawBackgroundColor:(CGContextRef)context path:(UIBezierPath *)path {
    if (!self.backgroundColor) {
        return;
    }
    
    
    CGContextSaveGState(context);
    
    CGContextSetFillColorWithColor(context, self.backgroundColor.CGColor);
    CGContextBeginPath(context);
    CGContextAddPath(context, path.CGPath);
    CGContextFillPath(context);
    
    CGContextRestoreGState(context);
}

- (void)drawBorder:(CGContextRef)context path:(UIBezierPath *)borderPath {
    if (self.borderWidth <= 0
        || !borderPath) {
        return;
    }
    
    UIColor *borderColor = self.borderColor;
    if (!borderColor) {
        borderColor = [UIColor blackColor];
    }
    
    CGContextSaveGState(context);
    
    CGContextBeginPath(context);
    CGContextAddPath(context, borderPath.CGPath);
    CGContextClip(context);//clip and cealr current path
    CGContextAddPath(context, borderPath.CGPath);

    CGContextSetStrokeColorWithColor(context, borderColor.CGColor);
    //we have set bounds as the clip path.So we set 2 times line width, and clip 1 time width lefting 1 time width;
    CGContextSetLineWidth(context, self.borderWidth * 2);
    CGContextDrawPath(context, kCGPathStroke);
    
    CGContextRestoreGState(context);

}


- (UIBezierPath *)borderPathForBounds:(CGRect)bounds corner:(VZFRendererCustomCorner)corner {
    if (corner.topLeft > 0
        || corner.topRight > 0
        || corner.bottomLeft > 0
        || corner.bottomRight > 0) {
        if (corner.topLeft != corner.topRight
            || corner.topRight != corner.bottomLeft
            || corner.bottomLeft != corner.bottomRight) {
            return [UIBezierPath vz_roundRectPathWithWidth:bounds.size.width height:bounds.size.height topLeftRadius:corner.topLeft topRightRadius:corner.topRight bottomLeftRadius:corner.bottomLeft bottomRightRadius:corner.bottomRight];
        } else {
            //about corner
            //http://stackoverflow.com/questions/22453095/why-does-applying-a-bezierpathwithroundedrect-mask-yield-a-different-result-from
            //http://www.mani.de/backstage/?p=483
            return [UIBezierPath bezierPathWithRoundedRect:bounds cornerRadius:corner.topLeft];
        }
    } else {
        return [UIBezierPath bezierPathWithRect:bounds];
    }
}


- (void)drawContentInContext:(CGContextRef)context bounds:(CGRect)bounds {
    //overrided by sub class
}



#pragma mark - VZFRendererHierarchy

- (nullable VZFRenderer *)superRenderer {
    return _superRenderer;
}

- (nullable NSArray<__kindof VZFRenderer *> *)subRenderers {
    VZ::MutexLocker l(_subRenderersLock);
    return [_subRenderers copy];
}

- (BOOL)hasSubRenderers {
    VZ::MutexLocker l(_subRenderersLock);
    return [_subRenderers count] > 0;
}

- (void)removeFromSuperRenderer {
    [_superRenderer removeSubRenderer:self];
}

//private
- (void)removeSubRenderer:(VZFRenderer *)subRenderer {
    if (![subRenderer isKindOfClass:[VZFRenderer class]]) {
        return;
    }
    
    VZ::MutexLocker l(_subRenderersLock);
    [_subRenderers removeObject:subRenderer];
}

- (void)insertSubRenderer:(VZFRenderer *)renderer atIndex:(NSInteger)index {
    if (![renderer isKindOfClass:[VZFRenderer class]]) {
        return;
    }
    
    VZ::MutexLocker l(_subRenderersLock);

    if (index < 0 || index > _subRenderers.count){
        return;
    }
    
    if (!_subRenderers) {
        _subRenderers = [NSMutableArray array];
    }
    
    if (renderer->_superRenderer && renderer->_superRenderer != self) {
        [renderer removeFromSuperRenderer];
    }
    
    [_subRenderers insertObject:renderer atIndex:index];
    renderer->_superRenderer = self;

}

- (void)exchangeSubRendererAtIndex:(NSInteger)index1 withSubRendererAtIndex:(NSInteger)index2 {
    VZ::MutexLocker l(_subRenderersLock);
    if (index1 < 0 || index1 > _subRenderers.count
        || index2 < 0 || index2 > _subRenderers.count){
        return;
    }
    
    if (!_subRenderers) {
        _subRenderers = [NSMutableArray array];
    }
    
    [_subRenderers exchangeObjectAtIndex:index1 withObjectAtIndex:index2];
}

- (void)addSubRenderer:(VZFRenderer *)renderer {
    {
        VZ::MutexLocker l(_subRenderersLock);
        
        if (![renderer isKindOfClass:[VZFRenderer class]]
            || [_subRenderers containsObject:renderer]) {
            return;
        }
        
        if (!_subRenderers) {
            _subRenderers = [NSMutableArray array];
        }
    }
   
    
    if (renderer->_superRenderer && renderer->_superRenderer != self) {
        [renderer removeFromSuperRenderer];
    }
    
    {
        VZ::MutexLocker l(_subRenderersLock);
        [_subRenderers addObject:renderer];
    }
    renderer->_superRenderer = self;
}

- (void)insertSubRenderer:(VZFRenderer *)renderer belowSubRenderer:(VZFRenderer *)siblingSubRenderer {
    [self insertSubRenderer:renderer nearSubRenderer:siblingSubRenderer isAbove:NO];
}

- (void)insertSubRenderer:(VZFRenderer *)renderer aboveSubRenderer:(VZFRenderer *)siblingSubRenderer {
    [self insertSubRenderer:renderer nearSubRenderer:siblingSubRenderer isAbove:YES];
}


- (void)insertSubRenderer:(VZFRenderer *)renderer nearSubRenderer:(VZFRenderer *)siblingSubRenderer isAbove:(BOOL)isAbove {
    
    VZ::MutexLocker l(_subRenderersLock);
    if (![renderer isKindOfClass:[VZFRenderer class]]
        || ![siblingSubRenderer isKindOfClass:[VZFRenderer class]]
        || [_subRenderers containsObject:renderer]) {
        return;
    }
    
    NSUInteger idx = [_subRenderers indexOfObject:siblingSubRenderer];
    
    if (idx == NSNotFound || idx >= [_subRenderers count]) {
        return;
    }
    
    if (renderer->_superRenderer && renderer->_superRenderer != self) {
        [renderer removeFromSuperRenderer];
    }
    
    [_subRenderers insertObject:renderer atIndex:idx + (isAbove ? 1 : 0)];
    renderer->_superRenderer = self;
}


- (void)bringSubRendererToFront:(VZFRenderer *)renderer {
    VZ::MutexLocker l(_subRenderersLock);
    if (![renderer isKindOfClass:[VZFRenderer class]]
        || ![_subRenderers containsObject:renderer]) {
        return;
    }
    
    [_subRenderers removeObject:renderer];
    [_subRenderers addObject:renderer];
    renderer->_superRenderer = self;
}

- (void)sendSubRendererToBack:(VZFRenderer *)renderer {
    VZ::MutexLocker l(_subRenderersLock);
    if (![renderer isKindOfClass:[VZFRenderer class]]
        || ![_subRenderers containsObject:renderer]) {
        return;
    }
    
    [_subRenderers removeObject:renderer];
    [_subRenderers insertObject:renderer atIndex:0];
    renderer->_superRenderer = self;
}

- (BOOL)isDescendantOfRenderer:(VZFRenderer *)renderer {
    if (![renderer isKindOfClass:[VZFRenderer class]]) {
        return NO;
    }
    
    if (renderer == self) {
        return YES;
    }
    
    VZ::MutexLocker l(_subRenderersLock);

    for (VZFRenderer *subRender in _subRenderers) {
        if ([renderer isDescendantOfRenderer:subRender]) {
            return YES;
        }
    }
    
    return NO;
}

- (void)removeAllSubRenderers {
    VZ::MutexLocker l(_subRenderersLock);
    [_subRenderers removeAllObjects];
}

#pragma mark - Accessibility


- (BOOL)checkIsAccessibilityElement {
    __block BOOL isAccessibilityElement = NO;
    
    [self dfsVisitSelfTree:^(VZFRenderer *renderer, BOOL *stop, BOOL *ignoreChildren) {
        if ([renderer isKindOfClass:[VZFRenderer class]]
            && [renderer isAccessibilityElement]) {
            isAccessibilityElement = YES;
            if (stop) {
                *stop = YES;
            }
        }
    }];
    
    return isAccessibilityElement;
}

- (NSString *)compositeAccessibilityLabel {
    NSMutableString *accessibilityLabel = [NSMutableString string];
    
    [self dfsVisitSelfTree:^(VZFRenderer *renderer, BOOL *stop, BOOL *ignoreChildren) {
        if ([renderer isKindOfClass:[VZFRenderer class]]
            && [renderer isAccessibilityElement]
            && renderer.accessibilityLabel.length > 0) {
            if (accessibilityLabel.length > 0) {
                [accessibilityLabel appendString:@" "];
            }
            [accessibilityLabel appendString:renderer.accessibilityLabel];
            if (ignoreChildren) {
                *ignoreChildren = YES;
            }
        }
    }];
    
    return accessibilityLabel.length > 0 ? [accessibilityLabel copy] : nil;
}

//深度优先遍历当前结点为根的树,包括自己
- (void)dfsVisitSelfTree:(void (^)(VZFRenderer *renderer, BOOL *stop, BOOL *ignoreChildren))action {
    
    if (action == NULL) {
        return;
    }
    
    struct VisitedItem{
        VZFRenderer* renderer;
    };
    
    std::stack<VisitedItem> stack = {};
    stack.push({self});
    
    //深度优先遍历
    while (!stack.empty()) {
        
        //这里面取引用，因为要改变它的状态
        VisitedItem& item = stack.top();
            
        BOOL stop = NO;
        BOOL ignoreChildren = NO;
        
        action(item.renderer, &stop, &ignoreChildren);
        
        if (stop) {
            break;
        }
        
        //下面2个顺序不能变，否则会有问题,item.renderer会变nil
        NSArray<__kindof VZFRenderer *> *subRenderers = [item.renderer subRenderers];
        stack.pop();
        
        if ([subRenderers count] > 0 && !ignoreChildren) {
            //倒序
            for (NSInteger index = [subRenderers count] - 1; index >= 0; --index) {
                VZFRenderer *subRenderer = [subRenderers objectAtIndex:index];
                if ([subRenderer isKindOfClass:[VZFRenderer class]]) {
                    stack.push({subRenderer});
                }
            }
        }
    }
}

@end
