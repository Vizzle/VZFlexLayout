//
//  VZFTextFieldEventHandler.h
//  VZFlexLayout
//
//  Created by wuwen on 2017/1/3.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 VZFTextField event type

 - VZFTextFieldEventTypeFocus: Text field begin editing (UIControlEventEditingDidBegin)
 - VZFTextFieldEventTypeBlur: Text field resign first responder
 - VZFTextFieldEventTypeChange: Text changed (UIControlEventEditingChanged)
 - VZFTextFieldEventTypeSubmit: Text field did end on exit (UIControlEventEditingDidEndOnExit)
 - VZFTextFieldEventTypeEnd: Text field end editing (UIControlEventEditingDidEnd)
 - VZFTextFieldEventTypeKeyPress: // TODO: Reserved
 */
typedef NS_ENUM(NSInteger, VZFTextFieldEventType) {
    VZFTextFieldEventTypeFocus,
    VZFTextFieldEventTypeBlur,
    VZFTextFieldEventTypeChange,
    VZFTextFieldEventTypeSubmit,
    VZFTextFieldEventTypeEnd,
    VZFTextFieldEventTypeKeyPress
};



/**
 VZFTextField event handler
 */
@interface VZFTextFieldEventHandler : NSObject


/**
 Initialize with a handler block

 @param block A handler block
 @return A `VZFTextFieldEventHandler` instance
 */
- (instancetype)initWithHandler:(void(^)(UITextField *textField, VZFTextFieldEventType type))block;


/**
 Receive event.
 
 You can either ovrride this method or using a handler block to handle events.

 @param type Event type
 @param textField Sender
 */
- (void)onEvent:(VZFTextFieldEventType)type sender:(UITextField *)textField;

@end

NS_ASSUME_NONNULL_END
