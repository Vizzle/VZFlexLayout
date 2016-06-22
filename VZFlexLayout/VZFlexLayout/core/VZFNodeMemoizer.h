//
//  VZFNodeMemoizer.h
//  VZFlexLayout
//
//  Created by moxin on 16/4/20.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <Foundation/Foundation.h>

#include <functional>



struct VZFMemoizationKey;

id VZFMemoize(VZFMemoizationKey memoizationKey, id (^block)(void));

struct VZFNodeMemoizer {
    
    VZFNodeMemoizer(id previousMemoizerState);
    ~VZFNodeMemoizer();
    
    id nextMemoizerState();
    
private:
    id _previousMemoizer;
};


struct VZFMemoizationKey
{
    size_t hash;

    std::shared_ptr<const void> internal;
    
    bool (*equals)(const void *, const void *);
    
    bool operator == (const VZFMemoizationKey other) const {

        return equals == other.equals
        && (internal == other.internal || equals(internal.get(), other.internal.get()));
    };
};

