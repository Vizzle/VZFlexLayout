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
    
//    struct NodeLayout;
    
//    struct ChildNodeLayout{
//        CGPoint position;
//        NodeLayout layout;
//        
//    };

    struct NodeLayout{
        CGSize size;
        CGPoint origin;
        UIEdgeInsets margin;
        std::shared_ptr<const std::vector<NodeLayout>> children;
    };
    
//    struct ChildNodeLayout;
//    struct NodeLayout{
//        CGSize size;
//        CGPoint position;
//        std::shared_ptr<const std::vector<ChildNodeLayout>> children;
//        NodeLayout(CGSize sz, std::vector<ChildNodeLayout> ch = {}):size(sz),children(new std::vector<ChildNodeLayout>(std::move(ch))){}
//        
//
//    };
//    
}

typedef VZ::NodeLayout VZFNodeLayout;
