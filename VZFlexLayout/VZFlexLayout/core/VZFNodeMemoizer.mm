//
//  VZFNodeMemoizer.m
//  VZFlexLayout
//
//  Created by moxin on 16/4/20.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFNodeMemoizer.h"
#import "VZFNode.h"
#import "VZFNodeSubClass.h"
#import "VZFNodeLayout.h"
#import "VZFUtils.h"
#include <map>
#include <unordered_map>

static NSString *VZFNodeMemoizerThreadKey = @"VZFNodeMemoizer";

// Define hash as just pulling out the precomputed hash field
namespace std {
    template <>
    struct hash<VZFMemoizationKey> {
        size_t operator ()(VZFMemoizationKey a) const {
            return a.hash;
        };
    };
}

struct VZFNodeLayoutMemoizationKey {
    VZFNode *node;
    CGSize containerSize;
    
    struct Hash {
        size_t operator ()(VZFNodeLayoutMemoizationKey a) const {
            NSUInteger subhashes[] = {
                VZ::Hash::hash<id>()(a.node),
                VZ::Hash::hash<float>()(a.containerSize.width),
                VZ::Hash::hash<float>()(a.containerSize.height)

            };
            return VZ::Hash::IntegerArrayHash(subhashes, (sizeof(subhashes)/sizeof(subhashes[0])));
        };
    };
    
    struct Equals {
        bool operator ()(VZFNodeLayoutMemoizationKey a, VZFNodeLayoutMemoizationKey b) const {
            return a.node == b.node
            && CGSizeEqualToSize(a.containerSize, b.containerSize);
        }
    };
};



@interface _VZFNodeMemoizerImpl : NSObject {
    @package
    
    // Store into the next state, read from the current
    _VZFNodeMemoizerImpl *_next;
    
    // maps CKMemoizationKey -> any number of CKComponent *
    std::unordered_multimap<VZFMemoizationKey, VZFNode *> nodeCache_;
    
    std::unordered_map<VZFNodeLayoutMemoizationKey,
                                    VZ::NodeLayout,
                    VZFNodeLayoutMemoizationKey::Hash,
                    VZFNodeLayoutMemoizationKey::Equals> layoutCache_;
}

@end


@implementation _VZFNodeMemoizerImpl

- (VZFNode *)dequeueNodeForKey:(VZFMemoizationKey)key
{
    auto it = nodeCache_.find(key);
    if (it != nodeCache_.end()) {
        VZFNode *c = it->second;
        // Remove this component from the cache, since you can't mount a component twice
        nodeCache_.erase(it);
        return c;
    }
    return nil;
}

- (_VZFNodeMemoizerImpl *)next
{
    if (!_next) {
        _next = [[_VZFNodeMemoizerImpl alloc] init];
    }
    return _next;
}

- (void)enqueueNode:(VZFNode *)node forKey:(VZFMemoizationKey)key
{
    self.next->nodeCache_.insert({key, node});
}

- (VZ::NodeLayout)cachedLayout:(VZFNode *)node thatFits:(CGSize)constrainedSize
{
    VZFNodeLayoutMemoizationKey key{.node = node, .containerSize = constrainedSize};
    auto it = layoutCache_.find(key);
    if (it != layoutCache_.end()) {
        self.next->layoutCache_.insert({key, it->second});
        return it->second;
    } else {
        VZ::NodeLayout layout = [node  computeLayoutThatFits:constrainedSize];
        self.next->layoutCache_.insert({key, layout});
        return layout;
    }
}

+ (_VZFNodeMemoizerImpl *)currentMemoizer
{
    return [[NSThread currentThread] threadDictionary][VZFNodeMemoizerThreadKey];
}

+ (void)setCurrentMemoizer:(_VZFNodeMemoizerImpl *)memoizer
{
    if (memoizer) {
        [[NSThread currentThread] threadDictionary][VZFNodeMemoizerThreadKey] = memoizer;
    } else {
        [[[NSThread currentThread] threadDictionary] removeObjectForKey:VZFNodeMemoizerThreadKey];
    }
}

@end

VZFNodeMemoizer::VZFNodeMemoizer(id previousMemoizerState)
{
    _VZFNodeMemoizerImpl *mipl = previousMemoizerState ?: [[_VZFNodeMemoizerImpl alloc] init];
    
    // Push this memoizer onto the current thread
    id current = [_VZFNodeMemoizerImpl currentMemoizer];
    _previousMemoizer = current;
    [_VZFNodeMemoizerImpl setCurrentMemoizer:mipl];
};

VZFNodeMemoizer::~VZFNodeMemoizer()
{
    // Pop memoizer
    [_VZFNodeMemoizerImpl setCurrentMemoizer:_previousMemoizer];
}

id VZFMemoize(VZFMemoizationKey memoizationKey, id (^block)(void))
{
    _VZFNodeMemoizerImpl *impl = [_VZFNodeMemoizerImpl currentMemoizer];
    VZFNode *node = [impl dequeueNodeForKey:memoizationKey];
    if (!node && block) {
        node = block();
    }
    if (node) {
        [impl enqueueNode:node forKey:memoizationKey];
    }
    return node;
}

id VZFNodeMemoizer::nextMemoizerState()
{
    _VZFNodeMemoizerImpl *impl = [_VZFNodeMemoizerImpl currentMemoizer];
    return impl ? impl->_next : nil;
}

VZ::NodeLayout VZFMemoizeOrComputeLayout(VZFNode *node, CGSize constrainedSize)
{
    if (node && [node shouldMemoizeLayout]) {
        _VZFNodeMemoizerImpl *impl = [_VZFNodeMemoizerImpl currentMemoizer];
        if (impl) { // If component wants layout memoization but there isn't a current memoizer, fall down to compute case
            return [impl cachedLayout:node thatFits:constrainedSize];
        }
    }
    
    return [node computeLayoutThatFits:constrainedSize];
}