//
//  VZFlexNode.m
//  VZFlexLayout
//
//  Created by moxin on 15/12/25.
//  Copyright © 2015年 Vizlab. All rights reserved.
//

#import "VZFlexNode.h"
#import "FlexLayout.h"
#import "VZFLength.h"
#import "VZFlexNode+VZFNode.h"      // 暂时 import 进来，后面直接代码放进来
#import "VZFNode.h"
#import <libkern/OSAtomic.h>

NSString *vz_boolToNSString(BOOL value) {
    return value ? @"true" : @"false";
}

NSString *vz_directionToNSString(FlexDirection value) {
    switch (value) {
        case FlexHorizontal:
            return @"horizontal";
        case FlexHorizontalReverse:
            return @"horizontal-reverse";
        case FlexVertical:
            return @"vertical";
        case FlexVerticalReverse:
            return @"vertical-reverse";
    }
}

NSString *vz_floatToNSString(CGFloat value) {
    if (value == VZ::FlexValue::Auto()) {
        return @"auto";
    }
    else if (value == VZ::FlexValue::Undefined()) {
        return @"undefined";
    }
    
    NSString *s = [NSString stringWithFormat:@"%f", value];
    int i = (int)s.length - 1;
    for (;i>=0;i--) {
        if ([s characterAtIndex:i] != '0') {
            break;
        }
    }
    if (i >= 0 && [s characterAtIndex:i] == '.') i--;
    return [s substringToIndex:i + 1];
}

NSString *vz_FlexLengthToNSString(FlexLength length) {
    if (length.value == VZ::FlexValue::Auto()) {
        return @"auto";
    }
    else if (length.value == VZ::FlexValue::Undefined()) {
        return @"undefined";
    }
    else {
        NSString *number = vz_floatToNSString(length.value);
        NSString *suffix = length.type == FlexLengthTypePercent ? @"%"
                            : length.type == FlexLengthTypePx ? @"px"
                            : length.type == FlexLengthTypeCm ? @"cm"
                            : length.type == FlexLengthTypeMm ? @"mm"
                            : length.type == FlexLengthTypeCm ? @"cm"
                            : length.type == FlexLengthTypeQ ? @"q"
                            : length.type == FlexLengthTypeIn ? @"in"
                            : length.type == FlexLengthTypePc ? @"pc"
                            : length.type == FlexLengthTypePt ? @"pt"
                            : length.type == FlexLengthTypeEm ? @"em"
//                            : length.type == FlexLengthTypeEx ? @"ex"
//                            : length.type == FlexLengthTypeCh ? @"ch"
//                            : length.type == FlexLengthTypeRem ? @"rem"
                            : length.type == FlexLengthTypeVw ? @"vw"
                            : length.type == FlexLengthTypeVh ? @"vh"
                            : length.type == FlexLengthTypeVmin ? @"vmin"
                            : length.type == FlexLengthTypeVmax ? @"vmax" : @"";
        return [number stringByAppendingString:suffix];
    }
}

NSString *vz_alignToNSString(FlexAlign align) {
    switch (align) {
        case FlexInherit:
            return @"auto";
        case FlexStretch:
            return @"stretch";
        case FlexStart:
            return @"flex-start";
        case FlexCenter:
            return @"center";
        case FlexEnd:
            return @"flex-end";
        case FlexSpaceBetween:
            return @"space-between";
        case FlexSpaceAround:
            return @"space-around";
        case FlexBaseline:
            return @"baseline";
    }
}

VZFlexNode *vz_defaultVZFlexNode() {
    static VZFlexNode* node;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        node = [[VZFlexNode alloc] init];
    });
    return node;
}


@interface VZFlexNode()
{
    FlexNode* _flex_node;
    NSMutableArray* _childNodes;
    OSSpinLock _lock;

}

@end

@implementation VZFlexNode

FlexSize flexNodeMeasure(void* context, FlexSize constrainedSize) {
    VZFlexNode* node = (__bridge VZFlexNode*)context;
    CGSize size = node.measure ? node.measure(CGSizeMake(constrainedSize.size[FLEX_WIDTH], constrainedSize.size[FLEX_HEIGHT])) : CGSizeZero;
    FlexSize ret;
    ret.size[FLEX_WIDTH] = size.width;
    ret.size[FLEX_HEIGHT] = size.height;
    return ret;
}

