//
//  VZFNodeViewManager.m
//  VZFlexLayout
//
//  Created by moxin on 16/1/30.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFNodeViewManager.h"
#import "VZFNode.h"
#import "VZFNodeInternal.h"
#import "VZFNodeViewClass.h"
#import "VZFNodeSpecs.h"
#import "VZFCompositeNode.h"
#import "VZFStackNode.h"
#import "VZFImageNode.h"
#import "VZFTextNode.h"
#import "VZFButtonNode.h"
#import "VZFNetworkImageNode.h"
#import "VZFNetworkImageView.h"
#import <objc/runtime.h>
#import "VZFNodeControllerInternal.h"
#import "VZFActionWrapper.h"
#import "VZFViewReusePoolManager.h"
#import "VZFNodeLayout.h"
#import "VZFTextNodeSpecs.h"
#import "VZFImageNodeSpecs.h"
#import "VZFButtonNodeSpecs.h"


@implementation UIView(VZFNode)

static const void* g_nodeId = &g_nodeId;
- (void)setNode:(VZFNode *)node{
    objc_setAssociatedObject(self, g_nodeId, node, OBJC_ASSOCIATION_ASSIGN);
}

- (VZFNode* )node{
    return objc_getAssociatedObject(self, g_nodeId);
}

@end

using namespace VZ;

@implementation VZFNodeViewManager
{
    VZFViewReusePoolManager* _reusePoolManager;
}

- (instancetype)initWithView:(UIView *)view{

    self = [super init];
    if (self) {
        _managedView = view;
        _reusePoolManager = [VZFViewReusePoolManager viewReusePoolManagerForView:view];
    }
    return self;
}

- (UIView* )viewForNode:(VZFNode* )node{

//    UIView* v = [_reusePoolManager viewForClass:node.viewClass Spec:node.specs ParentView:_managedView];
    UIView* v=  [_reusePoolManager viewForNode:node ParentView:_managedView];
    return v;
}

- (void)dealloc{
    [_reusePoolManager reset:_managedView];
}


+ (UIView* )viewForNode:(VZFNode* )node withLayoutSpec:(const NodeLayout&)layout reuseView:(UIView *)oldView
{
    [node.controller nodeWillMount:node];
    UIView *view;
    
    VZFNode*(^unwrap)(VZFNode* __input) = ^VZFNode*(VZFNode* __input){
        if([__input isKindOfClass:[VZFCompositeNode class]]){
            return  ((VZFCompositeNode* )__input).node;
        }
        else{
            return __input;
        }
    };
    
    VZFNode* unwrappedNode = unwrap(node);
    if (![unwrappedNode isKindOfClass : [VZFStackNode class] ]) {
        view = [self _viewForNode:unwrappedNode withLayoutSpec:layout reuseView:oldView];
    }
    else{
        
        UIView* stackView = [self _viewForNode:unwrappedNode withLayoutSpec:layout reuseView:oldView];
        VZFStackNode* stackNode = (VZFStackNode* )unwrappedNode;
        
        NSMutableArray *subviews = [[NSMutableArray alloc] initWithCapacity:stackNode.children.size()];
        
        if (oldView) {
            
            VZFNode* oldNode = oldView.node;
            
            if(!oldNode.specs.view.block) {
                [subviews addObjectsFromArray:oldView.subviews];
            }
        }
        
        for (int i = 0; i < stackNode.children.size(); i++) {
            
            VZFStackChildNode _childNode = stackNode.children[i];
            VZFNode* _node = _childNode.node;
            NodeLayout _layout = (*layout.children)[i];
            //递归
            UIView* _view = [self viewForNode:_node withLayoutSpec:_layout reuseView:subviews.count > i?subviews[i]:nil];
            
            if (_view != (subviews.count > i?subviews[i]:nil)) {
                [stackView addSubview:_view];
            }
            
            if (i == (stackNode.children.size() - 1) && subviews.count > stackNode.children.size() && subviews.count > (i+1)) {
                [subviews[i+1] removeFromSuperview];
            }
        }
        view = stackView;
    }
    [node.controller nodeDidMount:node];
    return view;
}

