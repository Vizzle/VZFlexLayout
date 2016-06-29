//
//  VZDynamicBlock.m
//  VZAsyncTemplate
//
//  Created by moxin.xt on 15-3-7.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "VZDynamicBlock.h"
#import "VZFValue.h"

@interface VZDynamicBlock()

@property(nonatomic,copy) id block;

@end

@implementation VZDynamicBlock


+ (id)invokeBlock:(id)block withArguments:(VZFTuple* )args
{
    NSParameterAssert(block != nil);
    
    VZDynamicBlock* instance = [[VZDynamicBlock alloc]initWithBlock:block];

    return [instance invokeWithArguments:args];

}

- (id)initWithBlock:(id)block
{
    self = [super init];
    
    if (self){
        
        _block = [block copy];
        
    }
    return self;
}

- (id)invokeWithArguments:(VZFTuple *)arguments {
    
    
    SEL selector = [self selectorForArgumentCount:arguments.count];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[self methodSignatureForSelector:selector]];
    invocation.selector = selector;
    invocation.target = self;
    
    for (NSUInteger i = 0; i < arguments.count; i++) {
        id arg = arguments[i];
        NSInteger argIndex = (NSInteger)(i + 2);
        [invocation setArgument:&arg atIndex:argIndex];
    }
    
    [invocation invoke];
    
    __unsafe_unretained id returnVal;
    [invocation getReturnValue:&returnVal];
    return returnVal;
}

- (SEL)selectorForArgumentCount:(NSUInteger)count {
    NSCParameterAssert(count > 0);
    
    switch (count) {
        case 0: return NULL;
        case 1: return @selector(performWith:);
        case 2: return @selector(performWith::);
        case 3: return @selector(performWith:::);
        case 4: return @selector(performWith::::);
        case 5: return @selector(performWith:::::);
        case 6: return @selector(performWith::::::);
        case 7: return @selector(performWith:::::::);
        case 8: return @selector(performWith::::::::);
        case 9: return @selector(performWith:::::::::);
        case 10: return @selector(performWith::::::::::);
        case 11: return @selector(performWith:::::::::::);
        case 12: return @selector(performWith::::::::::::);
        case 13: return @selector(performWith:::::::::::::);
        case 14: return @selector(performWith::::::::::::::);
        case 15: return @selector(performWith:::::::::::::::);
        default: {NSLog(@"Arguments Count is too high!");return NULL;};
    }
    
    return NULL;
}

- (id)performWith:(id)obj1 {
    id (^block)(id) = self.block;
    return block(obj1);
}

- (id)performWith:(id)obj1 :(id)obj2 {
    id (^block)(id, id) = self.block;
    return block(obj1, obj2);
}

- (id)performWith:(id)obj1 :(id)obj2 :(id)obj3 {
    id (^block)(id, id, id) = self.block;
    return block(obj1, obj2, obj3);
}

- (id)performWith:(id)obj1 :(id)obj2 :(id)obj3 :(id)obj4 {
    id (^block)(id, id, id, id) = self.block;
    return block(obj1, obj2, obj3, obj4);
}

- (id)performWith:(id)obj1 :(id)obj2 :(id)obj3 :(id)obj4 :(id)obj5 {
    id (^block)(id, id, id, id, id) = self.block;
    return block(obj1, obj2, obj3, obj4, obj5);
}

- (id)performWith:(id)obj1 :(id)obj2 :(id)obj3 :(id)obj4 :(id)obj5 :(id)obj6 {
    id (^block)(id, id, id, id, id, id) = self.block;
    return block(obj1, obj2, obj3, obj4, obj5, obj6);
}

- (id)performWith:(id)obj1 :(id)obj2 :(id)obj3 :(id)obj4 :(id)obj5 :(id)obj6 :(id)obj7 {
    id (^block)(id, id, id, id, id, id, id) = self.block;
    return block(obj1, obj2, obj3, obj4, obj5, obj6, obj7);
}

