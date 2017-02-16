//
//  VZFNode.m
//  VZFlexLayout
//
//  Created by moxin on 16/1/26.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFNode.h"
#import "VZFUtils.h"
#import "VZFMacros.h"
#import "VZFlexNode.h"
#import "VZFNodeLayout.h"
#import "VZFNodeInternal.h"
#import "VZFNodeLifeCycle.h"
#import "VZFlexNode+VZFNode.h"
#import "VZFNodeMountContext.h"
#import "VZFNodeViewManager.h"
#import "VZFNodeMountContext.h"
#import "VZFNodeSpecs.h"
#import "VZFNodeViewClass.h"
#import "UIView+VZAttributes.h"
#import "VZFNodeBackingViewInterface.h"
#import "VZFRenderer.h"
#import "VZFRasterizeNodeTool.h"
#import "VZFBackingViewProtocol.h"

struct VZFNodeMountedInfo{
  
    __weak VZFNode* parentNode;
    __weak UIView* mountedView;
    __weak VZFRenderer* mountedRenderer;
    
    struct {
        __weak UIView* v;
        __weak VZFRenderer* r;
        CGRect frame;
    } mountedContext;
};


using namespace VZ;
using namespace VZ::UIKit;

@implementation VZFNode
{
    
    VZFNodeLifeCycleState _lifeCycleState;
    std::unique_ptr<VZFNodeMountedInfo> _mountedInfo;
}


+ (instancetype)newWithView:(const ViewClass &)viewclass NodeSpecs:(const NodeSpecs &)specs{

    return [[self alloc] initWithView: viewclass Specs:specs];
}

+ (instancetype)new
{
    return [self newWithView:[UIView class] NodeSpecs:{}];
}

- (instancetype)initWithView:(const ViewClass& )viewclass Specs:(const NodeSpecs& )specs{
    self = [super init];
    if (self) {
        
        _specs          = specs;
        _viewClass      = viewclass;
        _flexNode       = [VZFlexNode flexNodeWithSpecs:specs];
        _flexNode.name  = [NSString stringWithUTF8String:specs.identifier.c_str()];
        _flexNode.fNode = self;

    }
    return self;
}

- (instancetype)init
{
    VZ_NOT_DESIGNATED_INITIALIZER();
}

- (void)dealloc{
    
//    VZF_LOG_DEALLOC();
    
    _flexNode.fNode = nil;
    _mountedInfo.reset();
    _mountedInfo = nullptr;
}

- (UIView* )mountedView{

    if (_mountedInfo) {
        return _mountedInfo -> mountedView;
    }
    else{
        return nil;
    }
}

- (NodeLayout)computeLayoutThatFits:(CGSize)sz{
    
    [_flexNode layout:sz];
    NodeLayout layout = { self,
                             _flexNode.resultFrame.size,
                             _flexNode.resultFrame.origin,
                             _flexNode.resultMargin};
    return [self nodeDidLayout];
}

- (BOOL)shouldMemoizeLayout{
    
    return NO;
}

- (NodeLayout)nodeDidLayout{
    NodeLayout layout{
        self,
        self.flexNode.resultFrame.size,
        self.flexNode.resultFrame.origin,
        self.flexNode.resultMargin,
        {}
    };
    
//    NSLog(@"[%@]-->nodeDidLayout:%@",self.class, NSStringFromCGSize(layout.size));
    return layout;
}


- (NSString *)description {
    
    NSString* className = NSStringFromClass([self class]);
    return [NSString stringWithFormat:@"%@",className];
//    return [[NSString alloc] initWithFormat:@"Class:{%@} \nLayout:{%@\n}",className,self.flexNode.description];
}

- (VZFNode* )superNode{
    return _mountedInfo -> parentNode;
}

- (VZFNode* )rootNode{
    
    VZFNode* rootNode = self;
    while (rootNode.superNode) {
        rootNode = rootNode.superNode;
    }
    return rootNode;
}

