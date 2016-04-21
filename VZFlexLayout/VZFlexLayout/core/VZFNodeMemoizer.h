//
//  VZFNodeMemoizer.h
//  VZFlexLayout
//
//  Created by moxin on 16/4/20.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <Foundation/Foundation.h>

#include <functional>

// Aspect-oriented type erasure of hash/equals on a tuple
struct VZFMemoizationKey;

id VZFMemoize(VZFMemoizationKey memoizationKey, id (^block)(void));

struct VZFNodeMemoizer {
    
    /**
     Create a memoizer. If you pass in a memoizer state, components will be vended from reuse from there.
     Creating a CKComponentMemoizer in a scope will make memoized components available to CKMemoize().
     This object must remain in scope for objects to be vended.
     */
    VZFNodeMemoizer(id previousMemoizerState);
    
    /**
     Destructor cleans up the intermediate state for the memoizer.
     */
    ~VZFNodeMemoizer();
    
    /**
     Store this state across rebuilding components.
     Do not use this object from multiple threads simultaneously
     */
    id nextMemoizerState();
    
private:
    id _previousMemoizer;
};


struct VZFMemoizationKey
{
    size_t hash;
    
    // This is a shared_ptr to const void* so we can have value semantics (just increment refcount),
    // but use our own equals fn, etc
    std::shared_ptr<const void> internal;
    
    // This key's quality function
    bool (*equals)(const void *, const void *);
    
    bool operator == (const VZFMemoizationKey other) const {
        // Two keys are the same type if their equality functions are the same
        return equals == other.equals
        // The keys are equal if the equality function returns true
        && (internal == other.internal || equals(internal.get(), other.internal.get()));
    };
};

