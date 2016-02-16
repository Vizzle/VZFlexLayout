//
//  VZFlexNode.m
//  VZFlexLayout
//
//  Created by moxin on 15/12/25.
//  Copyright © 2015年 Vizlab. All rights reserved.
//

#import "VZFlexNode.h"
#import "FlexLayout.h"


@interface VZFlexNode()
{
    FlexNode* _flex_node;
    NSMutableArray* _childNodes;

}

@end

@implementation VZFlexNode

FlexSize flexNodeMeasure(void* context, FlexSize constraintedSize) {
    VZFlexNode* node = (__bridge VZFlexNode*)context;
    CGSize size = [node sizeThatFits:CGSizeMake(constraintedSize.size[FLEX_WIDTH], constraintedSize.size[FLEX_HEIGHT])];
    FlexSize ret;
    ret.size[FLEX_WIDTH] = size.width;
    ret.size[FLEX_HEIGHT] = size.height;
    return ret;
}

FlexNode* flexNodeChildAt(void* context, size_t index) {
    VZFlexNode* node = (__bridge VZFlexNode*)context;
    VZFlexNode* child = node.childNodes[index];
    return child -> _flex_node;
}



////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - setters
- (void)setFixed:(BOOL)fixed {
    _flex_node->fixed = fixed;
}

- (BOOL)fixed {
    return _flex_node -> fixed;
}

- (void)setWrap:(BOOL)wrap {
    _flex_node -> wrap = wrap;
}

- (BOOL)wrap {
    return _flex_node -> wrap;
}

- (void)setDirection:(FlexDirection)direction {
    _flex_node->direction = direction;
}

- (FlexDirection)direction {
    return _flex_node->direction;
}

- (void)setAlignItems:(FlexAlign)alignItems {
    _flex_node->alignItems = alignItems;
}

- (FlexAlign)alignItems {
    return _flex_node->alignItems;
}

- (void)setAlignSelf:(FlexAlign)alignSelf {
    _flex_node->alignSelf = alignSelf;
}

- (FlexAlign)alignSelf {
    return _flex_node->alignSelf;
}

- (void)setAlignContent:(FlexAlign)alignContent {
    _flex_node->alignContent = alignContent;
}

- (FlexAlign)alignContent {
    return _flex_node->alignContent;
}

- (void)setJustifyContent:(FlexAlign)justifyContent {
    _flex_node->justifyContent = justifyContent;
}

- (FlexAlign)justifyContent {
    return _flex_node->justifyContent;
}

- (void)setFlexBasis:(CGFloat)flexBasis {
    _flex_node->flexBasis = flexBasis;
}

- (CGFloat)flexBasis {
    return _flex_node->flexBasis;
}

- (void)setFlexGrow:(CGFloat)flexGrow {
    _flex_node->flexGrow = flexGrow;
}

- (CGFloat)flexGrow {
    return _flex_node->flexGrow;
}

- (void)setFlexShrink:(CGFloat)flexShrink {
    _flex_node->flexShrink = flexShrink;
}

- (CGFloat)flexShrink {
    return _flex_node->flexShrink;
}

- (void)setWidth:(CGFloat)width {
    _flex_node->size[FLEX_WIDTH] = width;
}

- (CGFloat)width {
    return _flex_node->size[FLEX_WIDTH];
}

- (void)setHeight:(CGFloat)height {
    _flex_node->size[FLEX_HEIGHT] = height;
}

- (CGFloat)height {
    return _flex_node->size[FLEX_HEIGHT];
}

- (void)setMinWidth:(CGFloat)minWidth {
    _flex_node->minSize[FLEX_WIDTH] = minWidth;
}

- (CGFloat)minWidth {
    return _flex_node->minSize[FLEX_WIDTH];
}

- (void)setMinHeight:(CGFloat)minHeight {
    _flex_node->minSize[FLEX_HEIGHT] = minHeight;
}

- (CGFloat)minHeight {
    return _flex_node->minSize[FLEX_HEIGHT];
}

- (void)setMaxWidth:(CGFloat)maxWidth {
    _flex_node->maxSize[FLEX_WIDTH] = maxWidth;
}

- (CGFloat)maxWidth {
    return _flex_node->maxSize[FLEX_WIDTH];
}

- (void)setMaxHeight:(CGFloat)maxHeight {
    _flex_node->maxSize[FLEX_HEIGHT] = maxHeight;
}

- (CGFloat)maxHeight {
    return _flex_node->maxSize[FLEX_HEIGHT];
}

- (void)setMarginTop:(CGFloat)marginTop {
    _flex_node->margin[FLEX_TOP] = marginTop;
}

- (CGFloat)marginTop {
    return _flex_node->margin[FLEX_TOP];
}

