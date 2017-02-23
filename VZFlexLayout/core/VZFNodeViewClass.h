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
    
    /**
     *  ViewClass对应于node的backingview的描述
     */
    struct ViewClass{

        ViewClass();
        ViewClass(Class clz);
        ViewClass(UIView *(^factory)(void),NSString* identifier);

        NSString* identifier() const;
        UIView* createView() const;
        bool hasView() const;
        bool isCustom() const;

        
        bool operator==(const ViewClass &other) const { return [other.identifier() isEqualToString:_identifier]; }
        bool operator!=(const ViewClass &other) const { return ![other.identifier() isEqualToString: _identifier]; }
        
    private:
        NSString*  _identifier;
        UIView *(^_factory)(void);
        bool _isCustom;
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





