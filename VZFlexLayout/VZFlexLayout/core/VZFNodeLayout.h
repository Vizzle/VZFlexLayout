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
#import "VZFNode.h"

namespace VZ {
    
    struct NodeLayout{
            
        //constructor
        NodeLayout():
        node(nil),size({0,0}),origin({0,0}),margin({0,0,0,0}),children(new std::vector<NodeLayout>()){}
        
        NodeLayout(VZFNode* _node,CGSize _sz, CGPoint _pt, UIEdgeInsets _margin)
            :NodeLayout(_node, _sz, _pt, _margin, {}) {}
        
        NodeLayout(VZFNode* _node,CGSize _sz, CGPoint _pt, UIEdgeInsets _margin,std::vector<NodeLayout> _childs):
        node(_node),margin(_margin),children(new std::vector<NodeLayout>(std::move(_childs))) {
            CGRect alignedFrame = CGRectIntegral(CGRect{_pt, _sz});
            origin = alignedFrame.origin;
            size = alignedFrame.size;
        }
        
        const std::string description() const{
            
            auto print = [this]() -> std::string{
                
                std::string sz =  NSStringFromCGSize(this -> size).UTF8String;
                std::string pt =  NSStringFromCGPoint(this-> origin).UTF8String;
                std::string ret = "( origin:"+pt+","+"size:"+sz+ " )";
                return ret;
            
            };
            
            std::string desc = "\n" + print() + "\n";
            for(NodeLayout l : *children.get()){
                desc += l.description();
            }
            return desc;
        };

        VZFNode* node; //这里小心产生循环引用
        CGSize size = {0,0};
        CGPoint origin = {0,0};
        UIEdgeInsets margin = {0,0,0,0};
        std::shared_ptr<const std::vector<NodeLayout>> children;
    };

}


