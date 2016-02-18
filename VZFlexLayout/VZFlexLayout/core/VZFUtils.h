//
//  VZFUtils.h
//  VZFlexLayout
//
//  Created by moxin on 16/2/4.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#pragma once

#import <algorithm>
#import <functional>
#import <type_traits>
#import <vector>

namespace VZ {
    namespace F{
        
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
        inline size_t CKHash64ToNative(uint64_t key) {
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
    }
}

