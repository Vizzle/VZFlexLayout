
#pragma once

#include "Value.h"
#include "Color.h"
#include "Node.h"
#include "Font.h"

#include <string>

namespace flex {
    
    enum class TextAlign {
        Left = NSTextAlignmentLeft,
        Center = NSTextAlignmentCenter,
        Right = NSTextAlignmentRight,
    };
    
    enum class TextWrap {
        WordWrap = NSLineBreakByWordWrapping,
        CharWrap = NSLineBreakByCharWrapping,
        Clip = NSLineBreakByClipping,
        TruncateHead = NSLineBreakByTruncatingHead,
        TruncateMiddle = NSLineBreakByTruncatingMiddle,
        TruncateTail = NSLineBreakByTruncatingTail,
    };
    
    struct TextNode {
        static const Color defaultColor;
        
        std::string text;
        Value<Color, defaultColor> color;
        FontWrapper font;
        TextAlign align;
        TextWrap wrap;
//        int lines;
        
        NSDictionary *attributes() const {
            NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
            style.alignment = (NSTextAlignment)align;
            style.lineBreakMode = (NSLineBreakMode)wrap;
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            dict[NSParagraphStyleAttributeName] = style;
            dict[NSForegroundColorAttributeName] = color;
            OSFont *font = this->font;
            if (font) dict[NSFontAttributeName] = font;
            return dict;
        }
        
    };
    
    class TextNodeClass : public TextNode, public Node {
    public:
        TextNodeClass() {}
        TextNodeClass(TextNode attrs) : TextNode(attrs) {}
        
        virtual Size sizeThatFits(Size constraitedSize) const override {
            
        
            CGSize size = [[NSString stringWithUTF8String:text.c_str()] boundingRectWithSize:CGSize{static_cast<CGFloat>(constraitedSize.width), static_cast<CGFloat>(constraitedSize.height)} options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes() context:nil].size;
            return {size.width, size.height};
        }
        
        virtual OSView* createView() const override {
#if FLEX_IOS
            UILabel *view = [[UILabel alloc] init];
            view.attributedText = [[NSAttributedString alloc] initWithString:[NSString stringWithUTF8String:text.c_str()] attributes:attributes()];
//            view.numberOfLines = lines;
            if (wrap == TextWrap::WordWrap || wrap == TextWrap::CharWrap) {
                view.numberOfLines = 0;
            } else {
                view.numberOfLines = 1;
            }
            return view;
#elif FLEX_OSX
            NSTextView *view = [[NSTextView alloc] init];
            [view setEditable:YES];
            [view insertText:[[NSAttributedString alloc] initWithString:[NSString stringWithUTF8String:text.c_str()] attributes:attributes()] replacementRange:NSMakeRange(0, 0)];
            [view setEditable:NO];
            // FIXME numberOfLines
            return view;
#endif
        }
        
        virtual std::shared_ptr<Node> copy() const override {
            return std::make_shared<TextNodeClass>(*this);
        }
        
    };
    
    REG_NODE(TextNodeClass, TextNode)
    
}
