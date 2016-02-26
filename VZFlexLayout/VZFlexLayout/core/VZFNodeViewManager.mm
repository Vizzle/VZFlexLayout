//
//  VZFNodeViewManager.m
//  VZFlexLayout
//
//  Created by moxin on 16/1/30.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFNodeViewManager.h"
#import "VZFGestureForward.h"
#import "VZFNode.h"
#import "VZFNodeInternal.h"
#import "VZFCompositeNode.h"
#import "VZFStackNode.h"
#import "VZFImageNode.h"
#import "VZFTextNode.h"
#import "VZFButtonNode.h"
#import "VZFlexCell.h"
#import <objc/runtime.h>
#import "VZFNodeControllerInternal.h"

@protocol VZFActionWrapper <NSObject>

- (void)invoke:(id)sender event:(UIEvent *)event;

@end

@interface BlockWrapper : NSObject <VZFActionWrapper>
@property (nonatomic, copy) void (^block)(id sender);
@end

@implementation BlockWrapper
- (void) dealloc {
    self.block = nil;
}

- (void) invoke:(id)sender event:(UIEvent *)event {
    self.block(sender);
}
@end


@interface SelectorWrapper : NSObject <VZFActionWrapper>

- (instancetype)initWithSelector:(SEL)selector;

@end

@implementation SelectorWrapper
{
    SEL _selector;
}

- (instancetype)initWithSelector:(SEL)selector {
    if (self = [super init]) {
        _selector = selector;
    }
    return self;
}

- (void)invoke:(UIControl *)sender event:(UIEvent *)event {
    id responder = [sender.node responderForSelector:_selector];
    NSAssert(responder, @"could not found responder for action '%@'", NSStringFromSelector(_selector));
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [responder performSelector:_selector withObject:sender.node withObject:event];
#pragma clang diagnostic pop
}

@end


@implementation UIView(VZFNode)

const void* _id = &_id;
- (void)setNode:(VZFNode *)node{
    objc_setAssociatedObject(self, _id, node, OBJC_ASSOCIATION_ASSIGN);
}

- (VZFNode* )node{
    return objc_getAssociatedObject(self, _id);
}

@end

using namespace VZ;
@implementation VZFNodeViewManager
{

}

