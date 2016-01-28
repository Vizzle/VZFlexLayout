//
//  VZFNodeLayout.h
//  VZFlexLayout
//
//  Created by moxin on 16/1/27.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <vector>

namespace VZ {
    
    struct NodeLayout{
        CGSize size;
        CGPoint position;
    };
    
    struct StackNodeLayout{
        std::vector<NodeLayout>children = {};
    };
}
