
#include "Color.h"

#include <cassert>
#include <cstring>
#include <unordered_map>

namespace flex {
    
    std::unordered_map<std::string, uint32_t> colorNames = {
        { "aliceblue", 0xfff0f8ff },
        { "antiquewhite", 0xfffaebd7 },
        { "aqua", 0xff00ffff },
        { "aquamarine", 0xff7fffd4 },
        { "azure", 0xfff0ffff },
        { "beige", 0xfff5f5dc },
        { "bisque", 0xffffe4c4 },
        { "black", 0xff000000 },
        { "blanchedalmond", 0xffffebcd },
        { "blue", 0xff0000ff },
        { "blueviolet", 0xff8a2be2 },
        { "brown", 0xffa52a2a },
        { "burlywood", 0xffdeb887 },
        { "cadetblue", 0xff5f9ea0 },
        { "chartreuse", 0xff7fff00 },
        { "chocolate", 0xffd2691e },
        { "coral", 0xffff7f50 },
        { "cornflowerblue", 0xff6495ed },
        { "cornsilk", 0xfffff8dc },
        { "crimson", 0xffdc143c },
        { "cyan", 0xff00ffff },
        { "darkblue", 0xff00008b },
        { "darkcyan", 0xff008b8b },
        { "darkgoldenrod", 0xffb8860b },
        { "darkgray", 0xffa9a9a9 },
        { "darkgreen", 0xff006400 },
        { "darkkhaki", 0xffbdb76b },
        { "darkmagenta", 0xff8b008b },
        { "darkolivegreen", 0xff556b2f },
        { "darkorange", 0xffff8c00 },
        { "darkorchid", 0xff9932cc },
        { "darkred", 0xff8b0000 },
        { "darksalmon", 0xffe9967a },
        { "darkseagreen", 0xff8fbc8f },
        { "darkslateblue", 0xff483d8b },
        { "darkslategray", 0xff2f4f4f },
        { "darkturquoise", 0xff00ced1 },
        { "darkviolet", 0xff9400d3 },
        { "deeppink", 0xffff1493 },
        { "deepskyblue", 0xff00bfff },
        { "dimgray", 0xff696969 },
        { "dodgerblue", 0xff1e90ff },
        { "firebrick", 0xffb22222 },
        { "floralwhite", 0xfffffaf0 },
        { "forestgreen", 0xff228b22 },
        { "fuchsia", 0xffff00ff },
        { "gainsboro", 0xffdcdcdc },
        { "ghostwhite", 0xfff8f8ff },
        { "gold", 0xffffd700 },
        { "goldenrod", 0xffdaa520 },
        { "gray", 0xff808080 },
        { "green", 0xff008000 },
        { "greenyellow", 0xffadff2f },
        { "honeydew", 0xfff0fff0 },
        { "hotpink", 0xffff69b4 },
        { "indianred", 0xffcd5c5c },
        { "indigo", 0xff4b0082 },
        { "ivory", 0xfffffff0 },
        { "khaki", 0xfff0e68c },
        { "lavender", 0xffe6e6fa },
        { "lavenderblush", 0xfffff0f5 },
        { "lawngreen", 0xff7cfc00 },
        { "lemonchiffon", 0xfffffacd },
        { "lightblue", 0xffadd8e6 },
        { "lightcoral", 0xfff08080 },
        { "lightcyan", 0xffe0ffff },
        { "lightgoldenrodyellow", 0xfffafad2 },
        { "lightgray", 0xffd3d3d3 },
        { "lightgreen", 0xff90ee90 },
        { "lightpink", 0xffffb6c1 },
        { "lightsalmon", 0xffffa07a },
        { "lightseagreen", 0xff20b2aa },
        { "lightskyblue", 0xff87cefa },
        { "lightslategray", 0xff778899 },
        { "lightsteelblue", 0xffb0c4de },
        { "lightyellow", 0xffffffe0 },
        { "lime", 0xff00ff00 },
        { "limegreen", 0xff32cd32 },
        { "linen", 0xfffaf0e6 },
        { "magenta", 0xffff00ff },
        { "maroon", 0xff800000 },
        { "mediumaquamarine", 0xff66cdaa },
        { "mediumblue", 0xff0000cd },
        { "mediumorchid", 0xffba55d3 },
        { "mediumpurple", 0xff9370db },
        { "mediumseagreen", 0xff3cb371 },
        { "mediumslateblue", 0xff7b68ee },
        { "mediumspringgreen", 0xff00fa9a },
        { "mediumturquoise", 0xff48d1cc },
        { "mediumvioletred", 0xffc71585 },
        { "midnightblue", 0xff191970 },
        { "mintcream", 0xfff5fffa },
        { "mistyrose", 0xffffe4e1 },
        { "moccasin", 0xffffe4b5 },
        { "navajowhite", 0xffffdead },
        { "navy", 0xff000080 },
        { "oldlace", 0xfffdf5e6 },
        { "olive", 0xff808000 },
        { "olivedrab", 0xff6b8e23 },
        { "orange", 0xffffa500 },
        { "orangered", 0xffff4500 },
        { "orchid", 0xffda70d6 },
        { "palegoldenrod", 0xffeee8aa },
        { "palegreen", 0xff98fb98 },
        { "paleturquoise", 0xffafeeee },
        { "palevioletred", 0xffdb7093 },
        { "papayawhip", 0xffffefd5 },
        { "peachpuff", 0xffffdab9 },
        { "peru", 0xffcd853f },
        { "pink", 0xffffc0cb },
        { "plum", 0xffdda0dd },
        { "powderblue", 0xffb0e0e6 },
        { "purple", 0xff800080 },
        { "rebeccapurple", 0xff663399 },
        { "red", 0xffff0000 },
        { "rosybrown", 0xffbc8f8f },
        { "royalblue", 0xff4169e1 },
        { "saddlebrown", 0xff8b4513 },
        { "salmon", 0xfffa8072 },
        { "sandybrown", 0xfff4a460 },
        { "seagreen", 0xff2e8b57 },
        { "seashell", 0xfffff5ee },
        { "sienna", 0xffa0522d },
        { "silver", 0xffc0c0c0 },
        { "skyblue", 0xff87ceeb },
        { "slateblue", 0xff6a5acd },
        { "slategray", 0xff708090 },
        { "snow", 0xfffffafa },
        { "springgreen", 0xff00ff7f },
        { "steelblue", 0xff4682b4 },
        { "tan", 0xffd2b48c },
        { "teal", 0xff008080 },
        { "thistle", 0xffd8bfd8 },
        { "tomato", 0xffff6347 },
        { "turquoise", 0xff40e0d0 },
        { "violet", 0xffee82ee },
        { "wheat", 0xfff5deb3 },
        { "white", 0xffffffff },
        { "whitesmoke", 0xfff5f5f5 },
        { "yellow", 0xffffff00 },
        { "yellowgreen", 0xff9acd32 },
        { "transparent", 0x00000000 },             // extra value to represent transparent color
    };
    
