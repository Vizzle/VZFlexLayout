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
    
    const VZ::ViewClass clz = specs.getViewClass();
    UIView* view = clz.createView();
    std::shared_ptr<const VZViewAttributes> viewAttributes = specs.getViewAttributes();
    std::shared_ptr<const VZLayerAttributes> layerAttributes = specs.getLayerAttributes();
    //apply view attributes
    for(const auto &v : *viewAttributes){
        VZ::UIAttribute<UIView> attr = v.first;
        attr.setter(view,v.second);
    }
    //apply layer attributes;
    for (const auto &l : *layerAttributes) {
        VZ::UIAttribute<CALayer> attr = l.first;
        attr.setter(view.layer,l.second);
    }
    return view;
}
@end