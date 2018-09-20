//
//  VZFValue.h
//  VZFlexLayout
//
//  Created by moxin on 16/2/11.
//  Copyright © 2016年 Vizlab. All rights reserved.
//




#include <type_traits>
#include <unordered_map>
#import <UIKit/UIKit.h>


/**
 typedef enum {
 FlexHorizontal,
 FlexVertical,
 FlexHorizontalReverse,
 FlexVerticalReverse
 } FlexDirection;
 */
typedef NS_ENUM(int, VZFlexLayoutDirection){
    VZFlexHorizontal,
    VZFlexVertical,
    VZFlexHorizontalReverse,
    VZFlexVerticalReverse
};
/**
 typedef enum {
 FlexInherit,
 FlexStretch,
 FlexStart,
 FlexCenter,
 FlexEnd,
 FlexSpaceBetween,
 FlexSpaceAround,
 FlexBaseline
 } FlexAlign;
 */
typedef NS_ENUM(int, VZFlexLayoutAlignment){
    
    VZFlexInherit,
    VZFlexStretch,
    VZFlexStart,
    VZFlexCenter,
    VZFlexEnd,
    VZFlexSpaceBetween,
    VZFlexSpaceAround,
    VZFlexBaseline,
    
};

typedef NS_ENUM(int, VZFlexLayoutWrapMode) {
    
    VZFlexNoWrap,
    VZFlexWrap,
    VZFlexWrapReverse,
    
};

namespace VZ{
    
    //moxin:自定义一组抽象的数据类型
    namespace Internal{
        
        template<typename Type, const Type& defaultValue, bool isClass = false>
        struct _Value {
            Type value;
            _Value() : value(defaultValue) {}
            _Value(Type value) : value(value) {}
            template<typename... Args>
            _Value(Args... args) : value(args...) {
                static_assert(std::is_constructible<Type, Args...>::value, "there is no suitable constructor");
            }
            operator Type() const { return value; }
            bool isDefault() const { return value == defaultValue; }
        };
        
        template<typename Type, const Type& defaultValue>
        struct _Value <Type, defaultValue, true> : public Type {
            _Value() : Type(defaultValue) {}
            _Value(Type value) : Type(value) {}
            template<typename... Args>
            _Value(Args... args) : Type(args...) {
                static_assert(std::is_constructible<Type, Args...>::value, "there is no suitable constructor");
            }
            operator Type() const { return *this; }
            bool isDefault() const { return *this == defaultValue; }
        };
        
        
        template<typename Type, bool isOCClass = false>
        struct _StatefulValue : public std::unordered_map<UIControlState, Type> {
            using MapType = std::unordered_map<UIControlState, Type>;
            
            _StatefulValue() : _StatefulValue({}) {}
            _StatefulValue(Type value) : MapType({{UIControlStateNormal, Type(value)}}) {}
            template<typename... Args>
            _StatefulValue(Args... args) : MapType({{UIControlStateNormal, Type(args...)}}) {
                static_assert(std::is_constructible<Type, Args...>::value, "there is no suitable constructor");
            }
            _StatefulValue(std::initializer_list<typename MapType::value_type> map) : MapType(map) {}
        };
        
        template<typename Type>
        struct _StatefulValue<Type, true> : public std::unordered_map<UIControlState, Type> {
            using MapType = std::unordered_map<UIControlState, Type>;
            
            _StatefulValue() : _StatefulValue({}) {}
            _StatefulValue(Type value) : MapType({{UIControlStateNormal, Type(value)}}) {}
            template<typename... Args>
            _StatefulValue(Args... args) : MapType({{UIControlStateNormal, Type(args...)}}) {
                static_assert(std::is_constructible<Type, Args...>::value, "there is no suitable constructor");
            }
            _StatefulValue(std::initializer_list<typename MapType::value_type> map) : MapType(map) {}
            bool operator == (const _StatefulValue& other) const {
                if (this->size() != other.size()) return false;
                for (int i=0;i<this->size();i++) {
                    if (![(id)this->at(i) isEqual:other.at(i)]) return false;
                }
                return true;
            }
        };
        
        
    }

    template<typename Type, const Type& defaultValue>
    using Value = Internal::_Value<Type, defaultValue, std::is_class<Type>::value>;
    
    template<typename Type>
    using StatefulValue = Internal::_StatefulValue<Type, std::is_convertible<Type, id>::value>;
    
    

    namespace FlexValue{
        
        // 确保被初始化了 http://stackoverflow.com/questions/3826268/static-initialization-order-issue-in-c
        float Undefined();
        float Auto();
        
    }
    
}



/**
 *  实现Objective-C版本的Tuple
 */
@interface VZFTuple : NSObject<NSCopying,NSCoding,NSFastEnumeration>

@property (nonatomic, readonly) NSUInteger count;

@property (nonatomic, readonly) id first;
@property (nonatomic, readonly) id second;
@property (nonatomic, readonly) id third;
@property (nonatomic, readonly) id fourth;
@property (nonatomic, readonly) id fifth;
@property (nonatomic, readonly) id last;

+ (instancetype) tupleWithArray:(NSArray* ) array;

+ (instancetype) tupleWithObjects:(id)obj,... NS_REQUIRES_NIL_TERMINATION;

- (id)objectAtIndex:(NSUInteger)index;

- (NSArray *)allObjects;

@end

/**
 *  实现[]语法糖
 */
@interface VZFTuple(ObjectSubscripting)

- (id)objectAtIndexedSubscript:(NSUInteger)idx;

@end
