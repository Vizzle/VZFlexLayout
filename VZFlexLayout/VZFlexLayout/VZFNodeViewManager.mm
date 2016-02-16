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
#import "VZFStackNode.h"

using namespace VZ;
@implementation VZFNodeViewManager
{

}
+ (UIView* )viewForNode:(VZFNode* )node withLayoutSpec:(const VZFNodeLayout&)layout
{
    if (![node isKindOfClass : [VZFStackNode class] ]) {
        return [self _viewForNode:node withLayoutSpec:layout];
    }
    else{
      
        UIView* stackView = [self _viewForNode:node withLayoutSpec:layout];
        VZFStackNode* stackNode = (VZFStackNode* )node;
        for (int i = 0; i < stackNode.children.size(); i++) {
            
            VZFStackChildNode _childNode = stackNode.children[i];
            VZFNode* _node = _childNode.node;
            VZFNodeLayout _layout = layout.getChildren()[i];
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
    
    const UISpecs specs = node.specs;
    UIView* view = [self _createUIView:specs.clz];
    [self _applyAttributes:specs.view ToUIView:view];
    view.frame = {layout.getNodeOriginPoint(), layout.getNodeSize()};
    [self _applyGestures:specs.gestures ToUIView:view AndNode:node];
    
    return view;
}


+ (UIView* )_createUIView:(const ViewClass& )clz{

    return clz.createView()?:[UIView new];
}

+ (void)_applyAttributes:(const ViewAttrs&)vs ToUIView:(UIView* )view {

    view.tag = vs.tag;
    view.userInteractionEnabled = vs.userInteractionEnabled;
    view.backgroundColor = vs.backgroundColor;
    view.contentMode = vs.contentMode;
    view.clipsToBounds = vs.clipToBounds;
    view.layer.cornerRadius = vs.layer.cornerRadius;
    view.layer.borderColor = vs.layer.borderColor.CGColor;
    view.layer.contents = (__bridge id)vs.layer.contents.CGImage;
    
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

@end