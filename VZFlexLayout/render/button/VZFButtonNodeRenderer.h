//
//  VZFButtonNodeRenderer.h
//  VZFlexLayout-Example
//
//  Created by heling on 2017/1/23.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface VZFButtonNodeRenderer : NSObject

@property(nonatomic,strong) UIFont *titleFont;

-(void)setTitleColor:(UIColor *)color forState:(UIControlState)state;

-(void)setTitle:(NSString *)title forState:(UIControlState)state;

-(void)setImage:(UIImage *)image forState:(UIControlState)state;

-(void)setBackgroundImage:(UIImage *)image forState:(UIControlState)state;

-(void)updateRenderer:(UIControlState)state maxSize:(CGSize)size scale:(CGFloat)sacle;


- (void)drawInContext:(CGContextRef)context bounds:(CGRect)bounds;
@end
