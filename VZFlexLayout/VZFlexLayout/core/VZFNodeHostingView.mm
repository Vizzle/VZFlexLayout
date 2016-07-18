//
//  VZFNodeHostingView.m
//  VZFlexLayout
//
//  Created by moxin on 16/1/28.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFNodeHostingView.h"
#import "VZFNodeViewManager.h"
#import "VZFMacros.h"
#import "VZFNode.h"
#import "VZFNodeInternal.h"
#import "VZFNodeLayout.h"
#import "VZFNodeLayoutManager.h"
#import "VZFUtils.h"
#import "VZFNodeSubClass.h"
#import "VZFluxStore.h"

using namespace VZ;

@interface VZFNodeHostingView()
{
    __weak id<VZFNodeProvider> _nodeProvider;
    
    VZFSizeRange _rangeType;
    NSSet<VZFNode* >* _mountedNodes;
    NodeLayout _mountedLayout;
    __strong id _model;
    __strong id _context;
    BOOL _isUpdating;

}

@end


@implementation VZFNodeHostingView{


}

- (id)initWithFrame:(CGRect)frame{
    VZ_NOT_DESIGNATED_INITIALIZER();
}


- (id)initWithNodeProvider:(id<VZFNodeProvider>)nodeProvider RangeType:(VZFSizeRange)rangeType{

    self = [super initWithFrame:CGRectZero];
    if(self){
        _rangeType = rangeType;
        _nodeProvider = nodeProvider;
        _shouldResize = YES;
    }
    return self;
}

- (void)dealloc{
    
    
    NSLog(@"[%@]-->dealloc",self.class);
    
    //主线程释放.
    [[VZFNodeLayoutManager sharedInstance] unmountNodes:_mountedNodes];
}





////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma public API

- (void)update:(id)model context:(id)context{
   
    _model = model;
    _context = context;
    
    [self _updateSynchronously];

}

- (void)updateState{
    [self update:_model context:_context];
}

- (void)reset{

    if (_mountedNodes) {
        
        for(VZFNode* node in _mountedNodes){
            NSLog(@"Reset <Node:%@, View:%@>",[node class],[node.mountedView class]);
            VZ::Mounting::reset(node.mountedView);
        }
        [[VZFNodeLayoutManager sharedInstance] unmountNodes:_mountedNodes];
    }
}



////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma private methods

//同步更新页面
- (void)_updateSynchronously{
    
    if (!_model) {
        return ;
    }

    if (_isUpdating) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self _updateSynchronously];
        });
    }
    
    _isUpdating = true;
    
    //1, reset state before remounting
//    [self reset];
    
    //2, create node
    VZFNode* node = [_nodeProvider nodeForItem:_model Store:_store Context:_context];
    
    if (node) {
                
        CGSize sz = VZ::containerSize(_rangeType, self.bounds.size);
        
        
        //3, calculate layout
        _mountedLayout = [node computeLayoutThatFits:sz];
        
        
        //4, mount
        _mountedNodes = [[VZFNodeLayoutManager sharedInstance] layoutRootNode:_mountedLayout
                                                                  InContainer:self
                                                            WithPreviousNodes:_mountedNodes
                                                                 AndSuperNode:nil];
        
        
        if (self.shouldResize) {
            self.frame = {self.frame.origin, [self newSize]};
        }
        if ([self.delegate respondsToSelector:@selector(hostingView:DidInvalidate:)]) {
            [self.delegate hostingView:self DidInvalidate:[self newSize]];
        }        
    }

       _isUpdating = false;

}

- (CGSize)newSize{
    
    CGSize oldSize = self.frame.size;
    
    switch (_rangeType) {
        case VZFlexibleSizeHeight:
            oldSize.height = [self containerSizeForHostingView:_mountedLayout].height;
            break;
        case VZFlexibleSizeWidth:
            oldSize.width = [self containerSizeForHostingView:_mountedLayout].width;
            break;
        case VZFlexibleSizeWidthAndHeight:
            oldSize = [self containerSizeForHostingView:_mountedLayout];
            break;
        case VZFlexibleSizeNone:
        default:
            break;
    }
    
    return oldSize;
    
}


- (CGSize)containerSizeForHostingView:(const NodeLayout& )layout
{
    CGFloat containerWidth  = layout.size.width + layout.margin.left + layout.margin.right;
    CGFloat containerHeight = layout.size.height + layout.margin.top + layout.margin.bottom;
    return {containerWidth,containerHeight};
}

- (id)targetForAction:(SEL)action withSender:(id)sender
{
    return [self respondsToSelector:action] ? self : [[self nextResponder] targetForAction:action withSender:sender];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma HostingView as backingview methods


- (void)born{

    NSLog(@"%s",__PRETTY_FUNCTION__);

}

- (void)dead{

    NSLog(@"%s",__PRETTY_FUNCTION__);
}

- (void)resetState{

    NSLog(@"%s",__PRETTY_FUNCTION__);
}


- (void)prepareForReuse{

    NSLog(@"%s",__PRETTY_FUNCTION__);
}


- (void)willEnterReusePool{

    NSLog(@"%s",__PRETTY_FUNCTION__);
}


- (void)didLeaveReusePool{

    NSLog(@"%s",__PRETTY_FUNCTION__);
}


@end
