//
//  VZFNodeViewConfiguration.h
//  VZFlexLayout
//
//  Created by 俞伟平 on 2/26/16.
//  Copyright © 2016 Vizlab. All rights reserved.
//


#import <string>
#import <unordered_map>

#import "VZFNodeViewClass.h"

#import <UIKit/UIKit.h>
/**
 A ViewConfiguration specifies the class of a view and the attributes that should be applied to it.
 Initialize a configuration with brace syntax, for example:
 
 {[UIView class]}
 {[UIView class], {{@selector(setBackgroundColor:), [UIColor redColor]}, {@selector(setAlpha:), @0.5}}}
 */
//struct VZFNodeViewConfiguration {
//    
//    VZFNodeViewConfiguration();
//    
//    VZFNodeViewConfiguration(VZFNodeViewClass &&cls,
//                                 CKViewComponentAttributeValueMap &&attrs = {});
//    
//    VZFNodeViewConfiguration(VZFNodeViewClass &&cls,
//                                 CKViewComponentAttributeValueMap &&attrs,
//                                 VZFNodeAccessibilityContext &&accessibilityCtx);
//    
//    ~VZFNodeViewConfiguration();
//    bool operator==(const VZFNodeViewConfiguration &other) const;
//    
//    const VZFNodeViewClass &viewClass() const;
//    std::shared_ptr<const CKViewComponentAttributeValueMap> attributes() const;
//    const VZFNodeAccessibilityContext &accessibilityContext() const;
//    
//private:
//    struct Repr {
//        VZFNodeViewClass viewClass;
//        std::shared_ptr<const CKViewComponentAttributeValueMap> attributes;
//        VZFNodeAccessibilityContext accessibilityContext;
//        CK::Component::PersistentAttributeShape attributeShape;
//    };
//    
//    static std::shared_ptr<const Repr> singletonViewConfiguration();
//    std::shared_ptr<const Repr> rep; // const is important for the singletonViewConfiguration optimization.
//    
//    friend class CK::Component::ViewReusePoolMap;    // uses attributeShape
//};
//
//namespace std {
//    template<> struct hash<VZFNodeViewConfiguration>
//    {
//        size_t operator()(const VZFNodeViewConfiguration &cl) const;
//    };
//}
