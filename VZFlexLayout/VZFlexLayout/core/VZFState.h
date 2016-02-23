//
//  VZFState.h
//  VZFlexLayout
//
//  Created by moxin on 16/2/17.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <Foundation/Foundation.h>




typedef id(^stateTrampolineBlock)(id);
@protocol VZFProps <NSObject>
- (id)value;
- (stateTrampolineBlock)stateTrampolineBlock;
@end

@interface VZFState : NSObject

@end
