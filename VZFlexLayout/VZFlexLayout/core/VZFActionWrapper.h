//
//  VZFActionWrapper.h
//  VZFlexLayout
//
//  Created by Sleen on 16/2/29.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <unordered_map>

typedef void(^UIControlActionBlock)(id sender);

namespace VZ {
    
    struct ActionWrapper {
        UIControlActionBlock block;
        SEL selector;
        ActionWrapper(UIControlActionBlock block) : block([block copy]) {}
        ActionWrapper(SEL selector) : selector(selector) {}
        
        bool operator==(const ActionWrapper& other) const {
            return block == other.block && selector == other.selector;
        }
    };
    
    template<typename KeyType>
    struct MultiMapKey {
        static KeyType defaultKey;
    };
    
    template<typename KeyType, typename ValueType>
    struct MultiMap : std::unordered_multimap<KeyType, ValueType> {
        using SuperType = std::unordered_multimap<KeyType, ValueType>;
        
        MultiMap() : SuperType() {}
        template<typename T>
        MultiMap(T value) : SuperType({{MultiMapKey<KeyType>::defaultKey, value}}) {
            static_assert(std::is_convertible<T, ValueType>::value, "there is no suitable constructor");
        }
        MultiMap(typename SuperType::value_type pair) : SuperType({pair}) {}
        MultiMap(std::initializer_list<typename SuperType::value_type> list) : SuperType(list) {}
    };

}


@protocol VZFActionWrapper <NSObject>

// for control action
- (void)invoke:(id)sender event:(UIEvent *)event;

// for gesture recognizer
- (void)invoke:(id)sender;

@end


@interface BlockWrapper : NSObject <VZFActionWrapper>
@property (nonatomic, copy) void (^block)(id sender);
- (instancetype)initWithBlock:(UIControlActionBlock)block;
@end


@interface SelectorWrapper : NSObject <VZFActionWrapper>

- (instancetype)initWithSelector:(SEL)selector;

@end

id<VZFActionWrapper> vz_actionWrapper(VZ::ActionWrapper action);