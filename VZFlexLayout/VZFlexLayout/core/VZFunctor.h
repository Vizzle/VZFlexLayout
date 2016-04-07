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

/* generic functors */

namespace CK {
    
    template<class T>
    struct DescriptionFunctor {
        NSString *operator()(const T &t) const {
            return [NSString stringWithFormat:@"%d", static_cast<int>(t)];
        }
    };
    
}
#endif /* VZFunctor_h */
