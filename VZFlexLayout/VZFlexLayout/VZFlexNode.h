//
//  VZFlexNode.h
//  VZFlexLayout
//
//  Created by moxin on 15/12/25.
//  Copyright © 2015年 Vizlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlexLayout.h"


@interface VZFlexNode : NSObject

//@property (nonatomic,strong,readonly) FlexNode* flexNode;
@property (nonatomic,assign,readonly) CGRect frame;
@property (nonatomic,strong,readonly) NSArray* childNodes;

@property (nonatomic,strong)NSString* name;
@property (nonatomic,assign) FlexDirection direction;
@property (nonatomic,assign) FlexAlign alignItems;
@property (nonatomic,assign) FlexAlign alignSelf;
@property (nonatomic,assign) FlexAlign alignContent;
@property (nonatomic,assign) FlexAlign justifyContent;
@property (nonatomic,assign) CGFloat flexBasis;
@property (nonatomic,assign) CGFloat flexGrow;
@property (nonatomic,assign) CGFloat flexShrink;
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,assign) CGFloat minWidth;
@property (nonatomic,assign) CGFloat minHeight;
@property (nonatomic,assign) CGFloat maxWidth;
@property (nonatomic,assign) CGFloat maxHeight;
@property (nonatomic,assign) CGFloat margin;
@property (nonatomic,assign) CGFloat marginTop;
@property (nonatomic,assign) CGFloat marginLeft;
@property (nonatomic,assign) CGFloat marginBottom;
@property (nonatomic,assign) CGFloat marginRight;
@property (nonatomic,assign) CGFloat padding;
@property (nonatomic,assign) CGFloat paddingTop;
@property (nonatomic,assign) CGFloat paddingLeft;
@property (nonatomic,assign) CGFloat paddingBottom;
@property (nonatomic,assign) CGFloat paddingRight;

- (void)layout:(CGSize)constrainedSize;
- (CGSize)sizeThatFits:(CGSize)constraintedSize;
- (void)renderRecursively;//for test only
- (void)addSubNode:(VZFlexNode* )node;
- (void)removeSubNode:(VZFlexNode* )node;


@end
