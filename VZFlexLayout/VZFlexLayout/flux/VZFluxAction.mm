//
//  VZFluxAction.m
//  O2OReact
//
//  Created by moxin on 16/6/2.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import "VZFluxAction.h"
#import "VZFluxAppDispatcher.h"

namespace VZ {
    
    void sendAction(const FluxAction& action, id sender, id context)
    {
        [[VZFluxAppDispatcher sharedInstance] handleAction:action];
    }
}
