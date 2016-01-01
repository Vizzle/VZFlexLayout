
#pragma once

#include "Macros.h"

#include <string>

namespace flex {
    
#if FLEX_IOS
    using OSImage = UIImage;
#elif FLEX_OSX
    using OSImage = NSImage;
#endif
    
    inline OSImage *imageWithColor(OSColor *color) {
        CGSize size = CGSizeMake(1, 1);
        CGRect rect = {CGPointZero, size};
#if FLEX_IOS
        UIGraphicsBeginImageContext(size);
        CGContextRef context = CURRENT_GRAPHICS;
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillRect(context, rect);
        OSImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
#elif FLEX_OSX
        NSImage* image = [[NSImage alloc] initWithSize:size];
        [image lockFocus];
        CGContextRef context = CURRENT_GRAPHICS;
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillRect(context, rect);
        [image unlockFocus];
#endif
        return image;
    }
    
    class Image {
    public:
        std::string name;
        OSImage *image = nullptr;
        
        Image() {}
        Image(const char *name) : name(name) {}
        Image(std::string name) : name(name) {}
        Image(OSImage *image) : image(image) {}
        Image(OSColor *color) : image(imageWithColor(color)) {}
        Image(Color color) : Image((OSColor *)color) {}
        
        operator OSImage *() const { return image ? image : ~name.empty() ? [OSImage imageNamed:[NSString stringWithUTF8String:name.c_str()]] : nil; }
    };
    
}
