//
//  VZFDispatch.h
//  VZFlexLayout
//
//  Created by Sleen on 2017/2/23.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#ifndef VZFDispatch_h
#define VZFDispatch_h

#ifdef __cplusplus
extern "C"{
#endif

#import <UIKit/UIKit.h>

typedef void (^VZFDispatchBlock)(void);
typedef void (*VZFDispatchMainFunc)(CGFloat delayTime, VZFDispatchBlock block);

void VZFSetDispatchFunc(VZFDispatchMainFunc dispatchMain);
VZFDispatchMainFunc VZFGetDispatchMainFunc(void);

#define VZFDispatchMain(delayTime, block) VZFGetDispatchMainFunc()(delayTime, block)

#ifdef __cplusplus
}
#endif

#endif /* VZFDispatch_h */
