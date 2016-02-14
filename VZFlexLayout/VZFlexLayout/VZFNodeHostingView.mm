//
//  VZFNodeHostingView.m
//  VZFlexLayout
//
//  Created by moxin on 16/1/28.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFNodeHostingView.h"
#import "VZFMacros.h"

@interface VZFNodeHostingView()
{
    Class<VZFNodeProviderInterface> _nodeProvider;
    UIView* _containerView;
}

@end

@implementation VZFNodeHostingView

- (id)initWithFrame:(CGRect)frame{
    VZ_NOT_DESIGNATED_INITIALIZER();
}

- (id)initWithNodeProvider:(Class<VZFNodeProviderInterface>)provider{

    self = [super init];
    if (self) {
        _nodeProvider = provider;
        
        
        
    }
    return self;
}



@end