    uint32_t colorFromRgba(int r, int g, int b, int a = 0xff) {
#if !FN_EDITOR
        assert(r >= 0 && r <= 0xff);
        assert(g >= 0 && g <= 0xff);
        assert(b >= 0 && b <= 0xff);
        assert(a >= 0 && a <= 0xff);
#endif
        
        return ((int)(a & 0xff) << 24)
        | ((int)(r & 0xff) << 16)
        | ((int)(g & 0xff) << 8)
        | ((int)(b & 0xff) << 0);
    }
    
    int numberFromHexString(const char *str, size_t len) {
        int r = 0;
        for (int i = 0; i < len; i++) {
            char c = str[i];
            int n = 0;
            if (isdigit(c)) {
                n = c - '0';
            }
            else if (c >= 'A' && c <= 'F') {
                n = c - 'A' + 10;
            }
            else if (c >= 'a' && c <= 'f') {
                n = c - 'a' + 10;
            }
            else {
                return 256;
            }
            r *= 16;
            r += n;
        }
        return r;
    }
    
    std::string numberToHexString(int number) {
        char str[3];
        char c = number / 16;
        c += c < 10 ? '0' : ('A' - 10);
        str[0] = c;
        c = number % 16;
        c += c < 10 ? '0' : ('A' - 10);
        str[1] = c;
        str[2] = 0;
        return str;
    }
    
    uint32_t colorFromHex(const char *hex) {
        size_t len = strlen(hex);
        switch (len) {
            case 4:
                return colorFromRgba(numberFromHexString(hex + 1, 1) * 255 / 15,
                                     numberFromHexString(hex + 2, 1) * 255 / 15,
                                     numberFromHexString(hex + 3, 1) * 255 / 15);
            case 5:
                return colorFromRgba(numberFromHexString(hex + 2, 1) * 255 / 15,
                                     numberFromHexString(hex + 3, 1) * 255 / 15,
                                     numberFromHexString(hex + 4, 1) * 255 / 15,
                                     numberFromHexString(hex + 1, 1) * 255 / 15);
            case 7:
                return colorFromRgba(numberFromHexString(hex + 1, 2),
                                     numberFromHexString(hex + 3, 2),
                                     numberFromHexString(hex + 5, 2));
            case 9:
                return colorFromRgba(numberFromHexString(hex + 3, 2),
                                     numberFromHexString(hex + 5, 2),
                                     numberFromHexString(hex + 7, 2),
                                     numberFromHexString(hex + 1, 2));
        }
        
#if !FN_EDITOR
        assert(false);
#endif
        
        return 0;
    }
    
