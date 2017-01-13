//
//  FBContentNodeStore.h
//  VZFlexLayout
//
//  Created by moxin on 16/6/30.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFluxStore.h"

@interface FBContentNodeStore : VZFluxStore

@property(nonatomic,strong,readonly)NSArray* items;

- (void)addNewState;

- (id)initialStateAtIndex:(NSInteger)index;

@end
