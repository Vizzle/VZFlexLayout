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
#import "VZFScopeHandler.h"
#import "VZFScopeManager.h"
#import "VZFNodeController.h"
#import "VZFNodeHostingView.h"


@interface VZFlexNode()

@end

@implementation VZFNode
{
    VZFScopeHandler* _scopeHander;
//    int32_t _scopeId;
}

//@synthesize flexNode = _flexNode;
//@synthesize parentNode = _parentNode;


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
        _scopeHander = [VZFScopeHandler scopeHandlerForNode:self];

    }
    return self;
}

- (instancetype)init
{
    VZ_NOT_DESIGNATED_INITIALIZER();
}


- (void)updateState:(id (^)(id))updateBlock{

    [_scopeHander updateState:updateBlock];
    
}


- (VZFNodeLayout)computeLayoutThatFits:(CGSize)sz{
    
    [_flexNode layout:sz];
    VZFNodeLayout layout = { _flexNode.resultFrame.size,
                             _flexNode.resultFrame.origin,
                             _flexNode.resultMargin};
    return layout;
}


- (NSString *)description {
    
    NSString* className = NSStringFromClass([self class]);
    return [[NSString alloc] initWithFormat:@"Class:{%@} \nLayout:{%@\n}",className,self.flexNode.description];
}

- (void)addToParentNode:(VZFNode* )parentNode{
    _parentNode = parentNode;
}

- (id)nextResponder {
    return _scopeHander.controller ?: self.parentNode ?: self.hostingView;
}

- (id)responderForSelector:(SEL)selector {
    return [self respondsToSelector:selector] ? self : [self.nextResponder responderForSelector:selector];
}

- (VZFNodeController* )controller {
    return _scopeHander.controller;
}

@end
