//
//  VZFUtils.h
//  VZFlexLayout
//
//  Created by moxin on 16/2/27.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#ifndef VZFUtils_h
#define VZFUtils_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "VZFDispatch.h"

#include <stdio.h>
#import <algorithm>
#import <functional>
#import <type_traits>
#import <vector>
#import <string>


@class VZFNode;
namespace VZ {
    namespace Function{
        
        //(vector<T>) -> (lambda<filter>) -> (vector<T>)
        template<typename T, typename Func>
        auto filter(const T& container, Func && lambda) -> std::vector<typename T::value_type>
        {
            std::vector<typename T::value_type> to;
            for(auto obj : container){
                if(lambda(obj)){
                    to.push_back(obj);
                }
            }
            
            return to;
        }
        
        //(vector<T>) -> (lambda<map>) -> (vector<T>)
        template<typename Func>
        auto map(id<NSFastEnumeration> collection, Func &&func) -> std::vector<decltype(func(std::declval<id>()))>
        {
            std::vector<decltype(func(std::declval<id>()))> to;
            for (id obj in collection) {
                to.push_back(func(obj));
            }
            return to;
        }
    }
    
    namespace Hash{
        
        // Default is not an ObjC class
        template<typename T, typename V = bool>
        struct is_objc_class : std::false_type { };
        
        // Conditionally enable this template specialization on whether T is convertible to id, makes the is_objc_class a true_type
        template<typename T>
        struct is_objc_class<T, typename std::enable_if<std::is_convertible<T, id>::value, bool>::type> : std::true_type { };
        
        // CKUtils::hash<T>()(value) -> either std::hash<T> if c++ or [o hash] if ObjC object.
        template <typename T, typename Enable = void> struct hash;
        
        // For non-objc types, defer to std::hash
        template <typename T> struct hash<T, typename std::enable_if<!is_objc_class<T>::value>::type> {
            size_t operator ()(const T& a) {
                return std::hash<T>()(a);
            }
        };
        
        // For objc types, call [o hash]
        template <typename T> struct hash<T, typename std::enable_if<is_objc_class<T>::value>::type> {
            size_t operator ()(id o) {
                return [o hash];
            }
        };
        
        template <typename T, typename Enable = void> struct is_equal;
        
        // For non-objc types use == operator
        template <typename T> struct is_equal<T, typename std::enable_if<!is_objc_class<T>::value>::type> {
            bool operator ()(const T& a, const T& b) {
                return a == b;
            }
        };
        
        // For objc types, check pointer equality, then use -isEqual:
        template <typename T> struct is_equal<T, typename std::enable_if<is_objc_class<T>::value>::type> {
            bool operator ()(id a, id b) {
                return a == b || [a isEqual:b];
            }
        };
        
        // From folly:
        // This is the Hash128to64 function from Google's cityhash (available
        // under the MIT License).  We use it to reduce multiple 64 bit hashes
        // into a single hash.
        inline uint64_t HashCombine(const uint64_t upper, const uint64_t lower) {
            // Murmur-inspired hashing.
            const uint64_t kMul = 0x9ddfea08eb382d69ULL;
            uint64_t a = (lower ^ upper) * kMul;
            a ^= (a >> 47);
            uint64_t b = (upper ^ a) * kMul;
            b ^= (b >> 47);
            b *= kMul;
            return b;
        }
        
#if __LP64__
        inline size_t Hash64ToNative(uint64_t key) {
            return key;
        }
#else
        
        // Thomas Wang downscaling hash function
        inline size_t Hash64ToNative(uint64_t key) {
            key = (~key) + (key << 18);
            key = key ^ (key >> 31);
            key = key * 21;
            key = key ^ (key >> 11);
            key = key + (key << 6);
            key = key ^ (key >> 22);
            return (uint32_t) key;
        }
#endif
        
        inline NSUInteger IntegerArrayHash(const NSUInteger *subhashes, NSUInteger count)
        {
            uint64_t result = subhashes[0];
            for (int ii = 1; ii < count; ++ii) {
                result = HashCombine(result, subhashes[ii]);
            }
            return Hash64ToNative(result);
        }
        
        
        inline BOOL _ObjectsEqual(id<NSObject> obj1, id<NSObject> obj2)
        {
            return obj1 == obj2 ? YES : [obj1 isEqual:obj2];
        }
        
//        inline NSUInteger ScopeHashValue(Class clz, id identifier){
//            
//            NSUInteger clzHash = [clz hash];
//            NSUInteger idHash = [identifier hash];
//            return clzHash + idHash;
//            
//        }
//        inline NSString* ScopeHashKey(Class clz, id identifier){
//            
//            return [NSString stringWithFormat:@"%@^%@",NSStringFromClass(clz),identifier?:@"(undefined)"];
//        }
    }
    
    namespace UIKit{
    
        inline CGPoint operator+(const CGPoint &p1, const CGPoint &p2)
        {
            return { p1.x + p2.x, p1.y + p2.y };
        }
        
        inline CGPoint operator-(const CGPoint &p1, const CGPoint &p2)
        {
            return { p1.x - p2.x, p1.y - p2.y };
        }
        
        inline CGSize operator+(const CGSize &s1, const CGSize &s2)
        {
            return { s1.width + s2.width, s1.height + s2.height };
        }
        
        inline CGSize operator-(const CGSize &s1, const CGSize &s2)
        {
            return { s1.width - s2.width, s1.height - s2.height };
        }
        
        inline UIEdgeInsets operator+(const UIEdgeInsets &e1, const UIEdgeInsets &e2)
        {
            return { e1.top + e2.top, e1.left + e2.left, e1.bottom + e2.bottom, e1.right + e2.right };
        }
        
        inline UIEdgeInsets operator-(const UIEdgeInsets &e1, const UIEdgeInsets &e2)
        {
            return { e1.top - e2.top, e1.left - e2.left, e1.bottom - e2.bottom, e1.right - e2.right };
        }
        
        inline UIEdgeInsets operator*(const UIEdgeInsets &e1, const UIEdgeInsets &e2)
        {
            return { e1.top * e2.top, e1.left * e2.left, e1.bottom * e2.bottom, e1.right * e2.right };
        }
        
        inline UIEdgeInsets operator-(const UIEdgeInsets &e)
        {
            return { -e.top, -e.left, -e.bottom, -e.right };
        }
    }
    
    namespace Helper{
    
        //返回指针地址
        std::string stringFromPointer(const void* ptr);
        
        //返回屏幕scale
        CGFloat screenScale();
        
    }
    
    namespace LifeCycle{
    
        //在主线程执行释放
        void performDeallocOnMainThread(void(^block)());
        
        //在一个串行异步队列中执行释放
        void performDeallocOnBackgroundThread(void(^block)());
    }
 
    
    class ViewClass;
    namespace Mounting {
    
        void mountingRootView(UIView* v);
        void mountingChildView(UIView* child, UIView* parent);
        
        void createView(UIView* v);
        void destroyView(UIView* v);
        void reset(UIView* v);
        void prepareForReuse(UIView* v);
        void hide(UIView* v);
        void unhide(UIView* v);
    
    }
    
    
    
    
}

#endif /* VZFUtils_h */
