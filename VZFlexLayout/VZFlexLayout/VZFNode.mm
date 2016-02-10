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

+(instancetype)nodeWithSpecs:(const VZ::UISpecs &)specs FlexAttributes:(const VZ::FlexAttribute &)attr{
    
    return  [[self alloc] initWithSpecs:specs FlexAttributes:attr];
}


+ (instancetype)new
{
    return [self nodeWithSpecs:{} FlexAttributes:{}];
}

- (instancetype)initWithSpecs:(const VZ::UISpecs& )specs FlexAttributes:(const VZ::FlexAttribute &)attr
{
    self = [super init];
    if (self) {
        
        _flexNode = [VZFlexNode new];
        _flexNode.size          = CGSizeMake(attr.width, attr.height);
        _flexNode.margin        = UIEdgeInsetsMake(attr.marginTop, attr.marginLeft, attr.marginBottom, attr.marginRight);
        _flexNode.flexGrow      = attr.flexGrow;
        _flexNode.flexShrink    = attr.flexShrink;
        
    }
    return self;
}

- (instancetype)init
{
    VZ_NOT_DESIGNATED_INITIALIZER();
}

- (void)updateState:(id (^)(id))updateBlock{


}

- (VZFNodeLayout)computeLayoutThatFits:(CGSize)sz{
    
    [_flexNode layout:sz];
    VZFNodeLayout layout = { _flexNode.frame.size,_flexNode.frame.origin };
    return layout;
}



@end
