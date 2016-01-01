
#pragma once

#include "TextNode.h"
#include "Image.h"

#include <string>

namespace flex {
    
#if FLEX_OSX
    
    typedef NS_OPTIONS(NSUInteger, UIControlState) {
        UIControlStateNormal       = 0,
        UIControlStateHighlighted  = 1 << 0,                  // used when UIControl isHighlighted is set
        UIControlStateDisabled     = 1 << 1,
        UIControlStateSelected     = 1 << 2,                  // flag usable by app (see below)
        UIControlStateFocused NS_ENUM_AVAILABLE_IOS(9_0) = 1 << 3, // Applicable only when the screen supports focus
        UIControlStateApplication  = 0x00FF0000,              // additional flags available for application use
        UIControlStateReserved     = 0xFF000000               // flags reserved for internal framework use
    };

#endif
    
    template<typename Type>
    struct StatefulValue : public std::unordered_map<UIControlState, Type> {
        using MapType = std::unordered_map<UIControlState, Type>;
        
        StatefulValue() : StatefulValue({{UIControlStateNormal, Type()}}) {}
        StatefulValue(Type value) : MapType({{UIControlStateNormal, Type(value)}}) {}
        template<typename... Args>
        StatefulValue(Args... args) : MapType({{UIControlStateNormal, Type(args...)}}) {
            static_assert(std::is_constructible<Type, Args...>::value, "there is no suitable constructor");
        }
        StatefulValue(std::initializer_list<typename MapType::value_type> map) : MapType(map) {}
    };
    
    struct ButtonNode {
        static const Color defaultColor;
        static const TextWrap defaultWrap;
        static const TextAlign defaultAlign;
        
        std::string text;
        StatefulValue<Value<Color, defaultColor>> color;
        StatefulValue<Image> background;
        FontWrapper font;
        Value<TextAlign, defaultAlign> align;
        Value<TextWrap, defaultWrap> wrap;
        SEL action;
        id target;
        
        NSDictionary *attributes() const {
            NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
            style.alignment = (NSTextAlignment)align.value;
            style.lineBreakMode = (NSLineBreakMode)wrap.value;
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            dict[NSParagraphStyleAttributeName] = style;
#if FLEX_OSX
            dict[NSForegroundColorAttributeName] = (NSColor*)color.at(UIControlStateNormal);
#endif
            OSFont *font = this->font;
            if (font) dict[NSFontAttributeName] = font;
            return dict;
        }
        
    };
    
    class ButtonNodeClass : public ButtonNode, public Node {
    public:
        ButtonNodeClass() {}
        ButtonNodeClass(ButtonNode attrs) : ButtonNode(attrs) {}
        
        virtual Size sizeThatFits(Size constraitedSize) const override {
            CGSize size = [[NSString stringWithUTF8String:text.c_str()] boundingRectWithSize:CGSize{static_cast<CGFloat>(constraitedSize.width), static_cast<CGFloat>(constraitedSize.height)} options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes() context:nil].size;
            return {size.width, size.height};
        }
        
        virtual OSView* createView() const override {
#if FLEX_IOS
            UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
            [view setTitle:[NSString stringWithUTF8String:text.c_str()] forState:UIControlStateNormal];
            view.titleLabel.font = font;
            for (const auto& kv : background) {
                [view setBackgroundImage:kv.second forState:kv.first];
            }
            for (const auto& kv : color) {
                [view setTitleColor:kv.second forState:kv.first];
            }
            if (wrap == TextWrap::WordWrap || wrap == TextWrap::CharWrap) {
                view.titleLabel.numberOfLines = 0;
            } else {
                view.titleLabel.numberOfLines = 1;
            }
            return view;
#elif FLEX_OSX
            NSButton *view = [[NSButton alloc] init];
            view.attributedTitle = [[NSAttributedString alloc] initWithString:[NSString stringWithUTF8String:text.c_str()] attributes:attributes()];
            // FIXME numberOfLines
            return view;
#endif
        }
        
        virtual std::shared_ptr<Node> copy() const override {
            return std::make_shared<ButtonNodeClass>(*this);
        }
        
    };
    
    REG_NODE(ButtonNodeClass, ButtonNode)
    
}
