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
            
        //constructor
        NodeLayout():size({0,0}),origin({0,0}),margin({0,0,0,0}),children(new std::vector<NodeLayout>()){}
        
        NodeLayout(CGSize sz, CGPoint pt, UIEdgeInsets _margin):size(sz),origin(pt),margin(_margin),children(new std::vector<NodeLayout>()){};
        
        NodeLayout(CGSize sz, CGPoint pt, UIEdgeInsets _margin,std::vector<NodeLayout> childs):size(sz),origin(pt),margin(_margin),children(new std::vector<NodeLayout>(std::move(childs))){};
        
        const std::string description() const{
            
            auto print = [this]() -> std::string{
                
                std::string sz =  NSStringFromCGSize(this -> size).UTF8String;
                std::string pt =  NSStringFromCGPoint(this->origin).UTF8String;
                std::string ret = "( origin:"+pt+","+"size:"+sz+ " )";
                return ret;
            
            };
            
            std::string desc = "\n" + print() + "\n";
            for(NodeLayout l : *children.get()){
                desc += l.description();
            }
            return desc;
        };
        const CGSize nodeSize() const{ return size ; };
        const CGPoint nodeOrigin() const { return origin; };
        const UIEdgeInsets nodeMargin() const { return margin; };
        const std::vector<NodeLayout> childrenLayout() const { return *children; };
    private:

        CGSize size = {0,0};
        CGPoint origin = {0,0};
        UIEdgeInsets margin = {0,0,0,0};
        std::shared_ptr<const std::vector<NodeLayout>> children;
    };

}

typedef VZ::NodeLayout VZFNodeLayout;

