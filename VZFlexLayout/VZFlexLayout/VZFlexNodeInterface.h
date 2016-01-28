//
//  VZFlexNodeInterface.h
//  VZFlexLayout
//
//  Created by moxin on 16/1/27.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifdef __cplusplus
extern "C" {
#endif
    
#import "FlexLayout.h"
    
#ifdef __cplusplus
}
#endif


@protocol VZFlexNodeInterface <NSObject>

@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property (nonatomic) CGFloat minWidth;
@property (nonatomic) CGFloat minHeight;
@property (nonatomic) CGFloat maxWidth;
@property (nonatomic) CGFloat maxHeight;
@property (nonatomic) CGFloat margin;
@property (nonatomic) CGFloat marginTop;
@property (nonatomic) CGFloat marginLeft;
@property (nonatomic) CGFloat marginBottom;
@property (nonatomic) CGFloat marginRight;
@property (nonatomic) CGFloat padding;
@property (nonatomic) CGFloat paddingTop;
@property (nonatomic) CGFloat paddingLeft;
@property (nonatomic) CGFloat paddingBottom;
@property (nonatomic) CGFloat paddingRight;
@property (nonatomic) CGFloat borderWidth;
@property (nonatomic) CGFloat spacing;
@property (nonatomic) CGFloat lineSpacing;


@end
