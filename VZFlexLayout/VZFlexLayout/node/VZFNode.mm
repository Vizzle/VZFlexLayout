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

@end

@implementation VZFNode
{
    
}

@synthesize flexNode = _flexNode;
@synthesize parentNode = _parentNode;


+ (id)initialState{
    return nil;
}

+ (instancetype)newWithView:(ViewClass &&)viewclass NodeSpecs:(const NodeSpecs &)specs{

    return [[self alloc] initWithView: std::move(viewclass) Specs:specs];
}



+ (instancetype)new
{
    return [self newWithView:[UIView class] NodeSpecs:{}];
}

- (instancetype)initWithView:(ViewClass&& )viewclass Specs:(const NodeSpecs& )specs{
    self = [super init];
    if (self) {
        
        _specs = specs;
        _viewClass = viewclass;
        _flexNode = [VZFNodeUISpecs flexNodeWithAttributes:_specs.flex];
        _flexNode.name = [NSString stringWithUTF8String:specs.name.c_str()];
    }
    return self;
}

- (instancetype)init
{
    VZ_NOT_DESIGNATED_INITIALIZER();
}

- (void)updateState:(id (^)(id))updateBlock{

    //noop
    [self.parentNode updateState:updateBlock];
}


- (VZFNodeLayout)computeLayoutThatFits:(CGSize)sz{
    
    [_flexNode layout:sz];
    VZFNodeLayout layout = { _flexNode.resultFrame.size,
                             _flexNode.resultFrame.origin,
                             _flexNode.resultMargin};
    return layout;
}

- (void)willBeAddedToParentNode:(VZFNode* )parentNode{
    _parentNode = parentNode;
}

- (NSString *)description {
    
    NSString* className = NSStringFromClass([self class]);
    return [[NSString alloc] initWithFormat:@"Class:{%@} \nLayout:{%@\n}",className,self.flexNode.description];
}

@end
