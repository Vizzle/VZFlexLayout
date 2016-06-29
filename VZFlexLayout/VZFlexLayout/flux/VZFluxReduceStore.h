//
//  VZFluxReduceStore.h
//  VZFlexLayout
//
//  Created by moxin on 16/6/29.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFluxStore.h"
#import "VZFluxStoreAbstractMethods.h"

@interface VZFluxReduceStore : VZFluxStore <VZFluxStoreAbstractMethods>

@property(nonatomic,strong,readonly) id state;

@end
