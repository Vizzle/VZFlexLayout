//
//  VZFNodeCreationRequireMethods.h
//  O2OReact
//
//  Created by moxin on 16/7/8.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VZFluxStore;
@protocol VZFNodeRequiredMethods <NSObject>

+ (id)newWithProps:(id)props Store:(VZFluxStore* )store Context:(id)ctx;

@end
