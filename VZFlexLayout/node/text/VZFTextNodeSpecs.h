//
//  VZFTextNodeSpecs.h
//  VZFlexLayout
//
//  Created by moxin on 16/2/17.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VZFUtils.h"
#import "VZFValue.h"
#import "VZFActionWrapper.h"

typedef NS_ENUM(NSUInteger, VZFFontStyle) {
    VZFFontStyleNormal,
    VZFFontStyleUltraLight,
    VZFFontStyleThin,
    VZFFontStyleLight,
    VZFFontStyleMedium,
    VZFFontStyleBold,
    VZFFontStyleHeavy,
    VZFFontStyleBlack,
    
    VZFFontStyleItalic,
    VZFFontStyleBoldItalic
};

typedef NS_ENUM(NSUInteger, VZFTextLineBreakMode) {
    VZFTextLineBreakByWord,
    VZFTextLineBreakByChar,
};

typedef NS_ENUM(NSUInteger, VZFTextTruncationMode) {
    VZFTextTruncatingTail,
    VZFTextTruncatingMiddle,
    VZFTextTruncatingHead,
    VZFTextTruncatingClip,
    VZFTextTruncatingNone,
};

typedef NS_ENUM(NSUInteger, VZFTextVerticalAlignment) {
    VZFTextVerticalAlignmentCenter,
    VZFTextVerticalAlignmentTop,
    VZFTextVerticalAlignmentBottom,
};

namespace VZ {
//    
    UIFont *createFont(NSString *fontName, CGFloat fontSize, VZFFontStyle fontStyle);

    namespace DefaultFlexAttributesValue{
        extern unsigned int lines;
    }
    
    struct TextNodeSpecs{
        
        NSString *text;
        UIColor *color;
        float fontSize;
        NSString *fontName;
        VZFFontStyle fontStyle;
        float miniScaleFactor;
        BOOL adjustsFontSize;
        UIBaselineAdjustment baselineAdjustment;
        NSTextAlignment alignment;
        VZFTextVerticalAlignment verticalAlignment;
        VZFTextLineBreakMode lineBreakMode;
        VZFTextTruncationMode truncationMode;
        mutable NSAttributedString *_attributedString;
        Value<unsigned int, DefaultFlexAttributesValue::lines> lines;
        float kern;
        float lineSpacing;
        
    
        mutable UIFont *_font; //
        
        VZFBlockAction* linkAction;

        //get font
        UIFont *getFont() const;
        
        //get attributes
        NSDictionary* getAttributes() const;
        
        //get attributed string
        NSAttributedString* getAttributedString() const;
        
        //copy method
        TextNodeSpecs copy() const;
        
        //operator
        bool operator==(const TextNodeSpecs &other) const;
        
        size_t hash() const;
        

    };
}

