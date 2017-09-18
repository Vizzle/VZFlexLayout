//
//  YogaBridge.h
//  Pods
//
//  Created by Sleen on 2017/8/30.
//
//

#ifndef YogaBridge_h
#define YogaBridge_h

#ifdef __cplusplus
extern "C"{
#endif

#include "FlexLayout.h"

void setUseYoga(bool useYoga);
bool isUseYoga();

void layoutYoga(FlexNodeRef node, float constrainedWidth, float constrainedHeight, float scale);

inline void layout_bridge(FlexNodeRef node, float constrainedWidth, float constrainedHeight, float scale) {
    if (isUseYoga()) {
        layoutYoga(node, constrainedWidth, constrainedHeight, scale);
    }
    else {
        layoutFlexNode(node, constrainedWidth, constrainedHeight, scale);
    }
}

#define layoutFlexNode(node, constrainedWidth, constrainedHeight, scale) layout_bridge(node, constrainedWidth, constrainedHeight, scale)

#ifdef __cplusplus
}
#endif

#endif /* YogaBridge_h */
