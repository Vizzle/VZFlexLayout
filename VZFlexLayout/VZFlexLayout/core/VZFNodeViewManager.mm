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
#import "VZFCompositeNode.h"
#import "VZFStackNode.h"
#import "VZFImageNode.h"
#import "VZFTextNode.h"
#import "VZFButtonNode.h"
#import "VZFlexCell.h"

@interface BlockWrapper : NSObject
@property (nonatomic, copy) void (^block)(id sender);
- (void) invoke:(id)sender;
@end

@implementation BlockWrapper
- (void) dealloc {
    self.block = nil;
}

- (void) invoke:(id)sender {
    self.block(sender);
}
@end

using namespace VZ;
@implementation VZFNodeViewManager
{

}

+ (UIView* )viewForNode:(VZFNode* )node withLayoutSpec:(const VZFNodeLayout&)layout reuseView:(UIView *)cell
{
    if (![node isKindOfClass : [VZFStackNode class] ]) {
        
        //对compositeNode做特殊处理
        if ([node isKindOfClass:[VZFCompositeNode class]]) {
            
            VZFCompositeNode* compositeNode = (VZFCompositeNode* )node;
            
            
            return [self viewForNode:compositeNode.node withLayoutSpec:layout reuseView:cell];
        }
        else{
            return [self _viewForNode:node withLayoutSpec:layout reuseView:cell];
        }
        
    }
    
    else{
        
        UIView* stackView = [self _viewForNode:node withLayoutSpec:layout reuseView:cell];
        VZFStackNode* stackNode = (VZFStackNode* )node;
        
        NSMutableArray *subviews = [[NSMutableArray alloc] initWithCapacity:stackNode.children.size()];
        
        if (cell) {
            [subviews addObjectsFromArray:cell.subviews];
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
        return stackView;
    }
}

+ (UIView* )_viewForNode:(VZFNode *)node withLayoutSpec:(const VZFNodeLayout &)layout reuseView:(UIView *)reuseView{
    
    const NodeSpecs specs = node.specs;
    
    UIView* view;
    
    
    
    if ([node isKindOfClass:[VZFImageNode class]]) {
        
        //TODO 需要优化代码实现形式，目前开发阶段先这么写测试是否有用
        if ([reuseView isKindOfClass:UIImageView.class]) {
            
            view = reuseView;
        } else {
            view = [self _createUIView:node.viewClass];
        }
        
        VZFImageNode* imageNode = (VZFImageNode* )node;
        [self _applyImageAttributes:imageNode.imagesSpecs ToImageView:(UIImageView* )view];
    }
    else if ([node isKindOfClass:[VZFButtonNode class]]){
        if ([reuseView isKindOfClass:UIButton.class]) {
            view = reuseView;
        } else {
            view = [self _createUIView:node.viewClass];
        }
        VZFButtonNode* buttonNdoe = (VZFButtonNode* )node;
        [self _applyButtonAttributes:buttonNdoe.buttonSpecs ToUIButton:(UIButton* )view];
    }
    else if ([node isKindOfClass:[VZFTextNode class]]){
        
        if ([reuseView isKindOfClass:UILabel.class]) {
            view = reuseView;
        } else {
            view = [self _createUIView:node.viewClass];
        }
        
        VZFTextNode* textNode = (VZFTextNode* )node;
        [self _applyTextAttributes:textNode.textSpecs ToUILabel:(UILabel* )view];
    }
    
    if (view == nil) {
        view = [self _createUIView:node.viewClass];
    }
    [self _applyAttributes:specs.view ToUIView:view];
    view.frame = {layout.nodeOrigin(), layout.nodeSize()};
    [self _applyGestures:specs.gestures ToUIView:view AndNode:node];
    
    return view;
}


+ (UIView* )viewForNode:(VZFNode* )node withLayoutSpec:(const VZFNodeLayout&)layout
{
    if (![node isKindOfClass : [VZFStackNode class] ]) {
        
        //对compositeNode做特殊处理
        if ([node isKindOfClass:[VZFCompositeNode class]]) {
            
            VZFCompositeNode* compositeNode = (VZFCompositeNode* )node;
            return [self viewForNode:compositeNode.node withLayoutSpec:layout];
        }
        else{
            return [self _viewForNode:node withLayoutSpec:layout];
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
        return stackView;
    }
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
    
    return view;
}

+ (UIView* )_createUIView:(const ViewClass& )clz{

    return clz.createView()?:[UIView new];
}

+ (void)_applyAttributes:(const ViewAttrs&)vs ToUIView:(UIView* )view {

    view.tag                    = vs.tag;
    view.userInteractionEnabled = vs.userInteractionEnabled;
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
    for (auto action : buttonNodeSpecs.action) {
        NSMutableArray * blockArray = objc_getAssociatedObject(btn, "blockArray");
        
        if (blockArray == nil) {
            blockArray = [NSMutableArray array];
            objc_setAssociatedObject(btn, "blockArray", blockArray, OBJC_ASSOCIATION_RETAIN);
        }
        
        BlockWrapper *blockWrapper = [[BlockWrapper alloc] init];
        blockWrapper.block = action.action;
        [blockArray addObject:blockWrapper];
        
        NSCAssert([btn isKindOfClass:[UIControl class]], @"ActionAttirbute only supported on UIControl-based node");
        
        [btn addTarget:blockWrapper action:@selector(invoke:) forControlEvents:action.event];
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
//    btn addTarget:(nullable id) action:<#(nonnull SEL)#> forControlEvents:<#(UIControlEvents)#>
    
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