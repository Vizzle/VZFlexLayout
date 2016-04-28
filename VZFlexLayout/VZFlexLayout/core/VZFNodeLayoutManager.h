//
//  VZFNodeLayoutManager.h
//  O2OReact
//
//  Created by moxin on 16/3/28.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import <UIKit/UIKit.h>

namespace VZ {
    class NodeLayout;
}
using namespace VZ;

@class VZFNode;
@interface VZFNodeLayoutManager : NSObject

+ (instancetype)sharedInstance;

- (NSSet<VZFNode*>* )layoutRootNode:(const NodeLayout& )layout
                        InContainer:(UIView* )container
                  WithPreviousNodes:(NSSet<VZFNode* >* )previousNodes
                       AndSuperNode:(VZFNode* )superNode
                            Context:(id)ctx;

- (void)unmountNodes:(NSSet<VZFNode* >* )nodes;

@end
