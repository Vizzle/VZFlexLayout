//
//  PostListContext.h
//  VZFlexlayout-Demo
//
//  Created by moxin on 9/19/18.
//  Copyright © 2018 Vizlab. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VZListViewController;
@class VZFluxDispatcher;
@interface PostListContext : NSObject

+ (instancetype)sharedInstance;

- (void)setRootViewController:(VZListViewController* )controller;

+ (VZFluxDispatcher* )globalDispatcher;
+ (VZListViewController* )globalController;
+ (UITableView* )globalTableView;

@end
