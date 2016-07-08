//
//  VZFNodeCreationInterface.h
//  VZFlexLayout
//
//  Created by moxin on 16/7/8.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol VZFNodeCreationAPI <NSObject>

+ (id)newWithProps:(id)props Store:(id)store Context:(id)context;

@end
