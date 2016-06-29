//
//  VZFluxAction.h
//  O2OReact
//
//  Created by moxin on 16/6/2.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import <Foundation/Foundation.h>

namespace VZ {
    
    enum ActionType{
        state,
        stateless
    };
    class FluxAction{
        
        FluxAction(SEL action, NSString* identifier, ActionType type, id data):
        _action(action),
        _identifier(identifier),
        _type(type),
        _data(data){}
        
    private:
        __strong id _data;
        __strong NSString* _identifier;
        SEL _action;
        ActionType _type;
        
    };
    
    void sendAction(const FluxAction& action, id sender, id context);
}


