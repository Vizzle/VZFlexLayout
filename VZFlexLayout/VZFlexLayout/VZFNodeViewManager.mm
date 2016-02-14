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

+ (UIView* )viewForStackNode:(VZFStackNode *)stackNode withStackLayoutSpec:(const VZFNodeLayout &)stackLayout{
    
    if (![stackNode isKindOfClass : [VZFStackNode class] ]) {
        return nil;
    }
    
    VZFStackLayoutSpecs stackSpecs = stackNode.layoutSpecs;
    ViewClass viewClass = stackSpecs.viewSpecs.clz;
    UIView* stackView = viewClass.createView()?:[UIView new];
    const ViewAttrs vs = stackSpecs.viewSpecs.view;
    [self applyUIView:stackView withAttributes:vs];
    
    stackView.frame = CGRectMake(stackLayout.getNodeOriginPoint().x, stackLayout.getNodeOriginPoint().y, stackLayout.getNodeSize().width, stackLayout.getNodeSize().height);

    for (int i = 0; i < stackNode.children.size(); i++) {
        
        VZFStackChildNode childNode = stackNode.children[i];
        VZFNode* node = childNode.node;
        VZFNodeLayout layout = stackLayout.getChildren()[i];
        if ([node isKindOfClass:[VZFStackNode class]]) {
            //递归
            UIView* stackViewRecursive=[self viewForStackNode:(VZFStackNode* )node withStackLayoutSpec:layout];
            [stackView addSubview:stackViewRecursive];
        }
        UIView* view = [self viewForNode:node withLayoutSpec:layout];
        [stackView addSubview:view];
    }
    return stackView;
}

+ (UIView* )viewForNode:(VZFNode *)node withLayoutSpec:(const VZFNodeLayout &)layout{
    
    const UISpecs specs = node.specs;
    std::shared_ptr<const VZUISpecs> spec = specs.getSpecs();
    ViewClass viewClass = (*spec.get()).clz;
    UIView* view = viewClass.createView()?:[UIView new];
    ViewAttrs vs = (*spec.get()).view;
    
    //apply view attributes
    [self applyUIView:view withAttributes:vs];
    
    //apply layout result
    view.frame = CGRectMake(layout.getNodeOriginPoint().x, layout.getNodeOriginPoint().y, layout.getNodeSize().width, layout.getNodeSize().height);

    
    
    //apply gestures
    std::set<Gesture> gestures = (*spec.get()).gestures;
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
    
    return view;
}

+ (void)applyUIView:(UIView* )view withAttributes:(const VZ::ViewAttrs&)vs{


    view.backgroundColor = vs.backgroundColor;
    view.contentMode = vs.contentMode;
    view.clipsToBounds = vs.clipToBounds;
    view.layer.cornerRadius = vs.layer.cornerRadius;
    view.layer.borderColor = vs.layer.borderColor.CGColor;
    view.layer.contents = (__bridge id)vs.layer.contents.CGImage;
    
}

@end