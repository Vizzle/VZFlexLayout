//
//  VZFNodeViewManager.m
//  VZFlexLayout
//
//  Created by moxin on 16/1/30.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFNodeViewManager.h"
#import "VZFNodeViewClass.h"
#import "VZFNodeUIAttributes.h"
@implementation VZFNodeViewManager
{

}


+ (void)registerNodeWithMountedContext:(const VZ::NodeMountedContext &)context;
{

}

+ (UIView* )viewForConfiguration:(const VZ::UISpecs &)specs;
{
    std::shared_ptr<const VZUISpecs> spec = specs.getSpecs();
    
    VZ::ViewClass viewClass = (*spec.get()).clz;
    UIView* view = viewClass.createView();
    VZ::ViewAttrs vs = (*spec.get()).view;
    view.backgroundColor = vs.backgroundColor;
    view.contentMode = vs.contentMode;
    view.clipsToBounds = vs.clipToBounds;
    view.layer.cornerRadius = vs.layer.cornerRadius;
    view.layer.borderColor = vs.layer.borderColor.CGColor;
    view.layer.contents = (__bridge id)vs.layer.contents.CGImage;

    return view;
}
@end