- (UIView* )rootView
{
    VZFNode* rootNode = [self rootNode];
    if (rootNode) {
        return rootNode -> _mountedInfo -> mountedView?:
        _mountedInfo->mountedContext.v;
    }
    else{
        return nil;
    }
}

-(VZ::UIKit::MountResult)mountInContext:(const VZ::UIKit::MountContext &)context Size:(CGSize) size ParentNode:(VZFNode* )parentNode
{
    
    //VZF_LOG_THREAD(@"mount");
    
    if (_mountedInfo == nullptr) {
        _mountedInfo.reset( new VZFNodeMountedInfo() );
    }
    
    _mountedInfo -> parentNode =  parentNode;
    

    
    //If renderer is nil, it means the node can't be rasterized
    //@discussion reuse?
    VZFRenderer *renderer = [VZFRasterizeNodeTool getRenderer4RasterizedNode:self size:size];
    
    
    if (renderer && context.viewManager.managedRenderer) {
        //当自己能被光栅化，且父节点也被光栅化的，renderer添加到父节点上
        
        //to rasterize
        //不是当前的backingview
        if (renderer != _mountedInfo -> mountedRenderer) {
            /* TODO
            //释放当前mountedView绑定的node
            [renderer.node unmount];
            renderer.node = self;
            _mountedInfo -> mountedRenderer = renderer;
            //[self didAquireBackingView];//TODO
             */
        }
        else{
            VZFAssert(renderer.node == self, @"");
        }
        
        //计算公式:
        //position.x = frame.origin.x + anchorPoint.x * bounds.size.width；
        //position.y = frame.origin.y + anchorPoint.y * bounds.size.height；
        /*       const CGPoint anchorPoint = view.layer.anchorPoint;
         view.center = context.position + CGPoint({anchorPoint.x * size.width, anchorPoint.y * size.height});
         view.bounds = {view.bounds.origin,size};
         */
        //apply frame
        renderer.frame  = {context.position, size};
        
        //apply attributes
        //@discussion 与上边的getRenderer4RasterizedNode重复了
        [renderer applyAttributes:self];
        
        [context.viewManager.managedRenderer addSubRenderer:renderer];
        
        //update mountedInfo
        _mountedInfo -> mountedContext = {nil,renderer,{context.position,size}};
        
        return {.hasChildren = YES, .childContext = context.childContextForSubRenderer(context.viewManager.managedView, renderer), .hasView = NO};

    } else {
        
        CGPoint origin = context.position;

        VZFRenderer *superRenderer = context.viewManager.managedRenderer;
        if (superRenderer) {
            while (superRenderer) {
                origin = {origin.x + superRenderer.frame.origin.x, origin.y + superRenderer.frame.origin.y};
                superRenderer = superRenderer.superRenderer;
            }
        }
        
        //获取一个reuse view
        UIView* view = [context.viewManager viewForNode:self];
        
        //说明reusepool中有view
        if (view) {
            //不是当前的backingview
            if (view != _mountedInfo -> mountedView) {
                
                //释放当前mountedView绑定的node
                [view.node unmount];
                view.node = self;
                _mountedInfo -> mountedView = view;
                [self didAquireBackingView];
            }
            else{
                VZFAssert(view.node == self, @"");
            }
            
            if ([view conformsToProtocol:@protocol(VZFBackingViewProtocol)]) {
                id<VZFBackingViewProtocol> backingView = (id<VZFBackingViewProtocol>)view;
                [backingView setRenderer:renderer];
                renderer = [backingView renderer];
            }
            
            //计算公式:
            //position.x = frame.origin.x + anchorPoint.x * bounds.size.width；
            //position.y = frame.origin.y + anchorPoint.y * bounds.size.height；
            /*       const CGPoint anchorPoint = view.layer.anchorPoint;
             view.center = context.position + CGPoint({anchorPoint.x * size.width, anchorPoint.y * size.height});
             view.bounds = {view.bounds.origin,size};
             */
            //apply frame
            view.frame  = {origin, size};
            
            //apply attributes
            [view applyAttributes];
            
            //update mountedInfo
            _mountedInfo -> mountedContext = {view,renderer,{context.position,size}};
            
            return {.hasChildren = YES, .childContext = context.childContextForSubview(view), .hasView = YES};
            
            
        }
        else{
            //这种情况对应于没有viewclass的node，例如compositeNode，他没有backingview，mount过程中使用的是view的是上一个view
            _mountedInfo -> mountedView = nil;
            _mountedInfo -> mountedContext = {context.viewManager.managedView,nil,{context.position,size}};
            
            return {.hasChildren = YES, .childContext = context, .hasView = NO};
            
        }

    }
    
    

}

