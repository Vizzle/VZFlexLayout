//
//  VZFNodeListAdapter.m
//  VZFlexLayout
//
//  Created by moxin on 16/4/20.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFNodeListItemRecycler.h"
#import "VZFSizeRange.h"
#import "VZFNode.h"
#import "VZFNodeSubClass.h"
#import "VZFNodeProvider.h"
#import "VZFNodeLayoutManager.h"
#include <objc/runtime.h>
#import "VZFUtils.h"
#import "VZFMacros.h"
#import "VZFluxStore.h"
#import "VZFNodeInternal.h"
#import "VZFWeakObjectWrapper.h"


const void* g_recycleId = &g_recycleId;
const void* g_useVZAsyncDisplay = &g_useVZAsyncDisplay;
@implementation UIView(ListRecycleController)

- (void)setVz_recycler:(VZFNodeListItemRecycler *)vz_recycler{
    
    VZFWeakObjectWrapper* wrapper = [VZFWeakObjectWrapper new];
    wrapper.object = vz_recycler;
    objc_setAssociatedObject(self, &g_recycleId, wrapper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (VZFNodeListItemRecycler* )vz_recycler{
    
    VZFWeakObjectWrapper* wrapper = objc_getAssociatedObject(self, g_recycleId);
    return wrapper.object;
}

-(NSObject *)useVZAsyncDisplayFlag{
    return objc_getAssociatedObject(self, g_useVZAsyncDisplay);
}
- (void)setUseVZAsyncDisplayFlag:(NSObject *)flag{
    objc_setAssociatedObject(self, &g_useVZAsyncDisplay, flag, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end



struct VZItemRecyclerState{
    __strong id props;
    __strong id context;
    CGSize constrainedSize;
    NodeLayout layout;
};
@interface VZFNodeListItemRecycler()


@end

@implementation VZFNodeListItemRecycler{

    __weak UIView *_mountedView;
    NSSet *_mountedNodes;
    
    __weak Class<VZFNodeProvider> _nodeProvider;
    VZItemRecyclerState _state;

}


- (CGSize)layoutSize{

    return (CGSize){
        (_state.layout.size.width + _state.layout.margin.left + _state.layout.margin.right),
        (_state.layout.size.height + _state.layout.margin.top + _state.layout.margin.bottom)
    };
}


- (instancetype)initWithNodeProvider:(Class<VZFNodeProvider>)nodeProvider{
    
    self = [super init];
    if (self) {
    
        _nodeProvider = nodeProvider;
        _state        = {};
    }
    return self;

}


//moxin.xt@2016/09/26
//这里会有在异步线程释放的情况,析构顺序：
//node.unmount -> _state = nil -> node = nil;
- (void)dealloc{

    VZF_LOG_DEALLOC();
    
    if (_mountedNodes) {
     
        __block NSSet* copiedNodes = _mountedNodes;
        VZF_MainCall(^{
            
            for(VZFNode* node in copiedNodes){
                VZ::Mounting::reset(node.mountedView);
                [node unmount];
            }
        });
        _mountedNodes = nil;
    }

    if (_mountedView) {
        _mountedView.vz_recycler = nil;
    }

}

- (void)calculate:(id)item constrainedSize:(CGSize)constrainedSize context:(id<NSObject>)context{
    
    VZFNode* node = [_nodeProvider nodeForItem:item Store:_store Context:context];
    if (node) {
        const VZ::NodeLayout layout = [node computeLayoutThatFits:constrainedSize];
        
        //alloc stack object, will cause the old state object dealloc
        _state = {
            .props = item,
            .layout = layout,
            .constrainedSize = constrainedSize,
            .context = context
        };
            
    }
}

- (void)updateState{

    [self calculate:_state.props
    constrainedSize:_state.constrainedSize
            context:_state.context];
}

- (void)attachToView:(UIView *)view {
    [self attachToView:view asyncDisplay:NO];
}

//为了替换这个方法 单独抽离出来
-(BOOL)asyncDisplayLogic:(BOOL)asyncDisplay{
    return asyncDisplay;
}

- (void)attachToView:(UIView *)view asyncDisplay:(BOOL)asyncDisplay {
    
    VZFAssertMainThread();
    if(view.vz_recycler != self){
        
        [self detachFromView];
        [view.vz_recycler detachFromView];
        _mountedView = view;
        view.vz_recycler = self;
        
        //        NSLog(@"[%@]--->attach:<%ld,%p>",self.class,self.indexPath.row,view);
    }
    
    _mountedNodes = [layoutRootNodeInContainer(_state.layout, _mountedView, _mountedNodes, nil) copy];

}


- (void)detachFromView{
    
    VZFAssertMainThread();
    
    if (_mountedView) {
    
        unmountNodes(_mountedNodes);
        _mountedNodes = nil;
        _mountedView.vz_recycler = nil;
        _mountedView = nil;
    }
}


@end