- (void)setMarginLeft:(CGFloat)marginLeft {
    _flex_node->margin[FLEX_LEFT] = marginLeft;
}

- (CGFloat)marginLeft {
    return _flex_node->margin[FLEX_LEFT];
}

- (void)setMarginBottom:(CGFloat)marginBottom {
    _flex_node->margin[FLEX_BOTTOM] = marginBottom;
}

- (CGFloat)marginBottom {
    return _flex_node->margin[FLEX_BOTTOM];
}

- (void)setMarginRight:(CGFloat)marginRight {
    _flex_node->margin[FLEX_RIGHT] = marginRight;
}

- (CGFloat)marginRight {
    return _flex_node->margin[FLEX_RIGHT];
}

- (void)setMargin:(CGFloat)margin {
    self.marginTop = margin;
    self.marginLeft = margin;
    self.marginBottom = margin;
    self.marginRight = margin;
}

- (CGFloat)margin {
    NSAssert(false, @"");
    return self.marginTop;
}

- (void)setPaddingTop:(CGFloat)paddingTop {
    _flex_node->padding[FLEX_TOP] = paddingTop;
}

- (CGFloat)paddingTop {
    return _flex_node->padding[FLEX_TOP];
}

- (void)setPaddingLeft:(CGFloat)paddingLeft {
    _flex_node->padding[FLEX_LEFT] = paddingLeft;
}

- (CGFloat)paddingLeft {
    return _flex_node->padding[FLEX_LEFT];
}

- (void)setPaddingBottom:(CGFloat)paddingBottom {
    _flex_node->padding[FLEX_BOTTOM] = paddingBottom;
}

- (CGFloat)paddingBottom {
    return _flex_node->padding[FLEX_BOTTOM];
}

- (void)setPaddingRight:(CGFloat)paddingRight {
    _flex_node->padding[FLEX_RIGHT] = paddingRight;
}

- (CGFloat)paddingRight {
    return _flex_node->padding[FLEX_RIGHT];
}

- (void)setPadding:(CGFloat)padding {
    self.paddingTop = padding;
    self.paddingLeft = padding;
    self.paddingBottom = padding;
    self.paddingRight = padding;
}

- (CGFloat)padding {
    NSAssert(false, @"");
    return self.paddingTop;
}



////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - life cycle


- (id)init
{
    self = [super init];
    if (self) {
        
        _flex_node = (FlexNode* )calloc(1, sizeof(*_flex_node));
        initFlexNode(_flex_node);
        _flex_node->context = (__bridge void* )self;
        _flex_node->measure = flexNodeMeasure;
        _flex_node->childAt = flexNodeChildAt;
        _childNodes = [NSMutableArray new];
        
    }
    return self;
}

- (void)dealloc{
    
    free(_flex_node);
    _flex_node = NULL;
}



- (CGRect)resultFrame
{
    return (CGRect) {
        
        .origin.x       = _flex_node -> result.position[0],
        .origin.y       = _flex_node -> result.position[1],
        .size.width     = _flex_node -> result.size[FLEX_WIDTH],
        .size.height    = _flex_node -> result.size[FLEX_HEIGHT]
    };
}

- (UIEdgeInsets)resultMargin{

    return (UIEdgeInsets){
    
        .top    = _flex_node -> result.margin[FLEX_TOP],
        .bottom = _flex_node -> result.margin[FLEX_BOTTOM],
        .left   = _flex_node -> result.margin[FLEX_LEFT],
        .right  = _flex_node -> result.margin[FLEX_RIGHT]

    };
}

- (void)prepareLayout
{
    _flex_node -> childrenCount = (int)self.childNodes.count;
    for(VZFlexNode* node in self.childNodes)
    {
        [node prepareLayout];
    }
    
    _flex_node -> result.size[0] = 0;
    _flex_node -> result.size[1] = 0;
    _flex_node -> result.position[0] = 0;
    _flex_node -> result.position[1] = 0;
    _flex_node -> result.margin[0] = 0;
    _flex_node -> result.margin[1] = 0;
    _flex_node -> result.margin[2] = 0;
    _flex_node -> result.margin[3] = 0;
    
}

- (void)layout:(CGSize)constrainedSize{
    
    //prepare layout递归
    [self prepareLayout];
    
    layoutFlexNode(_flex_node, constrainedSize.width, constrainedSize.height);
    
}

- (CGSize)sizeThatFits:(CGSize)constraintedSize{
    return CGSizeZero;
}

- (void)addSubNode:(VZFlexNode* )node{
    
    [_childNodes addObject:node];
    _flex_node -> childrenCount = (int)self.childNodes.count;
}

- (void)removeSubNode:(VZFlexNode* )node{
    
    [_childNodes removeObject:node];
    _flex_node -> childrenCount = (int)self.childNodes.count;

}





@end
