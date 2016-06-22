//
//  VZFluxAction.h
//  O2OReact
//
//  Created by moxin on 16/6/2.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <string>

namespace VZ {
    
    enum ActionType{
        state,
        stateless
    };
    class FluxAction{
        
        FluxAction(SEL action, std::string identifier, ActionType type, id data):
        _action(action),
        _identifier(identifier),
        _type(type),
        _data(data){}
        
    private:
        __strong id _data;
        SEL _action;
        std::string _identifier;
        ActionType _type;
        
    };
    
    void sendAction(const FluxAction& action, id sender, id context);
}


