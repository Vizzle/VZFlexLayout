//
//  VZFNodeMountContext.h
//  VZFlexLayout
//
//  Created by moxin on 16/2/8.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VZFNodeLayout.h"

namespace VZ{
    
    struct NodeMountedContext{
        
        UIView* mountedView;
        VZFNodeLayout mountedLayout;
    };
    
}

typedef VZ::NodeMountedContext VZFNodeMountedConext;