+ (BOOL)canReuse:(VZFNode *)node reuseView:(UIView *)reuseView {
    if ([node isMemberOfClass:VZFImageNode.class] && [reuseView isMemberOfClass:UIImageView.class]) {
        return YES;
    }
    
    if ([node isMemberOfClass:VZFButtonNode.class] && [reuseView isMemberOfClass:UIButton.class]) {
        return YES;
    }
    
    if ([node isMemberOfClass:VZFTextNode.class] && [reuseView isMemberOfClass:UILabel.class]) {
        return YES;
    }
    
    if ([node isMemberOfClass:VZFNetworkImageNode.class] && [reuseView isMemberOfClass:VZFNetworkImageView.class]) {
        return YES;
    }
    
    if ((![node isMemberOfClass:VZFNetworkImageNode.class]&&![node isMemberOfClass:VZFImageNode.class] && ![node isMemberOfClass:VZFButtonNode.class] && ![node isMemberOfClass:VZFTextNode.class]) &&[reuseView isKindOfClass:UIView.class] && [node isKindOfClass:VZFNode.class]) {
        return YES;
    }
    
    
    return NO;
}

+ (UIView* )_viewForNode:(VZFNode *)node withLayoutSpec:(const NodeLayout &)layout reuseView:(UIView *)reuseView{
    
    const NodeSpecs specs = node.specs;
    
    UIView* view;
    
    if ([self canReuse:node reuseView:reuseView]) {
        view = reuseView;
    } else {
        if (reuseView) {
            [reuseView removeFromSuperview];
        }
        view = [self _createUIView:node.viewClass];
    }
    
    [self _applyAttributes:specs.view ToUIView:view];
    
    view.frame = {layout.origin, layout.size};
    [self _applyGestures:specs.gesture ToUIView:view AndNode:node];
    
    
    if ([node isKindOfClass:[VZFImageNode class]]) {
        VZFImageNode* imageNode = (VZFImageNode* )node;
        [self _applyImageAttributes:imageNode.imageSpecs ToImageView:(UIImageView* )view];
    }
    else if ([node isKindOfClass:[VZFButtonNode class]]){
        
        VZFButtonNode* buttonNdoe = (VZFButtonNode* )node;
        [self _applyButtonAttributes:buttonNdoe.buttonSpecs ToUIButton:(UIButton* )view];
    }
    else if ([node isKindOfClass:[VZFTextNode class]]){
        
        VZFTextNode* textNode = (VZFTextNode* )node;
        [self _applyTextAttributes:textNode.textSpecs ToUILabel:(UILabel* )view];
    }
    else if([node isKindOfClass:[VZFNetworkImageNode class]]){
        VZFNetworkImageNode* networkImageNode = (VZFNetworkImageNode* )node;
        
        [self _appleyNetworkImageAttributes:networkImageNode ToNetworkImageView:(VZFNetworkImageView* )view];
    }
    
    view.node = node;
    
    return view;
}

+ (void)_applyGestures:(MultiMap<Class, ActionWrapper>)gestures ToUIView:(UIView* )view AndNode:(VZFNode* )node{
    [view.gestureRecognizers enumerateObjectsUsingBlock:^(__kindof UIGestureRecognizer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj conformsToProtocol:@protocol(VZFActionWrapper)]) {
            [view removeGestureRecognizer:obj];
        }
    }];
    static const void* _id = &_id;
    NSMutableArray *gestureArray = [NSMutableArray array];
    objc_setAssociatedObject(view, _id, gestureArray, OBJC_ASSOCIATION_RETAIN);
    for (auto iter=gestures.begin(); iter!=gestures.end(); iter=gestures.equal_range(iter->first).second){
        auto key = iter->first;
        UIGestureRecognizer *gestureRecognizer = [[key alloc] initWithTarget:nil action:nil];
        auto range = gestures.equal_range(key);
        for (auto it=range.first; it!=range.second; it++){
            id<VZFActionWrapper> wrapper = vz_actionWrapper(it->second);
            [gestureArray addObject:wrapper];
            [gestureRecognizer addTarget:wrapper action:@selector(invoke:)];
        }
        [view addGestureRecognizer:gestureRecognizer];
    }
}

+ (UIView* )_createUIView:(const ViewClass& )clz{
    
    UIView* view = clz.createView()?:[UIView new];
    
    //    if (clz._didEnterReusePool) {
    //        clz._didEnterReusePool(view);
    //    }
    
    return view;
}

