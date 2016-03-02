//
//  VZFNodeViewReuseManager.h
//  VZFlexLayout
//
//  Created by 俞伟平 on 3/2/16.
//  Copyright © 2016 Vizlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VZFNodeLayout.h"
#import "VZFNodeViewAttribute.h"
#import "VZFNodeViewClass.h"

#import <deque>
#import <string>
#import <unordered_map>
#import <unordered_set>
#import <utility>
#import <vector>


class VZFNodeViewConfiguration;
class ViewClass;

namespace VZ {
    /**
     Describes a set of attribute *identifiers* for attributes that can't be un-applied (unapplicator is nil).
     Any two components that have a different PersistentAttributeShape cannot recycle the same view.
     */
    class PersistentAttributeShape {
    public:
        PersistentAttributeShape(const VZFNodeViewAttributeValueMap &attributes)
        : _identifier(computeIdentifier(attributes)) {};
        
        bool operator==(const PersistentAttributeShape &other) const {
            return _identifier == other._identifier;
        }
        
    private:
        friend struct ::std::hash<PersistentAttributeShape>;
        /**
         This is a int32_t since they are compared on the main thread where we want optimal performance.
         Behind the scenes, these are looked up/created using a map of unordered_set<string> -> int32_t.
         */
        int32_t _identifier;
        static int32_t computeIdentifier(const VZFNodeViewAttributeValueMap &attributes);
    };
    
    struct ViewKey {
        /**
         Class of the CKComponent. Even if two different CKComponent classes have the same viewClassIdentifier, we don't
         recycle views between them.
         */
        Class componentClass;
        /**
         This differentiates components that have the same componentClass but different view types.
         */
        std::string viewClassIdentifier;
        /**
         To recycle a view, its attribute identifiers must exactly match. Otherwise if you had an initial tree A:
         <View backgroundColor=blue />
         And an updated tree A':
         <View alpha=0.5 />
         And the view was recycled, the blue background color would persist incorrectly when recycling the view.
         We could someday have the concept of a "resettable attribute" but for now, this is the simplest option.
         */
        PersistentAttributeShape attributeShape;
        
        bool operator==(const ViewKey &other) const
        {
            return other.componentClass == componentClass
            && other.viewClassIdentifier == viewClassIdentifier
            && other.attributeShape == attributeShape;
        }
    };
    
    class ViewReusePool {
    public:
        ViewReusePool() : position(pool.begin()) {};
        
        /** Unhides all views vended so far; hides others. Resets position to begin(). */
        void reset();
        
        UIView *viewForClass(const ViewClass &viewClass, UIView *container);
    private:
        std::vector<UIView *> pool;
        /** Points to the next view in pool that has *not* yet been vended. */
        std::vector<UIView *>::iterator position;
        
        ViewReusePool(const ViewReusePool&) = delete;
        ViewReusePool &operator=(const ViewReusePool&) = delete;
    };
    
    class ViewReusePoolMap {
    public:
        static ViewReusePoolMap &viewReusePoolMapForView(UIView *view);
        ViewReusePoolMap() {};
        
        void reset(UIView *container);
        
        UIView *viewForConfiguration(Class componentClass, const VZFNodeViewConfiguration &config, UIView *container);
    private:
        //        std::unordered_map<ViewKey, ViewReusePool> map;
        std::vector<UIView *> vendedViews;
        
        ViewReusePoolMap(const ViewReusePoolMap&) = delete;
        ViewReusePoolMap &operator=(const ViewReusePoolMap&) = delete;
    };
    
}

/** Specialize std::hash. */
namespace std {
    template<> struct hash<VZ::PersistentAttributeShape>
    {
        size_t operator()(const VZ::PersistentAttributeShape &s) const
        {
            return std::hash<int32_t>()(s._identifier);
        }
    };
    
    template <> struct hash<VZ::ViewKey>
    {
        size_t operator()(const VZ::ViewKey &k) const
        {
            return [k.componentClass hash]
            ^ hash<std::string>()(k.viewClassIdentifier)
            ^ std::hash<VZ::PersistentAttributeShape>()(k.attributeShape);
        }
    };
}
