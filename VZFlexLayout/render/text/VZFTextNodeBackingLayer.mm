//
//  VZFTextNodeBackingLayer.m
//  VZFlexLayout
//
//  Created by moxin on 16/9/18.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFTextNodeBackingLayer.h"
#import "VZFTextNodeRenderer.h"
#import "VZFMacros.h"
#import "VZFUtils.h"


@implementation VZFTextNodeBackingLayer

-(BOOL)asyncDisplay{
    return NO;//text node不会有子结点，暂时一定同步绘制
}

+ (nullable id)defaultValueForKey:(NSString *)key{
    
    if ([key isEqualToString:@"contentsScale"]) {
        return @(VZ::Helper::screenScale());
    } else if ([key isEqualToString:@"backgroundColor"]) {
        return (id)[UIColor clearColor].CGColor;
    } else if ([key isEqualToString:@"opaque"]) {
        return (id)kCFBooleanTrue;
    } else if ([key isEqualToString:@"userInteractionEnabled"]) {
        return (id)kCFBooleanTrue;
    } else if ([key isEqualToString:@"needsDisplayOnBoundsChange"]) {
        return (id)kCFBooleanTrue;
    }
    return [super defaultValueForKey:key];
    
    
}
- (void)setNeedsDisplayOnBoundsChange:(BOOL)needsDisplayOnBoundsChange{
    
    // Don't allow this property to be disabled.  Unfortunately, UIView will turn this off when setting the
    // backgroundColor, for reasons that cannot be understood.  Even worse, it doesn't ever set it back, so it will
    // subsequently stay off.  Just make sure that it never gets overridden, because the text will not be drawn in the
    // correct way (or even at all) if this is set to NO.
    if (needsDisplayOnBoundsChange) {
        [super setNeedsDisplayOnBoundsChange:needsDisplayOnBoundsChange];
    }
}

///////////////////////////////////////////////////////////////////////////////////
#pragma mark - setter methods

- (void)setRenderer:(VZFTextNodeRenderer *)renderer{
    
    VZFAssertMainThread();
    
//    if (!renderer) {
//        return ;
//    }
//    
//    if (_renderer != renderer) {
//        if (renderer.specs == _renderer.specs) {
//            
//            _renderer = renderer;
//            return;
//        }
//        else{
//            self.contents = nil;
//        }
//    }
    _renderer = renderer;
    [self setNeedsAsyncDisplay];

}

- (void)setEdgeInsets:(UIEdgeInsets)edgeInsets {
    _edgeInsets = edgeInsets;
    self.renderer.edgeInsets = edgeInsets;
}

////////////////////////////////////////////////////////////////////////////////////
#pragma mark - override methods

- (NSObject* )drawParameters{

    return _renderer;
}

- (void)drawInContext:(CGContextRef)context bounds:(CGRect)bounds parameters:(VZFTextNodeRenderer *)renderer{

    [renderer drawInContext:context bounds:bounds];

}

- (void)drawInContext:(CGContextRef)ctx{

    // When we're drawing synchronously we need to manually fill the bg color because superlayer doesn't.
    //在iOS10 UILabel上会显示黑色 所以用super的方法画
//    if (self.opaque && self.backgroundColor != NULL) {
//        CGRect boundsRect = CGContextGetClipBoundingBox(ctx);
//        CGContextSetFillColorWithColor(ctx, self.backgroundColor);
//        CGContextFillRect(ctx, boundsRect);
//    }
    [super drawInContext:ctx];
}

////////////////////////////////////////////////////////////////////////////////////
#pragma mark - subclassing methods

- (id)willDisplayAsynchronouslyWithDrawParameters:(id<NSObject>)drawParameters{

    return nil;
}

- (void)didDisplayAsynchronously:(id)newContents withDrawParameters:(id<NSObject>)drawParameters{

    //noop
}

@end
