
#pragma once

extern "C" {
#define __lint__
#include <sys/time.h>
}

#if defined(__APPLE__)
#   define FLEX_APPLE     1
#   include "TargetConditionals.h"
#   if TARGET_OS_IPHONE
#       define FLEX_IOS   1
#   else
#       define FLEX_OSX   1
#   endif
#endif

#if FLEX_IOS
#   import <UIKit/UIKit.h>
#elif FLEX_OSX
#   import <Cocoa/Cocoa.h>
#   import "MyNSView.h"
#endif

#if FLEX_APPLE
#   define Float double
#   define Size CGSize
#   if FLEX_IOS
#       define OSView                   UIView
#       define OSScrollView             UIScrollView
#       define OSColor                  UIColor
#       define SCREEN_SCALE             [UIScreen mainScreen].scale
#       define CURRENT_GRAPHICS         UIGraphicsGetCurrentContext()
#       define SET_NEEDS_DISPLAY(view)  [view setNeedsDisplay]
#   else
#       define OSView                   NSView
#       define OSScrollView             NSScrollView
#       define OSColor                  NSColor
#       define SCREEN_SCALE             [NSScreen mainScreen].backingScaleFactor
#       define CURRENT_GRAPHICS         [NSGraphicsContext currentContext].CGContext
#       define SET_NEEDS_DISPLAY(view)  [view setNeedsDisplay:YES]
#   endif
#else
#   define Float float
#endif

#pragma GCC diagnostic ignored "-Wgnu-designator"

namespace flex {
    
    static const Float Undefined = -99999999;  // used in properties: marginTop, paddingTop, ...
    static const Float Infinite = -99999998;  // used in constraintedSize, maxWidth, maxHeight
    static const Float Auto = -99999997;       // used in properties: flexBasis, width, height, margin, padding, marginTop, ...
    static const Float Content = -99999996;        // used in properties: flexBasis
    
    inline double getTime() {
        struct timeval tv = { 0 };
        gettimeofday(&tv, NULL);
        return tv.tv_sec + (double)tv.tv_usec / 1000000.0;
    }
    
}
