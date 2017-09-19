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
            _Value(double value) : FlexLength{static_cast<float>(value), FlexLengthTypePoint} {}
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
    return l1.type == l2.type && (l1.type != FlexLengthTypePoint || l1.value == l2.value);
}

inline bool operator != (const FlexLength& l1, const FlexLength& l2) {
    return !(l1 == l2);
}

inline FlexLength vzf_dim(float dim) {
    return (FlexLength){dim, FlexLengthTypePoint};
}

#define DEFINE_UNIT_LITERAL_OPERATOR(suffix, unitType) \
inline FlexLength operator "" suffix(unsigned long long value) { \
    return { (float)value, unitType }; \
} \
inline FlexLength operator "" suffix(long double value) { \
    return { (float)value, unitType }; \
}

DEFINE_UNIT_LITERAL_OPERATOR(_d, FlexLengthTypePoint)
DEFINE_UNIT_LITERAL_OPERATOR(_percent, FlexLengthTypePercent)
