
#pragma once

#include "Macros.h"
#include "Property.h"

#include <string>

namespace flex {
    
    class Color {
    private:
        uint32_t color;
        
    public:
        Color() : color(0) {}
        Color(uint32_t color) : color(color) {}
        Color(const char *color);
        Color(const Color& color) : color(color.color) {}
        
        Color(OSColor *color);
        operator OSColor *() const;
        
        float alpha() const { return float((color >> 24) & 0xff) / 0xff; }
        std::string name() const;
        bool operator == (Color color) { return this->color == color.color; }
        bool operator != (Color color) { return this->color != color.color; }
        
    };
    
    Color rgba(uint8_t r, uint8_t g, uint8_t b, float a);
    inline Color rgb(uint8_t r, uint8_t g, uint8_t b) { return rgba(r, g, b, 1.0f); }
    Color hsla(float h, float s, float l, float a);
    inline Color hsl(float h, float s, float l) { return hsla(h, s, l, 1.0f); }
    
    template<>
    struct PropertyCast<Color> {
        static std::string toString(const Color& value) {
            return value.name();
        }
        
        static Color fromString(const std::string& str) {
            return str.c_str();
        }
    };
    
}
