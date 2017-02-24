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

- (void)vz_applyNodeAttributes:(VZFNode *)node {
//    ButtonNodeSpecs specs = ((VZFButtonNode *)node).buttonSpecs;
//    for (int state=UIControlStateNormal;state<=UIControlStateFocused;state++) {
//        [self setTitle:nil forState:state];
//        [self setTitleColor:nil forState:state];
//        [self setBackgroundImage:nil forState:state];
//        [self setImage:nil forState:state];
//    }
//    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    
//    for (auto title : specs.title) {
//        [self setTitle:title.second forState:title.first];
//    }
//    
//    for (auto color : specs.titleColor) {
//        [self setTitleColor:color.second forState:color.first];
//    }
//    
//    for (auto image : specs.backgroundImage) {
//        [self setBackgroundImage:image.second forState:image.first];
//    }
//    
//    for (auto image : specs.image){
//        [self setImage:image.second forState:image.first];
//    }
//    
//    //enlarge touch area
//    if (!CGSizeEqualToSize(CGSizeZero,specs.enlargeSize))
//    {
//        self.enlargeTouchSize = specs.enlargeSize;
//    }
//    else{
//        self.enlargeTouchSize = CGSizeZero;
//    }
//    
//    [self removeTarget:nil action:nil forControlEvents:UIControlEventAllEvents];
//    static const void* _id = &_id;
//    NSMutableArray * actionArray = objc_getAssociatedObject(self, _id);
//    if (actionArray == nil) {
//        actionArray = [NSMutableArray array];
//        objc_setAssociatedObject(self, _id, actionArray, OBJC_ASSOCIATION_RETAIN);
//    }
//    VZFBlockAction *action = specs.action;
//    if (action) {
//        [actionArray addObject:action];
//        [self addTarget:specs.action action:@selector(invoke:event:) forControlEvents:action.controlEvents];
//    }
//    if([self isKindOfClass:[VZFButtonNodeBackingView class]]){
//        [(VZFButtonNodeBackingView *)self setTitleFont:specs.getFont()];
//        [(VZFButtonNodeBackingView *)self setButtonStatus:UIControlStateNormal];
//    }else{
//        self.titleLabel.font = specs.getFont();
//    }

}

@end
