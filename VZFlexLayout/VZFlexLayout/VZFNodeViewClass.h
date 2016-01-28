//
//  VZFNodeViewClass.hpp
//  VZFlexLayout
//
//  Created by moxin on 16/1/27.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <string>


namespace VZ {
    
    struct VZFNodeViewClass{
        
        VZFNodeViewClass();
        VZFNodeViewClass(Class viewClass);
        VZFNodeViewClass(UIView*(*factory)(void));
        
    private:
        UIView* (^factory)();
    };
}





