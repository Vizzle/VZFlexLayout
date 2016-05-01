//
//  FBActionsNodeController.m
//  VZFlexLayout
//
//  Created by moxin on 16/3/20.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "FBActionNodesController.h"

@implementation FBActionNodesController


- (void)willUpdateNode{
    [super willUpdateNode];
    NSLog(@"%s\n",__PRETTY_FUNCTION__);
}
- (void)willMountNode{
    [super willMountNode];
        NSLog(@"%s\n",__PRETTY_FUNCTION__);
}
- (void)willRemountNode{
    [super willRemountNode];
        NSLog(@"%s\n",__PRETTY_FUNCTION__);
}
- (void)didUpdateNode{
    [super didUpdateNode];
        NSLog(@"%s\n",__PRETTY_FUNCTION__);

}
- (void)didRemountNode{
    [super didRemountNode];
        NSLog(@"%s\n",__PRETTY_FUNCTION__);
}

- (void)willUnmountNode {
    [super willUnmountNode];
        NSLog(@"%s\n",__PRETTY_FUNCTION__);
}
- (void)didUnmountNode{
    [super didUnmountNode];
        NSLog(@"%s\n",__PRETTY_FUNCTION__);
}

- (void)willReleaseBackingView{
    [super willReleaseBackingView];
        NSLog(@"%s\n",__PRETTY_FUNCTION__);
}
- (void)didAquireView{
    [super didAquireView];
        NSLog(@"%s\n",__PRETTY_FUNCTION__);
}

- (void)dealloc{

    NSLog(@"[%@]-->dealloc",self.class);
}

@end
