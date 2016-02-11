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
        
        _flexNode = [VZFlexNode new];
        
        std::shared_ptr<const VZUISpecs> specptr = specs.getSpecs();
        
        VZ::FlexAttrs flexAttributes = (*specptr.get()).flex;
        
//        _flexNode.width
//        _flexNode.size          = CGSizeMake(flexAttributes.width, flexAttributes.height);
//        _flexNode.margin        = UIEdgeInsetsMake(flexAttributes.marginTop, flexAttributes.marginLeft, flexAttributes.marginBottom, flexAttributes.marginRight);
//        _flexNode.flexGrow      = flexAttributes.flexGrow;
//        _flexNode.flexShrink    = flexAttributes.flexShrink;
        
    }
    return self;
}

- (instancetype)init
{
    VZ_NOT_DESIGNATED_INITIALIZER();
}

- (void)updateState:(id (^)(id))updateBlock{


}

- (void)applyFlexAttributes:(const VZ::FlexAttrs &)flex{

   // _flexNode.width = flex.size.width;
}

- (VZFNodeLayout)computeLayoutThatFits:(CGSize)sz{
    
    [_flexNode layout:sz];
    VZFNodeLayout layout = { _flexNode.frame.size,_flexNode.frame.origin };
    return layout;
}



@end
