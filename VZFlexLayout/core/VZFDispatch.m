//
//  VZFDispatch.c
//  VZFlexLayout
//
//  Created by Sleen on 2017/2/23.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#include "VZFDispatch.h"

void defaultDispatchMain(CGFloat delayTime, VZFDispatchBlock block) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayTime * NSEC_PER_SEC)), dispatch_get_main_queue(), block);
}

VZFDispatchMainFunc gDispatchMain = &defaultDispatchMain;

void VZFSetDispatchFunc(VZFDispatchMainFunc dispatchMain) {
    gDispatchMain = dispatchMain;
}

VZFDispatchMainFunc VZFGetDispatchMainFunc() {
    return gDispatchMain;
}
