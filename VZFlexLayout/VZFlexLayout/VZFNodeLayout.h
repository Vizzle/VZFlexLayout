//
//  VZFNodeLayout.h
//  VZFlexLayout
//
//  Created by moxin on 16/1/27.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <vector>
#import <string>
#import "FlexLayout.h"

namespace VZ {
    
    struct NodeLayout{
        CGSize size;
        CGPoint origin;
        std::shared_ptr<const std::vector<NodeLayout>> children;
        NodeLayout():size({0,0}),origin({0,0}),children(new std::vector<NodeLayout>()){}
        NodeLayout(CGSize sz, CGPoint pt):size(sz),origin(pt),children(new std::vector<NodeLayout>()){};
        NodeLayout(CGSize sz, CGPoint pt, std::vector<NodeLayout> childs):size(sz),origin(pt),children(new std::vector<NodeLayout>(std::move(childs))){};
        const std::string nodeDesc() const{
            
            auto print = [this]() -> std::string{
                
                std::string sz =  NSStringFromCGSize(this -> size).UTF8String;
                std::string pt =  NSStringFromCGPoint(this->origin).UTF8String;
                std::string ret = "origin:"+pt+","+"size:"+sz+"\n";
                return ret;
            
            };
            
            std::string desc = "\n"+print();
            for(NodeLayout l : *children.get()){
                desc += l.nodeDesc();
            }
            return desc;
        };
    };
}

typedef VZ::NodeLayout VZFNodeLayout;

