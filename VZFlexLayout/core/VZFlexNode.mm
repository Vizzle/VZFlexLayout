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
    if (FlexIsUndefined(value)) {
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
    if (length.type == FlexLengthTypeAuto) {
        return @"auto";
    }
    else if (length.type == FlexLengthTypeUndefined) {
        return @"undefined";
    }
    else if (length.type == FlexLengthTypeContent) {
        return @"content";
    }
    else {
        NSString *number = vz_floatToNSString(length.value);
        if (length.type == FlexLengthTypePercent) {
            number = [number stringByAppendingString:@"%"];
        }
        return number;
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
    CGSize size = node.measure ? node.measure(CGSizeMake(constrainedSize.width, constrainedSize.height)) : CGSizeZero;
    FlexSize ret = {};
    ret.width = size.width;
    ret.height = size.height;
    return ret;
}

float flexNodeBaseline(void* context, FlexSize constrainedSize) {
    VZFlexNode* node = (__bridge VZFlexNode*)context;
    return node.baseline ? node.baseline(CGSizeMake(constrainedSize.width, constrainedSize.height)) : 0;
}



////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - setters
- (void)setFixed:(BOOL)fixed {
    Flex_setFixed(_flex_node, fixed);
}

- (BOOL)fixed {
    return Flex_getFixed(_flex_node);
}

- (void)setWrap:(FlexWrapMode)wrap {
    Flex_setWrap(_flex_node, wrap);
}

- (FlexWrapMode)wrap {
    return Flex_getWrap(_flex_node);
}

- (void)setLines:(unsigned int)lines {
    Flex_setLines(_flex_node, lines);
}

- (unsigned int)lines {
    return Flex_getLines(_flex_node);
}

- (void)setItemsPerLine:(unsigned int)itemsPerLine {
    Flex_setItemsPerLine(_flex_node, itemsPerLine);
}

- (unsigned int)itemsPerLine {
    return Flex_getItemsPerLine(_flex_node);
}

- (void)setDirection:(FlexDirection)direction {
    Flex_setDirection(_flex_node, direction);
}

- (FlexDirection)direction {
    return Flex_getDirection(_flex_node);
}

- (void)setAlignItems:(FlexAlign)alignItems {
    Flex_setAlignItems(_flex_node, alignItems);
}

- (FlexAlign)alignItems {
    return Flex_getAlignItems(_flex_node);
}

- (void)setAlignSelf:(FlexAlign)alignSelf {
    Flex_setAlignSelf(_flex_node, alignSelf);
}

- (FlexAlign)alignSelf {
    return Flex_getAlignSelf(_flex_node);
}

- (void)setAlignContent:(FlexAlign)alignContent {
    Flex_setAlignContent(_flex_node, alignContent);
}

- (FlexAlign)alignContent {
    return Flex_getAlignContent(_flex_node);
}

- (void)setJustifyContent:(FlexAlign)justifyContent {
    Flex_setJustifyContent(_flex_node, justifyContent);
}

- (FlexAlign)justifyContent {
    return Flex_getJustifyContent(_flex_node);
}

- (void)setFlexBasis:(FlexLength)flexBasis {
    Flex_setFlexBasis_Length(_flex_node, flexBasis);
}

- (FlexLength)flexBasis {
    return Flex_getFlexBasis(_flex_node);
}

- (void)setFlexGrow:(CGFloat)flexGrow {
    Flex_setFlexGrow(_flex_node, flexGrow);
}

- (CGFloat)flexGrow {
    return Flex_getFlexGrow(_flex_node);
}

- (void)setFlexShrink:(CGFloat)flexShrink {
    Flex_setFlexShrink(_flex_node, flexShrink);
}

- (CGFloat)flexShrink {
    return Flex_getFlexShrink(_flex_node);
}

- (void)setSpacing:(FlexLength)spacing {
    Flex_setSpacing_Length(_flex_node, spacing);
}

- (FlexLength)spacing {
    return Flex_getSpacing(_flex_node);
}

- (void)setLineSpacing:(FlexLength)lineSpacing {
    Flex_setLineSpacing_Length(_flex_node, lineSpacing);
}

- (FlexLength)lineSpacing {
    return Flex_getLineSpacing(_flex_node);
}

- (void)setWidth:(FlexLength)width {
    Flex_setWidth_Length(_flex_node, width);
}

- (FlexLength)width {
    return Flex_getWidth(_flex_node);
}

- (void)setHeight:(FlexLength)height {
    Flex_setHeight_Length(_flex_node, height);
}

- (FlexLength)height {
    return Flex_getHeight(_flex_node);
}

- (void)setMinWidth:(FlexLength)minWidth {
    Flex_setMinWidth_Length(_flex_node, minWidth);
}

- (FlexLength)minWidth {
    return Flex_getMinWidth(_flex_node);
}

- (void)setMinHeight:(FlexLength)minHeight {
    Flex_setMinHeight_Length(_flex_node, minHeight);
}

- (FlexLength)minHeight {
    return Flex_getMinHeight(_flex_node);
}

- (void)setMaxWidth:(FlexLength)maxWidth {
    Flex_setMaxWidth_Length(_flex_node, maxWidth);
}

- (FlexLength)maxWidth {
    return Flex_getMaxWidth(_flex_node);
}

- (void)setMaxHeight:(FlexLength)maxHeight {
    Flex_setMaxHeight_Length(_flex_node, maxHeight);
}

- (FlexLength)maxHeight {
    return Flex_getMaxHeight(_flex_node);
}

- (void)setMarginTop:(FlexLength)marginTop {
    Flex_setMarginTop_Length(_flex_node, marginTop);
}

- (FlexLength)marginTop {
    return Flex_getMarginTop(_flex_node);
}

- (void)setMarginLeft:(FlexLength)marginLeft {
    Flex_setMarginLeft_Length(_flex_node, marginLeft);
}

- (FlexLength)marginLeft {
    return Flex_getMarginLeft(_flex_node);
}

- (void)setMarginBottom:(FlexLength)marginBottom {
    Flex_setMarginBottom_Length(_flex_node, marginBottom);
}

- (FlexLength)marginBottom {
    return Flex_getMarginBottom(_flex_node);
}

- (void)setMarginRight:(FlexLength)marginRight {
    Flex_setMarginRight_Length(_flex_node, marginRight);
}

- (FlexLength)marginRight {
    return Flex_getMarginRight(_flex_node);
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
    Flex_setPaddingTop_Length(_flex_node, paddingTop);
}

- (FlexLength)paddingTop {
    return Flex_getPaddingTop(_flex_node);
}

- (void)setPaddingLeft:(FlexLength)paddingLeft {
    Flex_setPaddingLeft_Length(_flex_node, paddingLeft);
}

- (FlexLength)paddingLeft {
    return Flex_getPaddingLeft(_flex_node);
}

- (void)setPaddingBottom:(FlexLength)paddingBottom {
    Flex_setPaddingBottom_Length(_flex_node, paddingBottom);
}

- (FlexLength)paddingBottom {
    return Flex_getPaddingBottom(_flex_node);
}

- (void)setPaddingRight:(FlexLength)paddingRight {
    Flex_setPaddingRight_Length(_flex_node, paddingRight);
}

- (FlexLength)paddingRight {
    return Flex_getPaddingRight(_flex_node);
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
    if (measure) {
        Flex_setMeasureFunc(_flex_node, flexNodeMeasure);
    }
}

- (void)setBaseline:(CGFloat (^)(CGSize))baseline {
    _baseline = baseline;
    if (baseline) {
        Flex_setBaselineFunc(_flex_node, flexNodeBaseline);
    }
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - life cycle


- (id)init
{
    self = [super init];
    if (self) {
        
        _flex_node = Flex_newNode();

        if (_flex_node != NULL) {
            Flex_setContext(_flex_node, (__bridge void* )self);
            _childNodes = [NSMutableArray new];
            
            //使用一个spinlock来保护 _childNodes的多线程读写情况
            _lock = OS_SPINLOCK_INIT;
        }

        
    }
    return self;
}

- (void)dealloc{
    
    Flex_freeNode(_flex_node);
    _flex_node = NULL;
}



- (CGRect)resultFrame
{
    return (CGRect) {
        
        .origin.x       = Flex_getResultLeft(_flex_node),
        .origin.y       = Flex_getResultTop(_flex_node),
        .size.width     = Flex_getResultWidth(_flex_node),
        .size.height    = Flex_getResultHeight(_flex_node)
    };
}

- (UIEdgeInsets)resultMargin{

    return (UIEdgeInsets){
    
        .top    = Flex_getResultMarginTop(_flex_node),
        .bottom = Flex_getResultMarginBottom(_flex_node),
        .left   = Flex_getResultMarginLeft(_flex_node),
        .right  = Flex_getResultMarginRight(_flex_node)

    };
}

- (UIEdgeInsets)resultPadding{
    
    return (UIEdgeInsets){

        .top    = Flex_getResultPaddingTop(_flex_node),
        .bottom = Flex_getResultPaddingBottom(_flex_node),
        .left   = Flex_getResultPaddingLeft(_flex_node),
        .right  = Flex_getResultPaddingRight(_flex_node)
        
    };
}

- (void)prepareLayout
{
    for(VZFlexNode* node in self.childNodes)
    {
        [node prepareLayout];
    }
    
}

- (void)layout:(CGSize)constrainedSize{
    
    //prepare layout递归
    [self prepareLayout];
    
    Flex_layout(_flex_node, constrainedSize.width, constrainedSize.height, [UIScreen mainScreen].scale);
    
}

- (void)addSubNode:(VZFlexNode* )node{
    
    OSSpinLockLock(&_lock);
    [_childNodes addObject:node];
    OSSpinLockUnlock(&_lock);

    Flex_insertChild(_flex_node, node->_flex_node, Flex_getChildrenCount(_flex_node));
}

- (void)removeSubNode:(VZFlexNode* )node{
    
    OSSpinLockLock(&_lock);
    [_childNodes removeObject:node];
    OSSpinLockUnlock(&_lock);
    
    Flex_removeChild(_flex_node, node->_flex_node);

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
        [ret appendFormat:@"    padding = %@\n", NSStringFromUIEdgeInsets(self.resultPadding)];
        
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
