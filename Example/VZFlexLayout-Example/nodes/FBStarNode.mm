//
//  FBStarNode.m
//  VZFlexLayout
//
//  Created by moxin on 16/2/27.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "FBStarNode.h"
#import <VZFlexLayout/VZFNodeViewClass.h>
#import <VZFlexLayout/VZFNodeSpecs.h>
#import "FBO2OStarView.h"


//static O2OStarView* createStarView(NSNumber* score){
//
//
//};

@implementation FBStarNode

+ (instancetype)newWithScore:(float)score{

    VZFNode* starNode = [VZFNode newWithView:{^{
        
        FBO2OStarView* starView  = [[FBO2OStarView alloc] initWithOrigin:CGPointMake(0, 0) viewType:FBO2OStarViewTypeForDisplay starWidth:14 starMargin:2 starNumber:5];
        starView.score = score;
        return starView;
    
    },[NSString stringWithFormat:@"%.1f",score]} NodeSpecs:{
    
        .width = vzf_dim(100),
        .height = 20

    }];
    return [super newWithNode:starNode];

}

@end
