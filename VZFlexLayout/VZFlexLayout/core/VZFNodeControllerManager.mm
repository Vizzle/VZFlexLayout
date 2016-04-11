//
//  VZFNodeControllerManager.m
//  VZFlexLayout
//
//  Created by moxin on 16/4/10.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFNodeControllerManager.h"
#import "VZFNodeController.h"
#import "VZFLocker.h"
#import "VZFMacros.h"
#import "VZFNode.h"


@implementation VZFNodeControllerManager{

    //维护一个全局的映射表:{ node class => controller class}
    NSMutableDictionary<NSString* , NSString* >* _controllerMap;
}

+ (instancetype)sharedInstance{
    
    static VZFNodeControllerManager* instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [VZFNodeControllerManager new];
    });
    return instance;
}

- (id)init{

    self = [super init];
    if (self) {
    
        _controllerMap = [NSMutableDictionary dictionary];
        
    }
    return self;
}

+ (Class)controllerClassForNodeClass:(Class) nodeClass
{
    if (nodeClass == [VZFNode class]) {
        return Nil;
    }
    
    static VZ::StaticMutex mutex = VZ_MUTEX_INITIALIZER; // protects cache
    VZ::StaticMutexLocker l(mutex);
    
    NSMutableDictionary<NSString* , NSString* >* map = [VZFNodeControllerManager sharedInstance] -> _controllerMap;

    NSString* nodeKey = NSStringFromClass(nodeClass);
    NSString* controllerClassString = map[nodeKey];
    if (!controllerClassString) {
        controllerClassString = [NSStringFromClass(nodeClass) stringByAppendingString:@"Controller"];
        map[nodeKey] = controllerClassString;
    }
    return NSClassFromString(controllerClassString);
}

+ (VZFNodeController* )controllerForNodeClass:(Class) clz{
    
    if (clz == [VZFNode class]) {
        return nil; //不创建VZFNodeController
    }
    
    Class controllerClass = [self controllerClassForNodeClass:clz];
    
    if (controllerClass) {
        
        VZFAssertTrue([controllerClass isSubclassOfClass:[VZFNodeController class]]);
        
        VZFNodeController* controller = [[controllerClass alloc] init];
    
        return controller;
    }
    else{
    
        return nil;
    }

}


@end
