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
        
        static void send(const FluxAction& action);
        
        ActionType source;
        int32_t actionType;
        __strong id payload;
        
        //指定投递的dispatcher，如果不指定默认投递到全局单例对象
        __weak id dispatcher;
    };
}


