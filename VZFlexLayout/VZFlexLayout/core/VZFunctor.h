//
//  VZFunctor.h
//  O2OReact
//
//  Created by moxin on 16/4/5.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#ifndef VZFunctor_h
#define VZFunctor_h

#import <Foundation/Foundation.h>

/* functors */

namespace VZ {
    
    template<class T>
    struct DescriptionFunctor {
        NSString *operator()(const T &t) const {
            return [NSString stringWithFormat:@"%d", static_cast<int>(t)];
        }
    }__unused;
    
    
    struct ObjectHashFunctor {
        size_t operator()(const __unsafe_unretained id key) const {
            return (size_t)(key);
        }
    };
    
    struct NSStringHashFunctor{
        size_t operator()(const NSString* key)const{
            return [key hash];
        }
    };
    
    struct ObjectEqualFunctor {
        bool operator()(const __unsafe_unretained id left,
                        const __unsafe_unretained id right) const {
            return left == right;
        }
    };
    
    struct NSStringEqualFunctor{
        bool operator()(NSString* left,NSString* right) const {
            return [left isEqualToString:right];
        };
    };
    
    struct ClassHashFunctor {
        size_t operator()(const Class key) const {
            return (size_t)(key);
        }
    };
    
    struct ClassEqualFunctor {
        bool operator()(const Class left, const Class right) const {
            return left == right;
        }
    };
    
}
#endif /* VZFunctor_h */
