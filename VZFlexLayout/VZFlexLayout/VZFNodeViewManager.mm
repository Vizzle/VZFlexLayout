//
//  VZFNodeViewManager.m
//  VZFlexLayout
//
//  Created by moxin on 16/1/30.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFNodeViewManager.h"
#import "VZFGestureForward.h"

@implementation VZFNodeViewManager
{

}


+ (UIView* )viewForNode:(VZFNode *)node{
    
    const VZ::UISpecs specs = node.specs;
    
    std::shared_ptr<const VZUISpecs> spec = specs.getSpecs();
    VZ::ViewClass viewClass = (*spec.get()).clz;
    UIView* view = viewClass.createView();
    VZ::ViewAttrs vs = (*spec.get()).view;
    
    //apply view attributes
    view.backgroundColor = vs.backgroundColor;
    view.contentMode = vs.contentMode;
    view.clipsToBounds = vs.clipToBounds;
    view.layer.cornerRadius = vs.layer.cornerRadius;
    view.layer.borderColor = vs.layer.borderColor.CGColor;
    view.layer.contents = (__bridge id)vs.layer.contents.CGImage;
    
    //apply gestures
    std::set<Gesture> gestures = (*spec.get()).gestures;
    
    for (auto g : gestures) {
        
        UIGestureRecognizer* gesture = g.getGestureRecognizer();
        gesture_callback_t callback = g.getGestureCallback();
        VZFGestureForward* gestureForward = [VZFGestureForward new];
        [gestureForward addGestureWithType:NSStringFromClass([gesture class]) Callback:callback];
        [gesture addTarget:gestureForward action:@selector(action:)];
        node.gestureForward = gestureForward;
        [view addGestureRecognizer:gesture];
    
    }
    
    return view;
}


@end