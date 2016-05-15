//
//  VZFLength.h
//  O2OReact
//
//  Created by Sleen on 16/4/12.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import "FlexLayout.h"
#import "VZFValue.h"
#import "VZFUtils.h"

namespace VZ {
    namespace Internal {
        
        template<const FlexLength& defaultValue>
        struct _Value <FlexLength, defaultValue, true> : public FlexLength {
            _Value() : FlexLength(defaultValue) {}
            _Value(FlexLength value) : FlexLength(value) {}
            _Value(double value) : FlexLength{static_cast<float>(value), FlexLengthTypeDefault} {}
            bool isDefault() const { return *this == defaultValue; }
        };

    }
}

namespace std {
    template<>
    struct hash<FlexLength>{
        size_t operator()(const FlexLength &length) const {
            NSUInteger subhashes[] = {
                std::hash<int>()(length.type),
                std::hash<float>()(length.value),
            };
            return VZ::Hash::IntegerArrayHash(subhashes, sizeof(subhashes) / sizeof(subhashes[0]));
        }
    };
}

// comparasion between FlexLengths
inline bool operator == (const FlexLength& l1, const FlexLength& l2) {
    return l1.type == l2.type && l1.value == l2.value;
}

inline bool operator != (const FlexLength& l1, const FlexLength& l2) {
    return !(l1 == l2);
}

inline FlexLength vzf_dim(float dim) {
    return flexLength(dim, FlexLengthTypeDefault);
}

#define DEFINE_UNIT_LITERAL_OPERATOR(suffix, unitType) \
inline FlexLength operator "" suffix(unsigned long long value) { \
    return { (float)value, unitType }; \
} \
inline FlexLength operator "" suffix(long double value) { \
    return { (float)value, unitType }; \
}

DEFINE_UNIT_LITERAL_OPERATOR(_d, FlexLengthTypeDefault)
DEFINE_UNIT_LITERAL_OPERATOR(_percent, FlexLengthTypePercent)
DEFINE_UNIT_LITERAL_OPERATOR(_px, FlexLengthTypePx)
DEFINE_UNIT_LITERAL_OPERATOR(_cm, FlexLengthTypeCm)
DEFINE_UNIT_LITERAL_OPERATOR(_mm, FlexLengthTypeMm)
DEFINE_UNIT_LITERAL_OPERATOR(_q, FlexLengthTypeQ)
DEFINE_UNIT_LITERAL_OPERATOR(_in, FlexLengthTypeIn)
DEFINE_UNIT_LITERAL_OPERATOR(_pc, FlexLengthTypePc)
DEFINE_UNIT_LITERAL_OPERATOR(_pt, FlexLengthTypePt)
DEFINE_UNIT_LITERAL_OPERATOR(_em, FlexLengthTypeEm)
//DEFINE_UNIT_LITERAL_OPERATOR(_ex, FlexLengthTypeEx)
//DEFINE_UNIT_LITERAL_OPERATOR(_ch, FlexLengthTypeCh)
//DEFINE_UNIT_LITERAL_OPERATOR(_rem, FlexLengthTypeRem)
DEFINE_UNIT_LITERAL_OPERATOR(_vw, FlexLengthTypeVw)
DEFINE_UNIT_LITERAL_OPERATOR(_vh, FlexLengthTypeVh)
DEFINE_UNIT_LITERAL_OPERATOR(_vmin, FlexLengthTypeVmin)
DEFINE_UNIT_LITERAL_OPERATOR(_vmax, FlexLengthTypeVmax)
