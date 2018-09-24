//
//  PostListContext.h
//  VZFlexlayout-Demo
//
//  Created by moxin on 9/19/18.
//  Copyright © 2018 Vizlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class VZListViewController;
@class VZFluxDispatcher;
@class VZFluxStore;

@interface PostListContext : NSObject

- (id)initWithRootViewController:(UIViewController* )vc FluxStore:(VZFluxStore* )store;


+ (instancetype)sharedInstance;

- (void)setRootViewController:(VZListViewController* )controller;

+ (VZFluxDispatcher* )globalDispatcher;
+ (VZListViewController* )globalController;
+ (UITableView* )globalTableView;

@end
