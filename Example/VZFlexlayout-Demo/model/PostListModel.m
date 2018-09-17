//
//  ListModel.m
//  VZFlexlayout-Demo
//
//  Created by Tao Xu on 9/17/18.
//  Copyright © 2018 Vizlab. All rights reserved.
//

#import "PostListModel.h"
#import "PostItem.h"

@implementation PostListModel

- (NSString *)methodName {
    
    return @"https://jsonplaceholder.typicode.com/posts/";
}

- (NSArray* )responseObjects:(id)JSON
{
    NSMutableArray* ret = [NSMutableArray new];
    for (NSDictionary* dict in JSON) {
        
        PostItem* item = [PostItem new];
//        [item autoKVCBinding:dict];
        item.title = dict[@"title"];
        item.body = dict[@"body"];
        CGSize containerSz = (CGSize){CGRectGetWidth([UIScreen mainScreen].bounds),CGFLOAT_MAX};
        [item updateModelWithConstrainedSize:containerSz context:nil];
        [ret addObject:item];
    }
    
    
    return [ret copy];
}



@end