+ (UIView* )viewForNode:(VZFNode* )node withLayoutSpec:(const VZFNodeLayout&)layout reuseView:(UIView *)cell
{
    [node.controller nodeWillMount:node];
    UIView *view;
    if (![node isKindOfClass : [VZFStackNode class] ]) {
        
        //对compositeNode做特殊处理
        if ([node isKindOfClass:[VZFCompositeNode class]]) {
            
            VZFCompositeNode* compositeNode = (VZFCompositeNode* )node;
            
            
            view = [self viewForNode:compositeNode.node withLayoutSpec:layout reuseView:cell];
        }
        else{
            view = [self _viewForNode:node withLayoutSpec:layout reuseView:cell];
        }
        
    }
    
    else{
        
        UIView* stackView = [self _viewForNode:node withLayoutSpec:layout reuseView:cell];
        VZFStackNode* stackNode = (VZFStackNode* )node;
        
        NSMutableArray *subviews = [[NSMutableArray alloc] initWithCapacity:stackNode.children.size()];
        
        if (cell) {
            
            VZFNode* oldNode = objc_getAssociatedObject(cell, &kViewReuseInfoKey);
            
            if(!oldNode.specs.view.block) {
                [subviews addObjectsFromArray:cell.subviews];
            }
        }
        
        for (int i = 0; i < stackNode.children.size(); i++) {
            
            VZFStackChildNode _childNode = stackNode.children[i];
            VZFNode* _node = _childNode.node;
            VZFNodeLayout _layout = layout.childrenLayout()[i];
            if ([_node isKindOfClass:[VZFStackNode class]]) {
                //递归
                UIView* stackViewRecursive=[self viewForNode:_node withLayoutSpec:_layout reuseView:subviews.count > i?subviews[i]:nil];
                [stackView addSubview:stackViewRecursive];
            }
            else{
                UIView* view = [self _viewForNode:_node withLayoutSpec:_layout reuseView:subviews.count > i?subviews[i]:nil];
                [stackView addSubview:view];
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
    
    if ((![node isMemberOfClass:VZFImageNode.class] && ![node isMemberOfClass:VZFButtonNode.class] && ![node isMemberOfClass:VZFTextNode.class]) &&[reuseView isMemberOfClass:UIView.class]) {
        return YES;
    }
    
    
    return NO;
}

+ (UIView* )_viewForNode:(VZFNode *)node withLayoutSpec:(const VZFNodeLayout &)layout reuseView:(UIView *)reuseView{
    
    const NodeSpecs specs = node.specs;
    
    UIView* view;

    
    if ([self canReuse:node reuseView:reuseView]) {
        view = reuseView;
    } else {
        
        [reuseView removeFromSuperview];
        view = [self _createUIView:node.viewClass];
    }
    
    [self _applyAttributes:specs.view ToUIView:view];
    view.frame = {layout.nodeOrigin(), layout.nodeSize()};
    [self _applyGestures:specs.gestures ToUIView:view AndNode:node];
    
    if ([node isKindOfClass:[VZFImageNode class]]) {
        VZFImageNode* imageNode = (VZFImageNode* )node;
        ((UIImageView*)view).image = nil;

        [self _applyImageAttributes:imageNode.imagesSpecs ToImageView:(UIImageView* )view];
    }
    else if ([node isKindOfClass:[VZFButtonNode class]]){

        VZFButtonNode* buttonNdoe = (VZFButtonNode* )node;
        [self _applyButtonAttributes:buttonNdoe.buttonSpecs ToUIButton:(UIButton* )view];
    }
    else if ([node isKindOfClass:[VZFTextNode class]]){
        
        VZFTextNode* textNode = (VZFTextNode* )node;
        [self _applyTextAttributes:textNode.textSpecs ToUILabel:(UILabel* )view];
    }
    
    return view;
}


+ (UIView* )viewForNode:(VZFNode* )node withLayoutSpec:(const VZFNodeLayout&)layout
{
    [node.controller nodeWillMount:node];
    UIView *view;
    if (![node isKindOfClass : [VZFStackNode class] ]) {
        
        //对compositeNode做特殊处理
        if ([node isKindOfClass:[VZFCompositeNode class]]) {
            
            VZFCompositeNode* compositeNode = (VZFCompositeNode* )node;
            view = [self viewForNode:compositeNode.node withLayoutSpec:layout];
        }
        else{
            view = [self _viewForNode:node withLayoutSpec:layout];
        }
      
    }
    
    else{
      
        UIView* stackView = [self _viewForNode:node withLayoutSpec:layout];
        VZFStackNode* stackNode = (VZFStackNode* )node;
        for (int i = 0; i < stackNode.children.size(); i++) {
            
            VZFStackChildNode _childNode = stackNode.children[i];
            VZFNode* _node = _childNode.node;
            VZFNodeLayout _layout = layout.childrenLayout()[i];
            if ([_node isKindOfClass:[VZFStackNode class]]) {
                //递归
                UIView* stackViewRecursive=[self viewForNode:_node withLayoutSpec:_layout];
                [stackView addSubview:stackViewRecursive];
            }
            else{
                UIView* view = [self _viewForNode:_node withLayoutSpec:_layout];
                [stackView addSubview:view];
            }
     
        }
        view = stackView;
    }
    [node.controller nodeDidMount:node];
    return view;
}


+ (UIView* )_viewForNode:(VZFNode *)node withLayoutSpec:(const VZFNodeLayout &)layout{
    
    const NodeSpecs specs = node.specs;
    UIView* view = [self _createUIView:node.viewClass];
    [self _applyAttributes:specs.view ToUIView:view];
    view.frame = {layout.nodeOrigin(), layout.nodeSize()};
    [self _applyGestures:specs.gestures ToUIView:view AndNode:node];
    
    if ([node isKindOfClass:[VZFImageNode class]]) {
        VZFImageNode* imageNode = (VZFImageNode* )node;
        [self _applyImageAttributes:imageNode.imagesSpecs ToImageView:(UIImageView* )view];
    }
    else if ([node isKindOfClass:[VZFButtonNode class]]){
        VZFButtonNode* buttonNdoe = (VZFButtonNode* )node;
        [self _applyButtonAttributes:buttonNdoe.buttonSpecs ToUIButton:(UIButton* )view];
    }
    else if ([node isKindOfClass:[VZFTextNode class]]){
        VZFTextNode* textNode = (VZFTextNode* )node;
        [self _applyTextAttributes:textNode.textSpecs ToUILabel:(UILabel* )view];
    }
    
    
    view.node = node;
    return view;
}

+ (UIView* )_createUIView:(const ViewClass& )clz{

    return clz.createView()?:[UIView new];
}

+ (void)_applyAttributes:(const ViewAttrs&)vs ToUIView:(UIView* )view {

    view.tag                    = vs.tag;
    view.backgroundColor        = vs.backgroundColor;
    view.clipsToBounds          = vs.clipToBounds;
    view.layer.cornerRadius     = vs.layer.cornerRadius;
    view.layer.borderColor      = vs.layer.borderColor.CGColor;
    view.layer.contents         = (__bridge id)vs.layer.contents.CGImage;
    
    if (vs.block) {
        vs.block(view);
    }

    
}

+ (void)_applyGestures:(const std::set<Gesture>&)gestures ToUIView:(UIView* )view AndNode:(VZFNode* )node{

    if (gestures.size() == 0) {
        return;
    }
    
    VZFGestureForward* gestureForward = node.gestureForward;
    if (!gestureForward) {
        VZFGestureForward* gestureForward = [VZFGestureForward new];
        node.gestureForward = gestureForward;
    }
    for (auto g : gestures) {
        
        UIGestureRecognizer* gesture = g.getGestureRecognizer();
        gesture_callback_t callback = g.getGestureCallback();
        [node.gestureForward addGestureWithType:NSStringFromClass([gesture class]) Callback:callback];
        [gesture addTarget:node.gestureForward action:@selector(action:)];
        [view addGestureRecognizer:gesture];
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
    
    [btn removeTarget:nil action:nil forControlEvents:UIControlEventAllEvents];
    static const void* _id = &_id;
    NSMutableArray * actionArray = objc_getAssociatedObject(btn, _id);
    if (actionArray == nil) {
        actionArray = [NSMutableArray array];
        objc_setAssociatedObject(btn, _id, actionArray, OBJC_ASSOCIATION_RETAIN);
    }
    for (auto action : buttonNodeSpecs.actionBlock) {
        BlockWrapper *wrapper = [[BlockWrapper alloc] init];
        wrapper.block = action.second;
        [actionArray addObject:wrapper];
        [btn addTarget:wrapper action:@selector(invoke:event:) forControlEvents:action.first];
    }
    for (auto action : buttonNodeSpecs.actionSelector) {
        SelectorWrapper *wrapper = [[SelectorWrapper alloc] initWithSelector:action.second];
        [actionArray addObject:wrapper];
        [btn addTarget:wrapper action:@selector(invoke:event:) forControlEvents:action.first];
    }

//    [btn setTitleColor:buttonNodeSpecs.titleColorHighlight forState:UIControlStateHighlighted];
//    [btn setTitle:buttonNodeSpecs.titleHighlight forState:UIControlStateHighlighted];
//    [btn setTitleColor:buttonNodeSpecs.titleColor forState:UIControlStateNormal];
//    [btn setTitle:buttonNodeSpecs.title forState:UIControlStateNormal];
//    [btn.titleLabel setFont:buttonNodeSpecs.titleFont];
//    [btn setImage:buttonNodeSpecs.image forState:UIControlStateNormal];
//    [btn setImage:buttonNodeSpecs.imageHighlight forState:UIControlStateHighlighted];
//    [btn setBackgroundImage:buttonNodeSpecs.backgroundImage forState:UIControlStateNormal];
//    [btn setBackgroundImage:buttonNodeSpecs.backgroundImageHighlight forState:UIControlStateHighlighted];
//    btn addTarget:(nullable id) action:(nonnull SEL) forControlEvents:<#(UIControlEvents)#>

    
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

@end