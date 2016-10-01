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
#import "VZFMacros.h"
#import "VZFNode.h"

namespace VZ {
    
    /**
     *  保存nodelayout的结果
     */
    struct NodeLayout{
            
        //constructor
        NodeLayout():
        node(nil),size({0,0}),origin({0,0}),margin({0,0,0,0}),children(new std::vector<NodeLayout>()){}
        
        NodeLayout(VZFNode* _node,CGSize _sz, CGPoint _pt, UIEdgeInsets _margin)
            :NodeLayout(_node, _sz, _pt, _margin, {}) {}
        
        NodeLayout(VZFNode* _node,CGSize _sz, CGPoint _pt, UIEdgeInsets _margin,std::vector<NodeLayout> _childs)
            :node(_node),size(_sz),origin(_pt),margin(_margin),children(new std::vector<NodeLayout>(std::move(_childs)))
        {
            origin = _pt;
            size = _sz;
        }
        ~NodeLayout(){
            
            //Layout可能在非主线程析构
//            VZFC_LOG_DEALLOC(@"VZFNodeLayout");
            
            node = nil;
            children.reset();
            children = nullptr;
        }
        
        //print layout recursively
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

        __strong VZFNode* node; //这里小心产生循环引用
        CGSize size = {0,0};
        CGPoint origin = {0,0};
        UIEdgeInsets margin = {0,0,0,0};
        std::shared_ptr<std::vector<NodeLayout>> children;
    };

}


