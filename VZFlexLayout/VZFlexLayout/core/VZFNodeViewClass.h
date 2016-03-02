//
//  VZFNodeViewClass.hpp
//  VZFlexLayout
//
//  Created by moxin on 16/1/27.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <string>
#import "VZFNodeViewReuseManager.h"
#import "VZFNodeReuseUtility.h"

using namespace VZ;

struct ViewClass{
    
    ViewClass();
    ViewClass(Class clz);
    ViewClass(Class clz, SEL enter, SEL leave);
    ViewClass(UIView *(^factory)(void), NSString* identifier, void(^enter)(UIView* v)= nil,void(^leave)(UIView* v)  = nil);

    const std::string &identifier() const;
    UIView* createView() const;
    bool hasView() const;
    
    bool operator==(const ViewClass &other) const { return other.identifier() == _identifier; }
    
private:
    std::string _identifier;
    UIView *(^_factory)(void);
    void(^_didEnterReusePool)(UIView* v);
    void(^_willLeaveReusePool)(UIView* v);
    friend class ViewReuseUtilities;
};

//hash<ViewClass>
namespace std {
    template<>
    struct hash<ViewClass>{
        size_t operator()(const ViewClass &cl) const
        {
            return hash<std::string>()(cl.identifier());
        }
    };
}

struct VZFNodeViewConfiguration {
    
    VZFNodeViewConfiguration();
    
    VZFNodeViewConfiguration(ViewClass &&cls,
                             VZFNodeViewAttributeValueMap &&attrs = {});
    
    
    ~VZFNodeViewConfiguration();
    bool operator==(const VZFNodeViewConfiguration &other) const;
    
    const ViewClass &viewClass() const;
    std::shared_ptr<const VZFNodeViewAttributeValueMap> attributes() const;
    
private:
    struct Repr {
        ViewClass viewClass;
        std::shared_ptr<const VZFNodeViewAttributeValueMap> attributes;
//        PersistentAttributeShape attributeShape;
    };
    
    static std::shared_ptr<const Repr> singletonViewConfiguration();
    std::shared_ptr<const Repr> rep; // const is important for the singletonViewConfiguration optimization.
    
    friend class ViewReusePoolMap;    // uses attributeShape
};

namespace std {
    template<> struct hash<VZFNodeViewConfiguration>
    {
        size_t operator()(const VZFNodeViewConfiguration &cl) const;
    };
}




