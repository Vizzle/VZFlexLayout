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
        action
    };
    enum ActionMode{
        sync,
        async
    };
    
    struct FluxAction{
        ActionType actionType;
        int32_t eventId;
        ActionMode mode;
        __strong id payload;

    };
}


