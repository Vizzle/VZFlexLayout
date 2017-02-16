//
//  VZFRenderer.m
//  VZFlexLayout-Example
//
//  Created by heling on 2017/1/22.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import "VZFRenderer.h"
#import "UIBezierPath+extension.h"
#import "VZFNode.h"

VZFRendererCustomCorner vzfRoundedCorner(CGFloat cornerRadis) {
    return (VZFRendererCustomCorner){cornerRadis, cornerRadis, cornerRadis, cornerRadis};
};


@interface VZFRenderer()
{
    __weak VZFRenderer *_superRenderer;
    NSMutableArray<__kindof VZFRenderer *> *_subRenderers;
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

- (void)applyAttributes:(VZFNode *)node {
    
}

//can not override by sub class
- (void)drawInContext:(CGContextRef)context bounds:(CGRect)bounds {
    CGContextSaveGState(context);
    
    UIBezierPath *borderPath = [self borderPathForBounds:bounds corner:self.customCorner];
    
    if (self.clip) {
        CGContextBeginPath(context);
        CGContextAddPath(context, borderPath.CGPath);
        CGContextClip(context);
    }

    //background should be clipped no matter if clip is YES or NO, so use border path to fill
    [self drawBackgroundColor:context path:borderPath];
    [self drawContentInContext:context bounds:bounds];
    
    for (VZFRenderer *renderer in _subRenderers) {
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
        || !self.borderColor
        || !borderPath) {
        return;
    }
    
    CGContextSaveGState(context);
    
    CGContextBeginPath(context);
    CGContextAddPath(context, borderPath.CGPath);
    CGContextClip(context);//clip and cealr current path
    CGContextAddPath(context, borderPath.CGPath);

    CGContextSetStrokeColorWithColor(context, self.borderColor.CGColor);
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
            return [UIBezierPath roundRectPathWithWidth:bounds.size.width height:bounds.size.height topLeftRadius:corner.topLeft topRightRadius:corner.topRight bottomLeftRadius:corner.bottomLeft bottomRightRadius:corner.bottomRight];
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
    return [_subRenderers copy];
}

- (void)removeFromSuperRenderer {
    [_superRenderer removeSubRenderer:self];
}

//private
- (void)removeSubRenderer:(VZFRenderer *)subRenderer {
    if (![subRenderer isKindOfClass:[VZFRenderer class]]) {
        return;
    }
    [_subRenderers removeObject:subRenderer];
}

- (void)insertSubRenderer:(VZFRenderer *)renderer atIndex:(NSInteger)index {
    if (![renderer isKindOfClass:[VZFRenderer class]]) {
        return;
    }
    
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
    if (![renderer isKindOfClass:[VZFRenderer class]]
        || [_subRenderers containsObject:renderer]) {
        return;
    }
    
    if (!_subRenderers) {
        _subRenderers = [NSMutableArray array];
    }
    
    if (renderer->_superRenderer && renderer->_superRenderer != self) {
        [renderer removeFromSuperRenderer];
    }
    
    [_subRenderers addObject:renderer];
    renderer->_superRenderer = self;
}

- (void)insertSubRenderer:(VZFRenderer *)renderer belowSubRenderer:(VZFRenderer *)siblingSubRenderer {
    [self insertSubRenderer:renderer nearSubRenderer:siblingSubRenderer isAbove:NO];
}

- (void)insertSubRenderer:(VZFRenderer *)renderer aboveSubRenderer:(VZFRenderer *)siblingSubRenderer {
    [self insertSubRenderer:renderer nearSubRenderer:siblingSubRenderer isAbove:YES];
}


- (void)insertSubRenderer:(VZFRenderer *)renderer nearSubRenderer:(VZFRenderer *)siblingSubRenderer isAbove:(BOOL)isAbove {
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
    if (![renderer isKindOfClass:[VZFRenderer class]]
        || ![_subRenderers containsObject:renderer]) {
        return;
    }
    
    [_subRenderers removeObject:renderer];
    [_subRenderers addObject:renderer];
    renderer->_superRenderer = self;
}

- (void)sendSubRendererToBack:(VZFRenderer *)renderer {
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
    
    for (VZFRenderer *subRender in _subRenderers) {
        if ([renderer isDescendantOfRenderer:subRender]) {
            return YES;
        }
    }
    
    return NO;
}

- (void)removeAllSubRenderers {
    [_subRenderers removeAllObjects];
}


@end
