//
//  VZFNode.m
//  VZFlexLayout
//
//  Created by moxin on 16/1/26.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFNode.h"
#import "VZFMacros.h"
#import "VZFNodeLayout.h"
#import "VZFlexNode.h"
#import "VZFNodeInternal.h"


NSString *boolToNSString(BOOL value) {
    return value ? @"true" : @"false";
}

NSString *directionToNSString(FlexDirection value) {
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

NSString *floatToNSString(CGFloat value) {
    if (value == FlexAuto) {
        return @"auto";
    }
    else if (value == FlexContent) {
        return @"content";
    }
    else if (value == FlexUndefined) {
        return @"undefined";
    }
    else if (value == FlexInfinite) {
        return @"infinite";
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

NSString *alignToNSString(FlexAlign align) {
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
    }
}

VZFlexNode *defaultVZFlexNode() {
    static VZFlexNode* node;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        node = [[VZFlexNode alloc] init];
    });
    return node;
}

@interface VZFlexNode()

@end

@implementation VZFNode
{
    
}

@synthesize flexNode = _flexNode;

+ (id)initialState{
    return nil;
}

+(instancetype)nodeWithUISpecs:(const VZ::UISpecs &)specs{
    
    return [[self alloc] initWithUISpecs:specs];
}



+ (instancetype)new
{
    return [self nodeWithUISpecs:{}];
}

- (instancetype)initWithUISpecs:(const VZ::UISpecs& )specs{
    self = [super init];
    if (self) {
        
        _specs = specs;
        _flexNode = [VZFNodeUISpecs flexNodeWithAttributes:_specs.flex];
        _flexNode.name = [NSString stringWithUTF8String:specs.name.c_str()];
    }
    return self;
}

- (instancetype)init
{
    VZ_NOT_DESIGNATED_INITIALIZER();
}


- (VZFNodeLayout)computeLayoutThatFits:(CGSize)sz{
    
    [_flexNode layout:sz];
    VZFNodeLayout layout = { _flexNode.frame.size,_flexNode.frame.origin };
    return layout;
}


- (NSString *)propertiesDescription:(NodeDescriptionOption)option {
    NSMutableString *ret = [[NSMutableString alloc] init];
    
#define PRINT_PROP(PROP, TYPE) if (!(option & NodeDescriptionOptionHideUnspecified) || self.flexNode.PROP != defaultVZFlexNode().PROP) \
[ret appendFormat:@"  " #PROP " = %@\n", TYPE##ToNSString(self.flexNode.PROP)];
    
    PRINT_PROP(fixed, bool);
    PRINT_PROP(wrap, bool);
    PRINT_PROP(direction, direction);
    PRINT_PROP(alignItems, align);
    PRINT_PROP(alignSelf, align);
    PRINT_PROP(alignContent, align);
    PRINT_PROP(justifyContent, align);
    PRINT_PROP(flexBasis, float);
    PRINT_PROP(flexGrow, float);
    PRINT_PROP(flexShrink, float);
    PRINT_PROP(width, float);
    PRINT_PROP(height, float);
    PRINT_PROP(minWidth, float);
    PRINT_PROP(minHeight, float);
    PRINT_PROP(maxWidth, float);
    PRINT_PROP(maxHeight, float);
    PRINT_PROP(marginTop, float);
    PRINT_PROP(marginLeft, float);
    PRINT_PROP(marginBottom, float);
    PRINT_PROP(marginRight, float);
//    PRINT_PROP(marginStart, float);
//    PRINT_PROP(marginEnd, float);
    PRINT_PROP(paddingTop, float);
    PRINT_PROP(paddingLeft, float);
    PRINT_PROP(paddingBottom, float);
    PRINT_PROP(paddingRight, float);
//    PRINT_PROP(paddingStart, float);
//    PRINT_PROP(paddingEnd, float);
//    PRINT_PROP(spacing, float);
//    PRINT_PROP(lineSpacing, float);
//    PRINT_PROP(borderWidth, float);
    
#undef PRINT_PROP
    
    return ret;
}

- (NSString *)recursiveDescription:(NodeDescriptionOption)option {
    NSMutableString *ret = [[NSMutableString alloc] init];
    if (self.flexNode.name.length > 0) {
        [ret appendFormat:@"%@(%@)", self.flexNode.name, NSStringFromClass(self.class)];
    }
    else {
        [ret appendString:NSStringFromClass(self.class)];
    }
    
    [ret appendString:@" {\n"];
    [ret appendString:[self propertiesDescription:option]];
    
    if (!(option & NodeDescriptionOptionHideResult)) {
        [ret appendString:@"  result = \n  {\n"];
        
        [ret appendFormat:@"    frame = %@\n", NSStringFromCGRect(self.flexNode.frame)];
//        [ret appendFormat:@"    margin = %@\n", NSStringFromUIEdgeInsets(self.resultMargin)];
        
        [ret appendString:@"  }\n"];
    }
    
    [ret appendString:@"}\n"];
    
    return ret;
}

- (NSString *)description {
    return [self recursiveDescription:NodeDescriptionOptionHideUnspecified | NodeDescriptionOptionHideResult];
}


@end
