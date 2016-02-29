//
//  VZFActionWrapper.h
//  VZFlexLayout
//
//  Created by Sleen on 16/2/29.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^UIControlActionBlock)(id sender);

namespace VZ {
    
    struct ActionWrapper {
        UIControlActionBlock block;
        SEL selector;
        ActionWrapper(UIControlActionBlock block) : block(block) {}
        ActionWrapper(SEL selector) : selector(selector) {}
        
        bool operator==(const ActionWrapper& other) const {
            return block == other.block && selector == other.selector;
        }
    };
    
}


@protocol VZFActionWrapper <NSObject>

- (void)invoke:(id)sender event:(UIEvent *)event;

@end


@interface BlockWrapper : NSObject <VZFActionWrapper>
@property (nonatomic, copy) void (^block)(id sender);
- (instancetype)initWithBlock:(UIControlActionBlock)block;
@end


@interface SelectorWrapper : NSObject <VZFActionWrapper>

- (instancetype)initWithSelector:(SEL)selector;

@end

id<VZFActionWrapper> vz_actionWrapper(VZ::ActionWrapper action);