float flexNodeBaseline(void* context, FlexSize constrainedSize) {
    VZFlexNode* node = (__bridge VZFlexNode*)context;
    return node.baseline ? node.baseline(CGSizeMake(constrainedSize.size[FLEX_WIDTH], constrainedSize.size[FLEX_HEIGHT])) : 0;
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

- (void)setFlexBasis:(FlexLength)flexBasis {
    _flex_node->flexBasis = flexBasis;
}

- (FlexLength)flexBasis {
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

- (void)setSpacing:(FlexLength)spacing {
    _flex_node->spacing = spacing;
}

- (FlexLength)spacing {
    return _flex_node->spacing;
}

- (void)setLineSpacing:(FlexLength)lineSpacing {
    _flex_node->lineSpacing = lineSpacing;
}

- (FlexLength)lineSpacing {
    return _flex_node->lineSpacing;
}

- (void)setWidth:(FlexLength)width {
    _flex_node->size[FLEX_WIDTH] = width;
}

- (FlexLength)width {
    return _flex_node->size[FLEX_WIDTH];
}

- (void)setHeight:(FlexLength)height {
    _flex_node->size[FLEX_HEIGHT] = height;
}

- (FlexLength)height {
    return _flex_node->size[FLEX_HEIGHT];
}

- (void)setMinWidth:(FlexLength)minWidth {
    _flex_node->minSize[FLEX_WIDTH] = minWidth;
}

- (FlexLength)minWidth {
    return _flex_node->minSize[FLEX_WIDTH];
}

- (void)setMinHeight:(FlexLength)minHeight {
    _flex_node->minSize[FLEX_HEIGHT] = minHeight;
}

- (FlexLength)minHeight {
    return _flex_node->minSize[FLEX_HEIGHT];
}

- (void)setMaxWidth:(FlexLength)maxWidth {
    _flex_node->maxSize[FLEX_WIDTH] = maxWidth;
}

- (FlexLength)maxWidth {
    return _flex_node->maxSize[FLEX_WIDTH];
}

- (void)setMaxHeight:(FlexLength)maxHeight {
    _flex_node->maxSize[FLEX_HEIGHT] = maxHeight;
}

- (FlexLength)maxHeight {
    return _flex_node->maxSize[FLEX_HEIGHT];
}

- (void)setMarginTop:(FlexLength)marginTop {
    _flex_node->margin[FLEX_TOP] = marginTop;
}

- (FlexLength)marginTop {
    return _flex_node->margin[FLEX_TOP];
}

- (void)setMarginLeft:(FlexLength)marginLeft {
    _flex_node->margin[FLEX_LEFT] = marginLeft;
}

- (FlexLength)marginLeft {
    return _flex_node->margin[FLEX_LEFT];
}

- (void)setMarginBottom:(FlexLength)marginBottom {
    _flex_node->margin[FLEX_BOTTOM] = marginBottom;
}

- (FlexLength)marginBottom {
    return _flex_node->margin[FLEX_BOTTOM];
}

- (void)setMarginRight:(FlexLength)marginRight {
    _flex_node->margin[FLEX_RIGHT] = marginRight;
}

- (FlexLength)marginRight {
    return _flex_node->margin[FLEX_RIGHT];
}

- (void)setMargin:(FlexLength)margin {
    self.marginTop = margin;
    self.marginLeft = margin;
    self.marginBottom = margin;
    self.marginRight = margin;
}

- (FlexLength)margin {
    NSAssert(false, @"");
    return self.marginTop;
}

- (void)setPaddingTop:(FlexLength)paddingTop {
    _flex_node->padding[FLEX_TOP] = paddingTop;
}

- (FlexLength)paddingTop {
    return _flex_node->padding[FLEX_TOP];
}

- (void)setPaddingLeft:(FlexLength)paddingLeft {
    _flex_node->padding[FLEX_LEFT] = paddingLeft;
}

- (FlexLength)paddingLeft {
    return _flex_node->padding[FLEX_LEFT];
}

- (void)setPaddingBottom:(FlexLength)paddingBottom {
    _flex_node->padding[FLEX_BOTTOM] = paddingBottom;
}

- (FlexLength)paddingBottom {
    return _flex_node->padding[FLEX_BOTTOM];
}

- (void)setPaddingRight:(FlexLength)paddingRight {
    _flex_node->padding[FLEX_RIGHT] = paddingRight;
}

- (FlexLength)paddingRight {
    return _flex_node->padding[FLEX_RIGHT];
}

- (void)setPadding:(FlexLength)padding {
    self.paddingTop = padding;
    self.paddingLeft = padding;
    self.paddingBottom = padding;
    self.paddingRight = padding;
}

- (FlexLength)padding {
    NSAssert(false, @"");
    return self.paddingTop;
}

- (void)setMeasure:(CGSize (^)(CGSize))measure {
    _measure = measure;
    _flex_node->measure = measure ? flexNodeMeasure : NULL;
}

- (void)setBaseline:(CGFloat (^)(CGSize))baseline {
    _baseline = baseline;
    _flex_node->baseline = baseline ? flexNodeBaseline : NULL;
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - life cycle


- (id)init
{
    self = [super init];
    if (self) {
        
        _flex_node = (FlexNode* )calloc(1, sizeof(*_flex_node));
       
        if (_flex_node != NULL) {
            
            initFlexNode(_flex_node);
            _flex_node->context = (__bridge void* )self;
            _flex_node->childAt = flexNodeChildAt;
            _childNodes = [NSMutableArray new];
            
            //使用一个spinlock来保护 _childNodes的多线程读写情况
            _lock = OS_SPINLOCK_INIT;
        }

        
    }
    return self;
}

- (void)dealloc{
    
    freeFlexNode(_flex_node);
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

- (UIEdgeInsets)resultPadding{
    
    return (UIEdgeInsets){
        
        .top    = _flex_node -> resolvedPadding[FLEX_TOP],
        .bottom = _flex_node -> resolvedPadding[FLEX_BOTTOM],
        .left   = _flex_node -> resolvedPadding[FLEX_LEFT],
        .right  = _flex_node -> resolvedPadding[FLEX_RIGHT]
        
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
    
    layoutFlexNode(_flex_node, constrainedSize.width, constrainedSize.height, [UIScreen mainScreen].scale);
    
}

- (void)addSubNode:(VZFlexNode* )node{
    
    OSSpinLockLock(&_lock);
    [_childNodes addObject:node];
    OSSpinLockUnlock(&_lock);
    
    _flex_node -> childrenCount = (int)self.childNodes.count;
}

- (void)removeSubNode:(VZFlexNode* )node{
    
    OSSpinLockLock(&_lock);
    [_childNodes removeObject:node];
    OSSpinLockUnlock(&_lock);
    
    _flex_node -> childrenCount = (int)self.childNodes.count;

}

- (NSString *)propertiesDescription:(VZFlexNodeDescriptionOption)option {
    NSMutableString *ret = [[NSMutableString alloc] init];
    BOOL showUnspecified = !(option & VZFlexNodeDescriptionOptionHideUnspecified);
    
#define PRINT_PROP(PROP, TYPE) if (showUnspecified || self.PROP != vz_defaultVZFlexNode().PROP) \
[ret appendFormat:@"  " #PROP " = %@\n", vz_##TYPE##ToNSString(self.PROP)];
    
    PRINT_PROP(fixed, bool);
    PRINT_PROP(wrap, bool);
    PRINT_PROP(direction, direction);
    PRINT_PROP(alignItems, align);
    PRINT_PROP(alignSelf, align);
    PRINT_PROP(alignContent, align);
    PRINT_PROP(justifyContent, align);
    PRINT_PROP(flexBasis, FlexLength);
    PRINT_PROP(flexGrow, float);
    PRINT_PROP(flexShrink, float);
    PRINT_PROP(width, FlexLength);
    PRINT_PROP(height, FlexLength);
    PRINT_PROP(minWidth, FlexLength);
    PRINT_PROP(minHeight, FlexLength);
    PRINT_PROP(maxWidth, FlexLength);
    PRINT_PROP(maxHeight, FlexLength);
    PRINT_PROP(marginTop, FlexLength);
    PRINT_PROP(marginLeft, FlexLength);
    PRINT_PROP(marginBottom, FlexLength);
    PRINT_PROP(marginRight, FlexLength);
//    PRINT_PROP(marginStart, FlexLength);
//    PRINT_PROP(marginEnd, FlexLength);
    PRINT_PROP(paddingTop, FlexLength);
    PRINT_PROP(paddingLeft, FlexLength);
    PRINT_PROP(paddingBottom, FlexLength);
    PRINT_PROP(paddingRight, FlexLength);
//    PRINT_PROP(paddingStart, FlexLength);
//    PRINT_PROP(paddingEnd, FlexLength);
    PRINT_PROP(spacing, FlexLength);
    PRINT_PROP(lineSpacing, FlexLength);
//    PRINT_PROP(borderWidth, FlexLength);
    
#undef PRINT_PROP
    
    return ret;
}

- (NSString *)recursiveDescription:(VZFlexNodeDescriptionOption)option {
    NSMutableString *ret = [[NSMutableString alloc] init];
    if (self.name.length > 0) {
        [ret appendFormat:@"%@(%@)", self.name, NSStringFromClass(self.class)];
    }
    else {
        [ret appendString:NSStringFromClass(self.class)];
    }
    
    [ret appendString:@" {\n"];
    [ret appendString:[self propertiesDescription:option]];
    
    if (!(option & VZFlexNodeDescriptionOptionHideResult)) {
        [ret appendString:@"  result = \n  {\n"];
        
        [ret appendFormat:@"    frame = %@\n", NSStringFromCGRect(self.resultFrame)];
        [ret appendFormat:@"    margin = %@\n", NSStringFromUIEdgeInsets(self.resultMargin)];
        
        [ret appendString:@"  }\n"];
    }
    
    if (!(option & VZFlexNodeDescriptionOptionHideChildren) && self.childNodes.count > 0) {
        [ret appendString:@"  children = \n  {\n"];
        
        for (VZFlexNode *child in self.childNodes) {
            NSString *childDescription = [child recursiveDescription:option];
            [childDescription enumerateLinesUsingBlock:^(NSString * _Nonnull line, BOOL * _Nonnull stop) {
                [ret appendFormat:@"    %@\n", line];
            }];
        }
        
        [ret appendString:@"  }\n"];
    }
    
    [ret appendString:@"}\n"];
    
    return ret;
}

- (NSString *)description {
//    return [self recursiveDescription:VZFlexNodeDescriptionOptionHideUnspecified | VZFlexNodeDescriptionOptionHideResult];
    return [self recursiveDescription:VZFlexNodeDescriptionOptionHideUnspecified];
}


@end
