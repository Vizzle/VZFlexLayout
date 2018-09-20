//
//  PostItemStore.h
//  VZFlexlayout-Demo
//
//  Created by moxin on 9/19/18.
//  Copyright © 2018 Vizlab. All rights reserved.
//

#import "VZFluxStore.h"
#import "PostItem.h"

typedef NS_ENUM(NSUInteger,ACTION_ID){
    CHANGE_TITLE_COLOR,
    CHANGE_BODY_COLOR,
    EXPEND_TEXT,
    ALERT
};


@interface PostItemStore : VZFluxStore

@property(nonatomic,weak) PostItem* item;

@end