- (id)performWith:(id)obj1 :(id)obj2 :(id)obj3 :(id)obj4 :(id)obj5 :(id)obj6 :(id)obj7 :(id)obj8 {
    id (^block)(id, id, id, id, id, id, id, id) = self.block;
    return block(obj1, obj2, obj3, obj4, obj5, obj6, obj7, obj8);
}

- (id)performWith:(id)obj1 :(id)obj2 :(id)obj3 :(id)obj4 :(id)obj5 :(id)obj6 :(id)obj7 :(id)obj8 :(id)obj9 {
    id (^block)(id, id, id, id, id, id, id, id, id) = self.block;
    return block(obj1, obj2, obj3, obj4, obj5, obj6, obj7, obj8, obj9);
}

- (id)performWith:(id)obj1 :(id)obj2 :(id)obj3 :(id)obj4 :(id)obj5 :(id)obj6 :(id)obj7 :(id)obj8 :(id)obj9 :(id)obj10 {
    id (^block)(id, id, id, id, id, id, id, id, id, id) = self.block;
    return block(obj1, obj2, obj3, obj4, obj5, obj6, obj7, obj8, obj9, obj10);
}

- (id)performWith:(id)obj1 :(id)obj2 :(id)obj3 :(id)obj4 :(id)obj5 :(id)obj6 :(id)obj7 :(id)obj8 :(id)obj9 :(id)obj10 :(id)obj11 {
    id (^block)(id, id, id, id, id, id, id, id, id, id, id) = self.block;
    return block(obj1, obj2, obj3, obj4, obj5, obj6, obj7, obj8, obj9, obj10, obj11);
}

- (id)performWith:(id)obj1 :(id)obj2 :(id)obj3 :(id)obj4 :(id)obj5 :(id)obj6 :(id)obj7 :(id)obj8 :(id)obj9 :(id)obj10 :(id)obj11 :(id)obj12 {
    id (^block)(id, id, id, id, id, id, id, id, id, id, id, id) = self.block;
    return block(obj1, obj2, obj3, obj4, obj5, obj6, obj7, obj8, obj9, obj10, obj11, obj12);
}

- (id)performWith:(id)obj1 :(id)obj2 :(id)obj3 :(id)obj4 :(id)obj5 :(id)obj6 :(id)obj7 :(id)obj8 :(id)obj9 :(id)obj10 :(id)obj11 :(id)obj12 :(id)obj13 {
    id (^block)(id, id, id, id, id, id, id, id, id, id, id, id, id) = self.block;
    return block(obj1, obj2, obj3, obj4, obj5, obj6, obj7, obj8, obj9, obj10, obj11, obj12, obj13);
}

- (id)performWith:(id)obj1 :(id)obj2 :(id)obj3 :(id)obj4 :(id)obj5 :(id)obj6 :(id)obj7 :(id)obj8 :(id)obj9 :(id)obj10 :(id)obj11 :(id)obj12 :(id)obj13 :(id)obj14 {
    id (^block)(id, id, id, id, id, id, id, id, id, id, id, id, id, id) = self.block;
    return block(obj1, obj2, obj3, obj4, obj5, obj6, obj7, obj8, obj9, obj10, obj11, obj12, obj13, obj14);
}

- (id)performWith:(id)obj1 :(id)obj2 :(id)obj3 :(id)obj4 :(id)obj5 :(id)obj6 :(id)obj7 :(id)obj8 :(id)obj9 :(id)obj10 :(id)obj11 :(id)obj12 :(id)obj13 :(id)obj14 :(id)obj15 {
    id (^block)(id, id, id, id, id, id, id, id, id, id, id, id, id, id, id) = self.block;
    return block(obj1, obj2, obj3, obj4, obj5, obj6, obj7, obj8, obj9, obj10, obj11, obj12, obj13, obj14, obj15);
}

@end
