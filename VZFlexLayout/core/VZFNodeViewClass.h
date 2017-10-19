//
//  VZFNodeViewClass.hpp
//  VZFlexLayout
//
//  Created by moxin on 16/1/27.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <string>



namespace VZ{
    
    typedef UIView *(^ViewFactory)(CGRect frame);
    
    /**
     *  ViewClass对应于node的backingview的描述
     */
    struct ViewClass{

        ViewClass();
        ViewClass(Class clz);
        ViewClass(ViewFactory factory,NSString* identifier);

        NSString* identifier() const;
        void setIdentifier(NSString *identifier);
        UIView* createView(CGRect frame) const;
        bool hasView() const;
        

        
        bool operator==(const ViewClass &other) const { return [other.identifier() isEqualToString:_identifier]; }
        bool operator!=(const ViewClass &other) const { return ![other.identifier() isEqualToString: _identifier]; }
        
    private:
        NSString*  _identifier;
        ViewFactory _factory;
    };
}


//hash<ViewClass>
namespace std {
    template<>
    struct hash<VZ::ViewClass>{
        size_t operator()(const VZ::ViewClass &cl) const
        {
            return [cl.identifier() hash];
        }
    };
}





