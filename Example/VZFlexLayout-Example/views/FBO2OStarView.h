//
//  O2OStarView.h
//  O2O
//
//  Created by 凌万 on 15/4/15.
//  Copyright (c) 2015年 Alipay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <VZFlexLayout/VZFNodeBackingViewInterface.h>

typedef NS_ENUM(NSUInteger, FBO2OStarViewType) {
    FBO2OStarViewTypeForDisplay,  //只用来展示，不能点击打分或滑动打分
    FBO2OStarViewTypeTapAndPan,   //支持点击和滑动打分
};

typedef NS_ENUM(NSUInteger, FBO2OStarViewRound) {
    FBO2OStarViewRoundNo,     //不近似，直接用浮点的分数
    FBO2OStarViewRoundTo1,    //近似到1分，四舍五入
    FBO2OStarViewRoundToHalf, //近似到0.5分，0.1，0.2舍，0.3，0.4入
    
    //9.5版本新加近似规则
    //[3.9, 4.4] = 4
    //(4.4, 4.9) = 4.5
    //[4.9, 5]   = 5
//    O2OStarViewRoundNewRule,
    
    //另，Tap操作时只能精确到1，不支持0.5
};

@class FBO2OStarView;

@protocol FBO2OStarViewDelegate <NSObject>
@optional
- (void)starView:(FBO2OStarView *)starView scoreDidChange:(CGFloat)score;
- (void)panGestureEnded:(FBO2OStarView *)starView;
- (void)tapGestureEnded:(FBO2OStarView *)starView;
@end

@interface FBO2OStarView : UIView<VZFNodeBackingViewInterface>

/**
 *  Designated initializer
 *
 *  设置起点、星的宽度、星之间的间隔后按比例计算星的高度和整个starView的宽度和高度
 *  默认backgroundColor为白色，默认不近似
 *
 *  @return starView
 */
- (instancetype)initWithOrigin:(CGPoint)origin
                      viewType:(FBO2OStarViewType)viewType
                     starWidth:(CGFloat)starWidth
                    starMargin:(CGFloat)starMargin
                    starNumber:(NSInteger)starNumber;

- (instancetype)initWithFrame:(CGRect)frame
                     viewType:(FBO2OStarViewType)viewType;

- (instancetype)initWithFrame:(CGRect)frame;

/**
 *  在cell中计算控件高度用；如果starView已经初始化完可直接用starView.frame.size.height
 *  初始化时传入一个星的宽度，然后按照星星素材（宽93高96）等比计算控件高度，精确到0.5，该方法做一样的事情
 *
 *  @param starWidth 一个星星的宽度
 *
 *  @return starView的高度
 */
+ (CGFloat)starViewHeightFromStarWidth:(CGFloat)starWidth;

//9.5版本新加近似规则
//[3.9, 4.4] = 4
//(4.4, 4.9) = 4.5
//[4.9, 5]   = 5
//+ (CGFloat)scoreFromNewRoundRule:(CGFloat)originalScore;

@property (nonatomic, weak) id<FBO2OStarViewDelegate> delegate;

/**
 *  得分值，范围为0-starNumber，默认为0
 */
@property (nonatomic, assign) CGFloat score;

/**
 *  分值的近似规则，默认不近似。如果允许打分，点击时只能精确到1，滑动打分可以精确到0.5
 */
@property (nonatomic, assign) FBO2OStarViewRound roundRule;

/**
 *  从0到score的动画时间，允许动画的一般场景为进入新页面后展示分值时带动画
 */
@property (nonatomic, assign) CGFloat animationInterval;

@end