-(void)unmount{
    
    VZF_LOG_THREAD(@"unmount");
    
    if (_mountedInfo != nullptr)
    {
        [self  willUnmount];
        
        [self _recycleMountedView];

        _mountedInfo.reset();
        
        [self didUnmount];
    }

}

- (void)_recycleMountedView{
    
    UIView* view = _mountedInfo -> mountedView;
    
    if (view) {
        
        [self willReleaseBackingView];
        
        view.node = nil;
        _mountedInfo -> mountedView = nil;

    }

}

////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - life cycle

-(void)willMount{

    VZF_LOG_THREAD(@"willMount");
    VZFAssertMainThread();
    
    switch (_state) {
        case VZFNodeStateUnmounted:
        {
            _state = VZFNodeStateMounting;
            break;
        }
        case VZFNodeStateMounted:
        {
            _state = VZFNodeStateRemounting;
            [self willRemount];
            break;
        }
        default:
        {
            VZFAssert(NO, @"State:[%@] Error: willmount -> '%@' ",[self class],VZFNodeStateName(_state));
            break;
        }
    }
}

- (void)willRemount{

    VZFAssertMainThread();
    VZF_LOG_THREAD(@"willRemount");

}

-(void)didMount{

    VZFAssertMainThread();
    VZF_LOG_THREAD(@"didMount");
    
    switch (_state) {
        case VZFNodeStateMounting:
        {
            _state = VZFNodeStateMounted;
            break;
        }
        case VZFNodeStateRemounting:{
            _state = VZFNodeStateMounted;
            [self didRemount];
            break;
        }
        default:
        {
            VZFAssert(NO, @"State:[%@] Error: didmount -> '%@' ",[self class],VZFNodeStateName(_state));
            break;
        }
    }
}

- (void)didRemount{

    VZFAssertMainThread();
    
    VZF_LOG_THREAD(@"didRemount");
}

- (void)willUnmount{

    VZFAssertMainThread();
    
    VZF_LOG_THREAD(@"willUnmount");
    
    switch (_state) {
        case VZFNodeStateMounted:
        {
            _state = VZFNodeStateUnmounting;
            break;
        }
        default:
        {
            VZFAssert(NO, @"State:[%@] Error: will unmount -> '%@' ",[self class],VZFNodeStateName(_state));
            break;
        }
    }

    
}

- (void)didUnmount{

    VZFAssertMainThread();
    
    VZF_LOG_THREAD(@"didUnmount");
    
    switch (_state) {
        case VZFNodeStateUnmounting:
            _state = VZFNodeStateUnmounted;
            break;
            
        default:{
            VZFAssert(NO, @"State:[%@] Error: did unmount -> '%@' ",[self class],VZFNodeStateName(_state));
            break;
        }
    }
}

- (void)willReleaseBackingView{

    VZFAssertMainThread();
    
}

- (void)didAquireBackingView{

    VZFAssertMainThread();
    
}


//////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - NSCopying
- (id)copyWithZone:(NSZone *)zone{
    //node is immutable object
    return self;
}


@end
