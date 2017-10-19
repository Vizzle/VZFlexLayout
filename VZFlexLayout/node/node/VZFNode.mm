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
#import "VZFBlankNodeBackingView.h"
#import "VZFViewReusePool.h"

struct VZFNodeMountedInfo{
  
    __weak VZFNode* parentNode;
    __weak UIView* mountedView;
    __weak VZFRenderer* mountedRenderer;
    __weak VZFNode* rasterizeRootNode; //光栅化根节点node

    BOOL hadSubView;
    
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
    __weak UIImage *_cachedContents;
    NodeSpecs _specs;
}


+ (instancetype)newWithView:(const ViewClass &)viewclass NodeSpecs:(const NodeSpecs &)specs{

    return [[self alloc] initWithView: viewclass Specs:specs];
}

+(Class)defaultClass{
    return [VZFBlankNodeBackingView class];
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

- (VZ::NodeSpecs&)specs {
    return _specs;
}

- (void)setSpecs:(const VZ::NodeSpecs&)specs {
    _specs = specs;
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

- (UIImage *)cachedContents {
    return _cachedContents;
}

- (void)setCachedContents:(UIImage *)cachedContents {
    _cachedContents = cachedContents;
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
    
//    VZFNSLog(@"[%@]-->nodeDidLayout:%@",self.class, NSStringFromCGSize(layout.size));
    return layout;
}


- (NSString *)description {
    
    NSString* className = NSStringFromClass([self class]);
    return [[NSString alloc] initWithFormat:@"Class:{%@} \nLayout:{%@\n}",className,self.flexNode.description];
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
//-(void)resetParentNode:(VZFNode* )parentNode{
//    //VZF_LOG_THREAD(@"mount");
//    
//    if (_mountedInfo == nullptr) {
//        _mountedInfo.reset( new VZFNodeMountedInfo() );
//    }
//    
//    _mountedInfo -> parentNode =  parentNode;
//    _mountedInfo -> hadSubView = NO;
//}
//-(VZFRenderer *)getParentRendererParentNode:(VZFNode* )parentNode{
//    if (parentNode != nil && parentNode -> _mountedInfo != nullptr) {
//        return parentNode -> _mountedInfo -> mountedContext.r;
//    }
//    return nil;
//}
//-(BOOL)canAddToSuperRenderer:(VZFRenderer *)parentRenderer ParentNode:(VZFNode* )parentNode frame:(CGRect)frame{
//    BOOL canAddToSuperRenderer = NO;
//    //当前结点能光栅化，并且parentRenderer存在是先决条件
//    if (parentRenderer  && !parentNode-> _mountedInfo->hadSubView ) {
//        /*
//         *判断当前的结点的有效显示区域是否超过了光栅化根结点的frame。如果超过了，并且根结点的clip为NO，那么这个结点不能被加入到这个光栅化树
//         *【分析】
//         *由于我们是层层构建renderer树，那么，既然当前结点的父node及其直系祖先结点已经被加入到光栅化树中，那么意味着
//         *1.这些祖先结点的有效的显示区域一定没有超过根节点的frame，
//         *2.祖先结点的clip可能为YES，也可能为NO，如果某一个祖先结点clip为YES，那么意味着他的所有子孙有效的显示区域一定不会超出根节点的范围
//         *【推演结论】
//         *所以，只有【所有祖先结点的clip为NO】，并且【当前结点超过了所有祖先结点的frame】时，当前结点的有效显示区域才会超出根节点范围
//         */
//        //如果当前renderer超过了跟renderer的范围，并且根renderer没有clip，这时候当前节点不能被光栅化
//        
//        VZFRenderer *pRenderer = parentRenderer; //遍历直系祖先结点，包括了根节点
//        CGRect curFrame = frame; //相对当前遍历祖先结点的frame
//        while (pRenderer) {
//            if (pRenderer.clip || CGRectContainsRect({{0,0},pRenderer.frame.size}, curFrame)) {
//                canAddToSuperRenderer = YES;
//                break;
//            }
//            
//            curFrame.origin.x += pRenderer.frame.origin.x;
//            curFrame.origin.y += pRenderer.frame.origin.y;
//            
//            pRenderer = pRenderer.superRenderer;
//        }
//    }
//    return canAddToSuperRenderer;
//}
//-(VZ::UIKit::MountResult)getRasterizedResult:(BOOL)canAddToSuperRenderer size:(CGSize)size frame:(CGRect)frame parentRenderer:(VZFRenderer *)parentRenderer context:(const VZ::UIKit::MountContext &)context{
//    if (canAddToSuperRenderer) {
//        //当自己能被光栅化，且父节点也被光栅化的，renderer添加到父节点上
//        VZFRenderer *renderer = [VZFRasterizeNodeTool getRenderer4RasterizedNode:self size:size];
//        if (renderer) {
//            [renderer removeAllSubRenderers];//复用，删除子renderers
//            
//            //to rasterize
//            //不是当前的backingview
//            if (renderer != _mountedInfo -> mountedRenderer) {
//                //释放当前mountedView绑定的node
//                [renderer.node unmount];
//                renderer.node = self;
//                _mountedInfo -> mountedRenderer = renderer;
//                //[self didAquireBackingView];
//            }
//            else{
//                VZFAssert(renderer.node == self, @"");
//            }
//            
//            _mountedInfo -> mountedView = nil;
//            //计算公式:
//            //position.x = frame.origin.x + anchorPoint.x * bounds.size.width；
//            //position.y = frame.origin.y + anchorPoint.y * bounds.size.height；
//            /*       const CGPoint anchorPoint = view.layer.anchorPoint;
//             view.center = context.position + CGPoint({anchorPoint.x * size.width, anchorPoint.y * size.height});
//             view.bounds = {view.bounds.origin,size};
//             */
//            //apply frame
//            renderer.frame  = frame;
//            
//            [parentRenderer addSubRenderer:renderer];
//            
//            //update mountedInfo
//            _mountedInfo -> mountedContext = {nil,renderer,frame};
//            
//            return {.hasChildren = YES, .childContext = context.childContextForSubview(context.viewManager.managedView, NO)};
//        }
//    }
//    
//    return {.hasChildren = NO,.childContext = context};
//}
//
//-(VZ::UIKit::MountResult)getViewResult:(VZFNode *)parentNode context:(const VZ::UIKit::MountContext &)context parentRenderer:(VZFRenderer *)parentRenderer size:(CGSize)size{
//    
//    //走到这个分支，意味着，当前节点或者作为光栅化的根节点，或者是一个普通的view
//    if (parentNode) {
//        parentNode -> _mountedInfo->hadSubView = YES;
//    }
//    
//    CGPoint origin = context.position;
//    
//    //如果super node被光栅化了，那么当前node对应的view在添加到上级view的时候，origin需要进行转换
//    VZFRenderer *superRenderer = parentRenderer;
//    while (superRenderer) {
//        origin.x += superRenderer.frame.origin.x;
//        origin.y += superRenderer.frame.origin.y;
//        superRenderer = superRenderer.superRenderer;
//    }
//    
//    //获取一个reuse view
//    UIView* view = [context.viewManager viewForNode:self];
//    
//    //说明reusepool中有view
//    if (view) {
//        //不是当前的backingview
//        if (view != _mountedInfo -> mountedView) {
//            
//            //释放当前mountedView绑定的node
//            if (view.node!=self) {
//                [view.node unmount];
//                view.node = self;
//            }
//            _mountedInfo -> mountedView = view;
//            [self didAquireBackingView:view];
//        }
//        else{
//            VZFAssert(view.node == self, @"");
//        }
//        
//        
//        //计算公式:
//        //position.x = frame.origin.x + anchorPoint.x * bounds.size.width；
//        //position.y = frame.origin.y + anchorPoint.y * bounds.size.height；
//        /*       const CGPoint anchorPoint = view.layer.anchorPoint;
//         view.center = context.position + CGPoint({anchorPoint.x * size.width, anchorPoint.y * size.height});
//         view.bounds = {view.bounds.origin,size};
//         */
//        //apply frame
//        view.frame  = {origin, size};
//        
//        
//        //apply attributes
//        [view applyAttributes];
//        
//        VZFRenderer *renderer = nil;
//        if ([view conformsToProtocol:@protocol(VZFBackingViewProtocol)]) {
//            renderer = [(id<VZFBackingViewProtocol>)view renderer];;
//            renderer.frame = {CGPointMake(0, 0), size};
//            renderer.node = self;
//            [renderer removeAllSubRenderers];//复用，删除子renderers
//        }
//        
//        _mountedInfo-> mountedRenderer = renderer;
//        //update mountedInfo
//        _mountedInfo -> mountedContext = {view,renderer,{context.position,size}};
//        
//        return {.hasChildren = YES, .childContext = context.childContextForSubview(view, YES)};
//    }
//    else{
//        //这种情况对应于没有viewclass的node，例如compositeNode，他没有backingview，mount过程中使用的是view的是上一个view
//        _mountedInfo -> mountedView = nil;
//        _mountedInfo -> mountedRenderer = nil;
//        _mountedInfo -> mountedContext = {context.viewManager.managedView, parentRenderer, {context.position,size}};
//        
//        return {.hasChildren = YES, .childContext = context};
//    }
//}
//-(VZ::UIKit::MountResult)renderInContext:(const VZ::UIKit::MountContext &)context Size:(CGSize) size ParentNode:(VZFNode* )parentNode
//{
//    [self resetParentNode:parentNode];
//    
//    VZFRenderer *parentRenderer = [self getParentRendererParentNode:parentNode];
//
//    CGRect frame = {context.position, size}; //相对父结点的frame
//    
//    BOOL canAddToSuperRenderer = [self canAddToSuperRenderer:parentRenderer ParentNode:parentNode frame:frame];
//    
//    VZ::UIKit::MountResult r = [self getRasterizedResult:canAddToSuperRenderer size:size frame:frame parentRenderer:parentRenderer context:context];
//    
//    if (r.hasChildren) {
//        return r;
//    }
//    
//    return [self getViewResult:parentNode context:context parentRenderer:parentRenderer size:size];
//}

-(VZ::UIKit::MountResult)renderInContext:(const VZ::UIKit::MountContext &)context Size:(CGSize) size ParentNode:(VZFNode* )parentNode cannotBeRasterized:(BOOL)cannotBeRasterized rasterizeCachePolicy:(VZFRasterizeCachePolicy)rasterizeCachePolicy
{
    
    //VZF_LOG_THREAD(@"mount");
    
    if (_mountedInfo == nullptr) {
        _mountedInfo.reset( new VZFNodeMountedInfo() );
    }
    
    _mountedInfo -> parentNode =  parentNode;
    _mountedInfo -> hadSubView = NO;
    
    VZFRenderer *parentRenderer = nil;
    VZFNode *rasterizeRootNode = nil;

    if (parentNode != nil && parentNode -> _mountedInfo != nullptr) {
        parentRenderer = parentNode -> _mountedInfo -> mountedContext.r;
        rasterizeRootNode = parentNode -> _mountedInfo -> rasterizeRootNode;
    }
    
    //If renderer is nil, it means the node can't be rasterized
    //@discussion reuse?
    
    CGRect frame = {context.position, size}; //相对父结点的frame
    
    
    BOOL canAddToSuperRenderer = NO;
    //当前结点能光栅化，并且parentRenderer存在是先决条件
    if (parentRenderer
        && (rasterizeRootNode && rasterizeRootNode -> _mountedInfo && !rasterizeRootNode -> _mountedInfo -> hadSubView)
        && !cannotBeRasterized) {
        /*
         *判断当前的结点的有效显示区域是否超过了光栅化根结点的frame。如果超过了，并且根结点的clip为NO，那么这个结点不能被加入到这个光栅化树
         *【分析】
         *由于我们是层层构建renderer树，那么，既然当前结点的父node及其直系祖先结点已经被加入到光栅化树中，那么意味着
         *1.这些祖先结点的有效的显示区域一定没有超过根节点的frame，
         *2.祖先结点的clip可能为YES，也可能为NO，如果某一个祖先结点clip为YES，那么意味着他的所有子孙有效的显示区域一定不会超出根节点的范围
         *【推演结论】
         *所以，只有【所有祖先结点的clip为NO】，并且【当前结点超过了所有祖先结点的frame】时，当前结点的有效显示区域才会超出根节点范围
         */
        //如果当前renderer超过了跟renderer的范围，并且根renderer没有clip，这时候当前节点不能被光栅化
        
        VZFRenderer *pRenderer = parentRenderer; //遍历直系祖先结点，包括了根节点
        CGRect curFrame = frame; //相对当前遍历祖先结点的frame
        while (pRenderer) {
            if (pRenderer.clip || CGRectContainsRect({{0,0},pRenderer.frame.size}, curFrame)) {
                canAddToSuperRenderer = YES;
                break;
            }
            
            curFrame.origin.x += pRenderer.frame.origin.x;
            curFrame.origin.y += pRenderer.frame.origin.y;
            
            pRenderer = pRenderer.superRenderer;
        }
    }
    
    
    if (canAddToSuperRenderer) {
        //当自己能被光栅化，且父节点也被光栅化的，renderer添加到父节点上
        VZFRenderer *renderer = [VZFRasterizeNodeTool getRenderer4RasterizedNode:self size:size];
        if (renderer) {
            [renderer removeAllSubRenderers];//复用，删除子renderers
            
            //to rasterize
            //不是当前的backingview
            if (renderer != _mountedInfo -> mountedRenderer) {
                //释放当前mountedView绑定的node
                [renderer.node unmount];
                renderer.node = self;
                _mountedInfo -> mountedRenderer = renderer;
                //[self didAquireBackingView];
            }
            else{
                VZFAssert(renderer.node == self, @"");
            }
            
            _mountedInfo -> mountedView = nil;
            _mountedInfo -> rasterizeRootNode = parentNode -> _mountedInfo -> rasterizeRootNode;
            //计算公式:
            //position.x = frame.origin.x + anchorPoint.x * bounds.size.width；
            //position.y = frame.origin.y + anchorPoint.y * bounds.size.height；
            /*       const CGPoint anchorPoint = view.layer.anchorPoint;
             view.center = context.position + CGPoint({anchorPoint.x * size.width, anchorPoint.y * size.height});
             view.bounds = {view.bounds.origin,size};
             */
            //apply frame
            renderer.frame  = frame;
            
            [parentRenderer addSubRenderer:renderer];
            
            //update mountedInfo
            _mountedInfo -> mountedContext = {nil,renderer,frame};
            
            return {.hasChildren = YES, .childContext = context.childContextForSubview(context.viewManager.managedView, NO)};
        }
        
    }
    
    
    
    //走到这个分支，意味着，当前节点或者作为光栅化的根节点，或者是一个普通的view
    if (rasterizeRootNode && rasterizeRootNode -> _mountedInfo) {
        rasterizeRootNode -> _mountedInfo -> hadSubView = YES;
    }
    
    CGPoint origin = context.position;
    
    //如果super node被光栅化了，那么当前node对应的view在添加到上级view的时候，origin需要进行转换
    VZFRenderer *superRenderer = parentRenderer;
    while (superRenderer) {
        origin.x += superRenderer.frame.origin.x;
        origin.y += superRenderer.frame.origin.y;
        superRenderer = superRenderer.superRenderer;
    }
    
    frame.origin = origin;
    
    //获取一个reuse view
    UIView* view = [context.viewManager viewForNode:self frame:frame];
    
    
    //说明reusepool中有view
    if (view) {
        //不是当前的backingview
        if (view != _mountedInfo -> mountedView) {
            
            //释放当前mountedView绑定的node
            if (view.node!=self) {
                [view.node unmount];
                view.node = self;
            }
            _mountedInfo -> mountedView = view;
            [self didAquireBackingView:view];
        }
        else{
            VZFAssert(view.node == self, @"");
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
        [self applyAttributes];
        
        // applicator & unapplicator
        view.unapplicator = _specs.unapplicator;
        if (_specs.applicator) {
            _specs.applicator(view);
        }
        
        VZFRenderer *renderer = nil;
        if ([view conformsToProtocol:@protocol(VZFBackingViewProtocol)]) {
            
            [(id<VZFBackingViewProtocol>)view setCachePolicy:rasterizeCachePolicy];
            
            renderer = [(id<VZFBackingViewProtocol>)view renderer];;
            renderer.frame = {CGPointMake(0, 0), size};
            renderer.node = self;
            [renderer removeAllSubRenderers];//复用，删除子renderers
            _mountedInfo -> rasterizeRootNode = self;

        }
        
        _mountedInfo-> mountedRenderer = renderer;
        //update mountedInfo
        _mountedInfo -> mountedContext = {view,renderer,{context.position,size}};
        
        return {.hasChildren = YES, .childContext = context.childContextForSubview(view, YES)};
    }
    else{
        //这种情况对应于没有viewclass的node，例如compositeNode，他没有backingview，mount过程中使用的是view的是上一个view
        _mountedInfo -> mountedView = nil;
        _mountedInfo -> mountedRenderer = nil;
        _mountedInfo -> mountedContext = {context.viewManager.managedView, parentRenderer, {context.position,size}};
        
        return {.hasChildren = YES, .childContext = context};
    }
}



-(VZ::UIKit::MountResult)mountInContext:(const VZ::UIKit::MountContext &)context Size:(CGSize) size ParentNode:(VZFNode* )parentNode isUpdating:(BOOL)isUpdating
{
    
    //VZF_LOG_THREAD(@"mount");
    
    if (_mountedInfo == nullptr) {
        _mountedInfo.reset( new VZFNodeMountedInfo() );
    }
    
    _mountedInfo -> parentNode =  parentNode;
    
    CGRect frame = {context.position, size}; //相对父结点的frame
    //获取一个reuse view
    UIView* view = [context.viewManager viewForNode:self frame:frame];
    
    //说明reusepool中有view
    if (view) {
        //不是当前的backingview
        if (view != _mountedInfo -> mountedView) {
            VZFAssert(view.node != self, @"");
            
            //释放当前mountedView绑定的node
            [view.node unmount];
            view.node = self;
            _mountedInfo -> mountedView = view;
            [self didAquireBackingView:view];
        }
        else{
            VZFAssert(view.node == self, @"");
        }
        
        
        
        //计算公式:
        //position.x = frame.origin.x + anchorPoint.x * bounds.size.width；
        //position.y = frame.origin.y + anchorPoint.y * bounds.size.height；
        /*       const CGPoint anchorPoint = view.layer.anchorPoint;
         view.center = context.position + CGPoint({anchorPoint.x * size.width, anchorPoint.y * size.height});
         view.bounds = {view.bounds.origin,size};
         */

        view.layer.anchorPoint = CGPointMake(_specs.anchorX, _specs.anchorY);
        
        BOOL needsAnimation = isUpdating && [_specs.autoAnimationAttributes[VZFAutoAnimationEnabled] boolValue] && view.reuseResult == VZFViewReuseReusltReuse;

        if (needsAnimation) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:[_specs.autoAnimationAttributes[VZFAutoAnimationDuration] doubleValue]];
            [UIView setAnimationDelay:[_specs.autoAnimationAttributes[VZFAutoAnimationDelay] doubleValue]];

            static NSDictionary *animationCurveDict = @{
              @"easeIn": @(UIViewAnimationCurveEaseIn),
              @"easeOut": @(UIViewAnimationCurveEaseOut),
              @"easeInEaseOut": @(UIViewAnimationCurveEaseInOut),
              @"linear": @(UIViewAnimationCurveLinear),
              };
            UIViewAnimationCurve curve = (UIViewAnimationCurve)[animationCurveDict[_specs.autoAnimationAttributes[VZFAutoAnimationTimingFunction]] intValue];
            [UIView setAnimationCurve:curve];
        }

        //apply frame
        view.frame = {context.position, size};
        
        //apply attributes
        [self applyAttributes];
        
        // applicator & unapplicator
        view.unapplicator = _specs.unapplicator;
        if (_specs.applicator) {
            _specs.applicator(view);
        }

        if (needsAnimation) {
            [UIView commitAnimations];
        }

        if (isUpdating) {
            switch (view.reuseResult) {
                case VZFViewReuseReusltReuse:
                    [_specs.updateReuse invoke:view withCustomParam:view];
                    break;
                case VZFViewReuseReusltShow:
                case VZFViewReuseReusltCreate:
                    [_specs.updateAppear invoke:view withCustomParam:view];
                    break;
                default:
                    break;
            }
        }

        //update mountedInfo
        _mountedInfo -> mountedContext = {view,nil,{context.position,size}};
        
        return {.hasChildren = YES, .childContext = context.childContextForSubview(view, YES)};
        
        
    }
    else{
        //这种情况对应于没有viewclass的node，例如compositeNode，他没有backingview，mount过程中使用的是view的是上一个view
        _mountedInfo -> mountedView = nil;
        _mountedInfo -> mountedContext = {context.viewManager.managedView,nil,{context.position,size}};
        
        return {.hasChildren = YES, .childContext = context};
        
    }
}

-(void)applyAttributes{
    UIView *view = [self mountedView];
    [view applyAttributes];
}

-(void)unmount{
    
    //VZF_LOG_THREAD(@"unmount");
    
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
        
        [self willReleaseBackingView:view];
        VZFAssert(view.node == self, @"");
        view.node = nil;
        _mountedInfo -> mountedView = nil;

    }
    
    VZFRenderer* renderer = _mountedInfo -> mountedRenderer;
    
    if (renderer) {
        renderer.node = nil;
        _mountedInfo -> mountedRenderer = nil;
        
    }

}

////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - life cycle

-(void)willMount{

    VZFAssertMainThread();
    [self.mountedView.layer removeAllAnimations];
    
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

}

-(void)didMount{

    VZFAssertMainThread();
    
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
    
    if (_specs.display) {
        [_specs.display invoke:self withCustomParam:_mountedInfo->mountedView];
    }
}

- (void)didRemount{

    VZFAssertMainThread();
}

- (void)willUnmount{

    VZFAssertMainThread();
    
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

- (void)willReleaseBackingView:(UIView *)view {

    VZFAssertMainThread();

}

- (void)didAquireBackingView:(UIView *)view {

    VZFAssertMainThread();
    
}


//////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - NSCopying
- (id)copyWithZone:(NSZone *)zone{
    //node is immutable object
    return self;
}


@end
