//
//  VZFActionWrapper.h
//  VZFlexLayout
//
//  Created by Sleen on 16/2/29.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <unordered_map>

typedef void(^UIControlActionBlock)(id sender);


@protocol VZFActionWrapper <NSObject>

@optional
// for control action
- (void)invoke:(id)sender event:(UIEvent *)event;

// for gesture recognizer
- (void)invoke:(id)sender;

// for custom invoke
- (void)invoke:(id)sender withCustomParam:(id)param;

@end


@interface VZFBlockWrapper : NSObject <VZFActionWrapper>
@property (nonatomic, copy) void (^block)(id sender);
- (instancetype)initWithBlock:(UIControlActionBlock)block;
@end


@interface VZFBlockAction : VZFBlockWrapper

@property (nonatomic) UIControlEvents controlEvents;

- (instancetype)initWithControlEvents:(UIControlEvents)controlEvents block:(UIControlActionBlock)block;

+ (instancetype)action:(UIControlActionBlock)block;
+ (instancetype)actionWithControlEvents:(UIControlEvents)controlEvents block:(UIControlActionBlock)block;

@end


@interface VZFBlockGesture : VZFBlockWrapper

@property (nonatomic, strong) Class gestureClass;

- (instancetype)initWithClass:(Class)gestureClass block:(UIControlActionBlock)block;

+ (instancetype)tapGesture:(UIControlActionBlock)block;
+ (instancetype)longPressGesture:(UIControlActionBlock)block;
+ (instancetype)gestureWithClass:(Class)gestureClass block:(UIControlActionBlock)block;

@end

