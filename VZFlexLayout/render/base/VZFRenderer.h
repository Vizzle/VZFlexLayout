//
//  VZFRenderer.h
//  VZFlexLayout-Example
//
//  Created by heling on 2017/1/22.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef struct{
    CGFloat topLeft;
    CGFloat topRight;
    CGFloat bottomLeft;
    CGFloat bottomRight;
} VZFRendererCustomCorner;

VZFRendererCustomCorner vzfRoundedCorner(CGFloat cornerRadis);

@class VZFNode;

@interface VZFRenderer : NSObject

@property(nonatomic, assign) CGRect frame;
@property(nonatomic, strong, nullable) UIColor *backgroundColor;
@property(nonatomic, assign) VZFRendererCustomCorner customCorner;
@property(nonatomic, assign) CGFloat borderWidth;
@property(nonatomic, strong, nullable) UIColor *borderColor;
@property(nonatomic, assign) BOOL opaque;
@property(nonatomic, assign) BOOL clip;
@property(nonatomic, weak, nullable) VZFNode *node;

//can not override by sub class
- (void)drawInContext:(nonnull CGContextRef)context bounds:(CGRect)bounds;

@end


//for sub class to override
@interface VZFRenderer(VZFRendererSubclassing)

- (void)drawContentInContext:(nonnull CGContextRef)context bounds:(CGRect)bounds;

@end


@interface VZFRenderer(VZFRendererHierarchy)

- (nullable VZFRenderer *)superRenderer;
- (nullable NSArray<__kindof VZFRenderer *> *)subRenderers;

- (BOOL)hasSubRenderers;

- (void)removeFromSuperRenderer;


/**
 Insert renderer at specified index

 @param renderer target renderer
 @param index specified index
 */
- (void)insertSubRenderer:(nullable VZFRenderer *)renderer atIndex:(NSInteger)index;


/**
 
 Exchange renderer at index1 and index2.If index1 or index2 is invalid(less than 0 or greater than the count of the receiver's sub renders), it will have no effect.

 @param index1 the index of renderer to be exchanged
 @param index2 the index of renderer to be exchanged
 */
- (void)exchangeSubRendererAtIndex:(NSInteger)index1 withSubRendererAtIndex:(NSInteger)index2;


/**
 Add  renderer to the top of the sub renderers.If the specified renderer is already one of the receiver's sub renderers, it will have no effect.

 @param renderer the renderer to be added
 */
- (void)addSubRenderer:(nullable VZFRenderer *)renderer;


/**
 Insert specified renderer below the sibling sub renderer.If renderer is already one of the receiver's sub renderers or the siblingSubRenderer is not one of the receiver's sub renderers, it will have no effect

 @param renderer the renderer to be inserted
 @param siblingSubRenderer the renderer
 */
- (void)insertSubRenderer:(nullable VZFRenderer *)renderer belowSubRenderer:(nullable VZFRenderer *)siblingSubRenderer;

/**
 Insert specified renderer above the sibling sub renderer.If renderer is already one of the receiver's sub renderers or the siblingSubRenderer is not one of the receiver's sub renderers, it will have no effect
 
 @param renderer the renderer to be inserted
 @param siblingSubRenderer the renderer
 */
- (void)insertSubRenderer:(nullable VZFRenderer *)renderer aboveSubRenderer:(nullable VZFRenderer *)siblingSubRenderer;


/**
 Bring the specified renderer to the front. If the specified renderer is not one the sub renderers, it will have no effect.

 @param renderer the renderer to be operated
 */
- (void)bringSubRendererToFront:(nullable VZFRenderer *)renderer;

/**
 Send the specified renderer to the back. If the specified renderer is not one the sub renderers, it will have no effect.
 
 @param renderer the renderer to be operated
 */
- (void)sendSubRendererToBack:(nullable VZFRenderer *)renderer;


/**
 Returns a Boolean value indicating whether the receiver is a subRenderer of a given renderer or identical to that renderer.
 
 @param renderer The renderer to test against the receiver’s renderer hierarchy.
 
 @return YES if the receiver is an immediate or distant subRenderer of renderer or if renderer is the receiver itself; otherwise NO.
 */
- (BOOL)isDescendantOfRenderer:(nullable VZFRenderer *)renderer;  // returns YES for self.

/**
 Remove all the sub renderers
 */
- (void)removeAllSubRenderers;


@end



@interface VZFRenderer(Accessibility)

@property (assign, nonatomic) BOOL isAccessibilityElement;
@property (nullable, nonatomic, copy) NSString *accessibilityLabel;

//检测当前结点树（当前结点及其子孙）是否是AccessibilityElement，只要这些结点中有一个为YES就返回YES
- (BOOL)checkIsAccessibilityElement;

//检测当前结点树（当前结点及其子孙）中所有isAccessibilityElement为YES的节点，并按照frame拼接这些accessibilityLabel
- (nullable NSString *)compositeAccessibilityLabel;

@end