+ (void)_applyAttributes:(const ViewAttrs&)vs ToUIView:(UIView* )view {
    
    view.tag                    = vs.tag;
    view.backgroundColor        = vs.backgroundColor?:[UIColor clearColor];
    view.clipsToBounds          = vs.clipsToBounds;
    view.layer.cornerRadius     = vs.layer.cornerRadius;
    view.layer.borderColor      = vs.layer.borderColor.CGColor;
    if (vs.layer.contents.CGImage) {
        view.layer.contents     = (__bridge id)vs.layer.contents.CGImage;
    }
    
    if (vs.block) {
        vs.block(view);
    }
    
    
}

+ (void)_applyImageAttributes:(const ImageNodeSpecs& )imageNodeSpecs ToImageView:(UIImageView* )imageView{
    
    imageView.image = imageNodeSpecs.image;
    imageView.contentMode = imageNodeSpecs.contentMode;
    
}

+ (void)_applyButtonAttributes:(const ButtonNodeSpecs& )buttonNodeSpecs ToUIButton:(UIButton* )btn{
    btn.titleLabel.font = buttonNodeSpecs.font;
    
    for (auto title : buttonNodeSpecs.title) {
        [btn setTitle:title.second forState:title.first];
    }
    
    for (auto color : buttonNodeSpecs.titleColor) {
        [btn setTitleColor:color.second forState:color.first];
    }
    
    for (auto image : buttonNodeSpecs.backgroundImage) {
        [btn setBackgroundImage:image.second forState:image.first];
    }
    
    for (auto image : buttonNodeSpecs.image){
        [btn setImage:image.second forState:image.first];
    }
    
    [btn removeTarget:nil action:nil forControlEvents:UIControlEventAllEvents];
    static const void* _id = &_id;
    NSMutableArray * actionArray = [NSMutableArray array];
    objc_setAssociatedObject(btn, _id, actionArray, OBJC_ASSOCIATION_RETAIN);
    for (auto action : buttonNodeSpecs.action) {
        id<VZFActionWrapper> wrapper = vz_actionWrapper(action.second);
        [actionArray addObject:wrapper];
        [btn addTarget:wrapper action:@selector(invoke:event:) forControlEvents:action.first];
    }
}

+ (void)_applyTextAttributes:(const TextNodeSpecs& )textNodeSpecs ToUILabel:(UILabel* )label{
    
    if (textNodeSpecs.attributedString) {
        label.attributedText = textNodeSpecs.attributedString;
    }
    else {
        label.text = textNodeSpecs.text;
        label.font = textNodeSpecs.font;
        label.textColor = textNodeSpecs.color;
    }
    label.textAlignment = textNodeSpecs.textAlignment;
    label.lineBreakMode = textNodeSpecs.lineBreakMode;
    label.numberOfLines = textNodeSpecs.maximumNumberOfLines;
}

+ (void)_appleyNetworkImageAttributes:(VZFNetworkImageNode* )node ToNetworkImageView:(VZFNetworkImageView* )networkImageView{
    
    
    ImageNodeSpecs imageSpec = node.imageSpecs;
    NSURL* url = imageSpec.url;
    id<VZFNetworkImageDownloadProtocol> imageDownloader = node.imageDownloader;
    UIImage*(^block)(UIImage* ) = node.imageProcessingBlock;
    
    VZFNetworkImageSpec* spec = [[VZFNetworkImageSpec alloc]initWithURL:url defaultImage:imageSpec.image imageProcessingFunc:block imageDownloader:imageDownloader];
    [networkImageView setSpec:spec];
    
}

@end


@implementation VZFNodeViewKey
{
    
}

+ (VZFNodeViewKey* )viewKeyForNodeClass:(Class)nodeClass Identifier:(NSString* )identifier{
    
    VZFNodeViewKey* viewKey = [VZFNodeViewKey new];
    viewKey->_identifier = [identifier copy];
    viewKey->_nodeClass  = nodeClass;
    
    return viewKey;
}


- (BOOL)isEqual:(VZFNodeViewKey* )object
{
    return [self->_identifier isEqualToString:object.identifier] && (self ->_nodeClass == object.nodeClass);
}


@end