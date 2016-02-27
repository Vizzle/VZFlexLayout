//
//  FBStarNode.m
//  VZFlexLayout
//
//  Created by moxin on 16/2/27.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "FBStarNode.h"
#import "O2OStarView.h"


//static O2OStarView* createStarView(NSNumber* score){
//
//
//};

@implementation FBStarNode

+ (instancetype)newWithScore:(float)score{

    VZFNode* starNode = [VZFNode newWithView:{^{
        
        O2OStarView* starView  = [[O2OStarView alloc] initWithOrigin:CGPointMake(0, 0) viewType:O2OStarViewTypeForDisplay starWidth:14 starMargin:2 starNumber:5];
        starView.score = score;
        return starView;
    
    },@"O2OStarView"} NodeSpecs:{
    
        .flex = {
            .width = 100,
            .height = 20
        }
    }];
    return [super newWithNode:starNode];

}

@end
