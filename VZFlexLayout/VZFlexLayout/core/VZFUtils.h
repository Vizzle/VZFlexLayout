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
        
        inline NSUInteger ScopeHashValue(Class clz, id identifier){
            
            NSUInteger clzHash = [clz hash];
            NSUInteger idHash = [identifier hash];
            return clzHash + idHash;
            
        }
        inline NSString* ScopeHashKey(Class clz, id identifier){
            
            return [NSString stringWithFormat:@"%@^%@",NSStringFromClass(clz),identifier?:@"(undefined)"];
        }
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
    
        std::string stringFromPointer(const void* ptr);
        
    }
    
    namespace Layout{
    
        bool shouldRelayout(VZFNode* newNode, VZFNode* oldNode);
    
    }
    
    class ViewClass;
    namespace Mounting {
    
        void mountingRootView(UIView* v);
        void mountingChildView(UIView* child, UIView* parent);
        bool nodeHaveChildren(VZFNode* node);
        VZFNode* unwrapNode(VZFNode* node);
        void createView(UIView* v, const ViewClass& clz, UIView* parentView);
        void hide(UIView* v);
        void unhide(UIView* v);
    
    }
    
    
    
    
}

#endif /* VZFUtils_h */
