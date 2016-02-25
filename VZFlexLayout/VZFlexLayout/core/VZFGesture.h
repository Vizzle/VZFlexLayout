//
//  VZFGesture.h
//  VZFlexLayout
//
//  Created by moxin on 16/2/12.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <string>

namespace VZ {

    typedef void(^gesture_callback_t)(id sender);
    

    struct Gesture{
    
        Gesture():_sel(NULL),_callback(nil),_gesture(nil){}
        Gesture(UIGestureRecognizer* gesture, SEL sel):_sel(sel),_callback(nil),_gesture(gesture){}
        Gesture(UIGestureRecognizer* gesture, gesture_callback_t callback):_sel(NULL),_callback(callback),_gesture(gesture){}
       
        gesture_callback_t getGestureCallback() const { return _callback; }
        UIGestureRecognizer* getGestureRecognizer() const {return _gesture; }
        
        friend bool operator < (const Gesture& x, const Gesture& y){
            
            std::string strX = NSStringFromClass([x.getGestureRecognizer() class]).UTF8String;
            std::string strY = NSStringFromClass([y.getGestureRecognizer() class]).UTF8String;
            
            return std::hash<std::string>()(strX) > std::hash<std::string>()(strY);
        
        }
        
    private:
        UIGestureRecognizer* _gesture;
        SEL _sel;
        gesture_callback_t _callback;
    
    };
    
    template<typename T>
    Gesture GestureBuilder(gesture_callback_t callback){
        T* gesture = [[T alloc] initWithTarget:nil action:nil];
        return Gesture(gesture, callback);
    }
    
}
