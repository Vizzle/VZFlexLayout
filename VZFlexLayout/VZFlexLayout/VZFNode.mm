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


@interface VZFlexNode()

@property(nonatomic,strong)VZFlexNode* flexNode;

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
        _flexNode = [VZFlexNode new];
        
        VZ::FlexAttrs flexAttributes = (*specs.getSpecs().get()).flex;
        [self applyFlexAttributes:flexAttributes];
        
    }
    return self;
}

- (instancetype)init
{
    VZ_NOT_DESIGNATED_INITIALIZER();
}

- (void)updateState:(id (^)(id))updateBlock{


}

- (void)applyFlexAttributes:(const VZ::FlexAttrs &)flexAttributes{
    
    
    _flexNode.width  = flexAttributes.width;
    _flexNode.height = flexAttributes.height;
    _flexNode.maxWidth = flexAttributes.maxWidth;
    _flexNode.minWidth = flexAttributes.minWidth;
    _flexNode.maxHeight = flexAttributes.maxHeight;
    _flexNode.minWidth = flexAttributes.minWidth;
    _flexNode.marginTop = flexAttributes.marginTop;
    _flexNode.marginLeft = flexAttributes.marginLeft;
    _flexNode.marginRight = flexAttributes.marginRight;
    _flexNode.marginBottom = flexAttributes.marginBottom;
    _flexNode.paddingTop = flexAttributes.paddingTop;
    _flexNode.paddingLeft = flexAttributes.paddingLeft;
    _flexNode.paddingRight = flexAttributes.paddingRight;
    _flexNode.paddingBottom = flexAttributes.paddingBottom;
    _flexNode.flexGrow  = flexAttributes.flexGrow;
    _flexNode.flexShrink = flexAttributes.flexShrink;
    _flexNode.wrap = flexAttributes.wrap;
    _flexNode.fixed = flexAttributes.fixed;
}


- (VZFNodeLayout)computeLayoutThatFits:(CGSize)sz{
    
    [_flexNode layout:sz];
    VZFNodeLayout layout = { _flexNode.frame.size,_flexNode.frame.origin };
    return layout;
}



@end
