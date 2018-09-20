//
//  PostListContext.m
//  VZFlexlayout-Demo
//
//  Created by moxin on 9/19/18.
//  Copyright © 2018 Vizlab. All rights reserved.
//

#import "PostListContext.h"
#import "VZFluxDispatcher.h"
#import "VZFluxAction.h"
#import "PostListModel.h"
#import "PostItem.h"
#import "PostItemStore.h"

@implementation PostListContext{
    __weak VZListViewController* _viewController;
    __strong VZFluxDispatcher* _dispatcher;
}

+ (instancetype)sharedInstance{
    static PostListContext* instance = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        instance = [PostListContext new];
    });
    return instance;
}
- (id)init{
    self = [super init];
    if(self){
        _dispatcher = [VZFluxDispatcher new];
        [_dispatcher registerWithCallback:^(VZ::FluxAction action) {
            if(action.eventId == CHANGE_BODY_COLOR){
                NSUInteger index = [action.payload[@"index"] integerValue];
                NSArray* postItems = _viewController.keyModel.objects;
                if(index >= postItems.count){
                    index = index - postItems.count;
                }
                PostItem* item = postItems[index];
                action.actionType = ActionType::state;
                [item.store onDispatch:action];
            }
        }];
    }
    return self;
}

- (void)setRootViewController:(VZListViewController* )controller{
    _viewController = controller;
}

+ (VZFluxDispatcher* )globalDispatcher{
    PostListContext* context = [self sharedInstance];
    return context->_dispatcher;
}
+ (VZListViewController* )globalController{
    PostListContext* context = [self sharedInstance];
    return context->_viewController;
}
+ (UITableView* )globalTableView{
    PostListContext* context = [self sharedInstance];
    return context->_viewController.tableView;
}

@end
