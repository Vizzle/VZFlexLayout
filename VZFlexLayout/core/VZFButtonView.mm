//
//  VZFButtonView.m
//  O2OReact
//
//  Created by moxin on 16/5/30.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import "VZFButtonView.h"
#import "VZFButtonNode.h"
#import "UIView+VZAttributes.h"
#import "VZFButtonNodeSpecs.h"

@implementation VZFButtonView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _enlargeTouchSize = CGSizeZero;
        self.exclusiveTouch = YES;
    }
    return self;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    if (CGSizeEqualToSize(self.enlargeTouchSize, CGSizeZero))
    {
        return [super pointInside:point withEvent:event];
    }
    else
    {
        CGRect rect = CGRectInset(self.bounds, -self.enlargeTouchSize.width, -self.enlargeTouchSize.height);
        return CGRectContainsPoint(rect, point);
    }
}


/////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - backing view interface

- (void)resetState{
    _enlargeTouchSize = CGSizeZero;
}

- (void)vz_applyNodeAttributes:(VZFButtonNode *)node {
    VZFButtonView* btn = (VZFButtonView* )self;
    ButtonNodeSpecs buttonNodeSpecs = node.buttonSpecs;
    // reset
    for (int state=UIControlStateNormal;state<=UIControlStateFocused;state++) {
        [btn setTitle:nil forState:state];
        [btn setTitleColor:nil forState:state];
        [btn setBackgroundImage:nil forState:state];
        [btn setImage:nil forState:state];
    }
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    for (auto title : buttonNodeSpecs.title) {
        [btn setTitle:title.second forState:title.first];
    }
    
    for (auto color : buttonNodeSpecs.titleColor) {
        [btn setTitleColor:color.second forState:color.first];
    }
    
    for (auto image : buttonNodeSpecs.backgroundImage) {
        [btn setBackgroundImage:image.second forState:image.first];
    }
    
    for (auto image : buttonNodeSpecs.image){
        [btn setImage:image.second forState:image.first];
    }
    
    //enlarge touch area
    if (!CGSizeEqualToSize(CGSizeZero,buttonNodeSpecs.enlargeSize))
    {
        btn.enlargeTouchSize = buttonNodeSpecs.enlargeSize;
    }
    else{
        btn.enlargeTouchSize = CGSizeZero;
    }
    
    [btn removeTarget:nil action:nil forControlEvents:UIControlEventAllEvents];
    static const void* _id = &_id;
    NSMutableArray * actionArray = objc_getAssociatedObject(btn, _id);
    if (actionArray == nil) {
        actionArray = [NSMutableArray array];
        objc_setAssociatedObject(btn, _id, actionArray, OBJC_ASSOCIATION_RETAIN);
    }
    VZFBlockAction *action = buttonNodeSpecs.action;
    if (action) {
        [actionArray addObject:action];
        [btn addTarget:buttonNodeSpecs.action action:@selector(invoke:event:) forControlEvents:action.controlEvents];
    }
    
    btn.titleLabel.font = buttonNodeSpecs.getFont();
}

@end
