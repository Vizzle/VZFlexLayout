//
//  VZFNodeViewManager.h
//  VZFlexLayout
//
//  Created by moxin on 16/1/30.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <UIKit/UIKit.h>

namespace VZ {
    class NodeLayout;
}
using namespace VZ;
@class VZFNode;
@interface VZFNodeViewManager : NSObject

@property(nonatomic,weak,readonly)UIView* managedView;

- (instancetype)initWithView:(UIView* )view;

- (UIView* )viewForNode:(VZFNode* )node;

@end


@interface UIView(VZFNode)

@property(nonatomic,weak) VZFNode* node;

@end




@interface VZFNodeViewKey : NSObject

@property(nonatomic,strong,readonly)Class nodeClass;
@property(nonatomic,strong,readonly)NSString* identifier;

+ (VZFNodeViewKey* )viewKeyForNodeClass:(Class)nodeClass
                             Identifier:(NSString* )identifier;

@end