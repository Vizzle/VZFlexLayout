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
        

        std::string name = "undefined";
        
        //constructor
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
        const CGSize getNodeSize() const{ return size ; };
        const CGPoint getNodeOriginPoint() const {return origin;};
    private:

        CGSize size = {0,0};
        CGPoint origin = {0,0};
        std::shared_ptr<const std::vector<NodeLayout>> children;
    };
    
    
    struct _NodeLayout{
        CGSize size;
        CGPoint origin;
        _NodeLayout():size({0,0}),origin({0,0}){}
        _NodeLayout(CGSize sz, CGPoint pt):size(sz),origin(pt){}
        const std::string description() const{
            
            std::string sz = NSStringFromCGSize(size).UTF8String;
            std::string pt = NSStringFromCGPoint(origin).UTF8String;
            std::string desc = "{origin:" + pt + "," + "size:"+sz+"}";
            return desc;
        }
    };
    
    struct _StackNodeLayout{
    
        struct _NodeLayout;
        std::vector<_NodeLayout> children;
    };
}

typedef VZ::NodeLayout VZFNodeLayout;

