//
//  VZFluxEventSubscription.h
//  VZFlexLayout
//
//  Created by moxin on 16/6/28.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^VZFluxEventListener)(NSString* eventType, id data);

@class VZFluxEventSubscriber;
@interface VZFluxEventSubscription : NSObject

@property(nonatomic,weak,readonly) VZFluxEventSubscriber* subscriber;
@property(nonatomic,assign)NSUInteger key;
@property(nonatomic,strong)NSString* eventType;

- (id)initWithSubscriber:(VZFluxEventSubscriber* )subscriber;

- (void)remove;

@end


@interface VZFluxEmitterSubscription : VZFluxEventSubscription

@property(nonatomic,copy)VZFluxEventListener listener;
@property(nonatomic,strong)id context;

- (id)initWithSubscriber:(VZFluxEventSubscriber *)subscriber Listener:(VZFluxEventListener)listener Context:(id)context;

@end