
#pragma once

#include "Macros.h"
#include "Value.h"

#include <string>

namespace flex {

#if FLEX_IOS
    using OSFont = UIFont;
#elif FLEX_OSX
    using OSFont = NSFont;
#endif
    
    struct Font {
        static const Float defaultSize;
        
        std::string name;
        Value<Float, defaultSize> size;
        unsigned italic : 1;
        unsigned bold : 1;
        unsigned expanded : 1;
        unsigned condensed : 1;
        unsigned monoSpace : 1;
        unsigned vertical : 1;
        unsigned uiOptimized : 1;
    };
    
    class FontWrapper {
    public:
        Font font;
        
        FontWrapper() : font({}) {}
        FontWrapper(const Font& font) : font(font) {}
        FontWrapper(OSFont *font);
        operator OSFont *() const;
    };
    
}
