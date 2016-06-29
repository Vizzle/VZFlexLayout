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
        view_state,
        view_action
    };
    
    struct FluxAction{
        ActionType source;
        int32_t actionType;
        __strong id payload;
    };
    
    void sendAction(const FluxAction& action, id sender, id context);
}