    std::string colorToHex(uint32_t color) {
        std::string str = "#";
        uint8_t a = (color >> 24) & 0xff;
        uint8_t r = (color >> 16) & 0xff;
        uint8_t g = (color >> 8) & 0xff;
        uint8_t b = (color >> 0) & 0xff;
        if (a < 0xff) {
            str += numberToHexString(a);
        }
        str += numberToHexString(r);
        str += numberToHexString(g);
        str += numberToHexString(b);
        return str;
    }
    
    std::string lowerCasedString(const char* str) {
        size_t len = strlen(str);
        char *newStr = new char[len + 1];
        strcpy(newStr, str);
        for (int i=0;i<len;i++) {
            char c = newStr[i];
            if (c >= 'A' && c <= 'Z') {
                newStr[i] = c + 'a' - 'A';
            }
        }
        std::string ret(newStr);
        delete [] newStr;
        return ret;
    }
    
    Color::Color(const char *color) {
        if (color[0] == 0) {
            this->color = 0;
        } else if (color[0] == '#') {
            this->color = colorFromHex(color);
        } else {
            this->color = colorNames[lowerCasedString(color)];
        }
    }
    
    std::string Color::name() const {
        for (auto& kv : colorNames) {
            if (kv.second == color) {
                return kv.first;
            }
        }
        
        return colorToHex(color);
    }
    
    Color::Color(OSColor *color) {
#if FLEX_OSX
        color = [color colorUsingColorSpaceName:NSCalibratedRGBColorSpace];
        this->color = ((int)(color.alphaComponent * 0xff) << 24)
        | ((int)(color.redComponent * 0xff) << 16)
        | ((int)(color.greenComponent * 0xff) << 8)
        | ((int)(color.blueComponent * 0xff) << 0);
#elif FLEX_IOS
        // TODO there is no equivalent to [NSColor colorUsingColorSpaceName:]
        // this implementation only considerred the CGCalibratedRGBColorSpace and CGCalibratedWhiteColorSpace
        if (color.CIColor.numberOfComponents == 2) {
            this->color = ((int)(color.CIColor.components[1] * 0xff) << 24)
            | ((int)(color.CIColor.components[0] * 0xff) << 16)
            | ((int)(color.CIColor.components[0] * 0xff) << 8)
            | ((int)(color.CIColor.components[0] * 0xff) << 0);
        } else if (color.CIColor.numberOfComponents == 4) {
            this->color = ((int)(color.CIColor.alpha * 0xff) << 24)
            | ((int)(color.CIColor.red * 0xff) << 16)
            | ((int)(color.CIColor.green * 0xff) << 8)
            | ((int)(color.CIColor.blue * 0xff) << 0);
        } else {
            this->color = 0;
        }
#endif
    }
    
    Color::operator OSColor *() const {
        return [OSColor colorWithRed:(float)((color >> 16) & 0xff) / 0xff
                               green:(float)((color >> 8) & 0xff) / 0xff
                                blue:(float)((color >> 0) & 0xff) / 0xff
                               alpha:(float)((color >> 24) & 0xff) / 0xff];
    }
    
    Color rgba(uint8_t r, uint8_t g, uint8_t b, float a) {
        a = std::min(std::max(a, 0.0f), 1.0f);
        return Color(((uint8_t)(a * 0xff) << 24) | (r << 16) | (g << 8) | b);
    }
    
    Color hsla(float h, float s, float l, float a) {
        float q = l < 0.5f ? (l * (1 + s)) : (l + s - (l * s));
        float p = 2 * l - q;
        float hk = h / 360.0f;
        float tr = hk + 1.0f / 3.0f;
        float tg = hk;
        float tb = hk - 1.0f / 3.0f;
        
#define HSL_COMPONENT(c, tc) \
    if (tc < 0) tc += 1.0f; \
    if (tc > 1) tc -= 1.0f; \
        uint8_t c = (tc < 1.0f / 6.0f ? (p + ((q - p) * 6 * tc)) : tc < 0.5f ? q : tc < 2.0f / 3.0f ? (p + ((q - p) * 6 * (2.0f / 3.0f - tc))) : p) * 0xff;
        
        HSL_COMPONENT(r, tr);
        HSL_COMPONENT(g, tg);
        HSL_COMPONENT(b, tb);
#undef HSL_COMPONENT
        
        return rgba(r, g, b, a);
    }
    
}
