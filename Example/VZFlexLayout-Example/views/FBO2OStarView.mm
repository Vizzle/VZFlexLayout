//
//  FBO2OStarView.m
//  O2O
//
//  Created by 凌万 on 15/4/15.
//  Copyright (c) 2015年 Alipay. All rights reserved.
//

#import "FBO2OStarView.h"

#define FOREGROUND_STAR_IMAGE_NAME @"o2o_yellow_star"
#define BACKGROUND_STAR_IMAGE_NAME @"o2o_gray_star"
#define DEFALUT_STAR_NUMBER 5

@interface FBO2OStarView ()
@property (nonatomic, assign) FBO2OStarViewType viewType;
@property (nonatomic, strong) UIView *foregroundStarView;
@property (nonatomic, strong) UIView *backgroundStarView;
@property (nonatomic, assign) NSInteger numberOfStars;
@property (nonatomic, assign) CGFloat starWidth;
@property (nonatomic, assign) CGFloat starMargin;
@end

@implementation FBO2OStarView

# pragma mark - Initializer

- (instancetype)initWithOrigin:(CGPoint)origin
                      viewType:(FBO2OStarViewType)viewType
                     starWidth:(CGFloat)starWidth
                    starMargin:(CGFloat)starMargin
                    starNumber:(NSInteger)starNumber {
    UIImage *singleStar = [UIImage imageNamed:FOREGROUND_STAR_IMAGE_NAME];
    CGFloat starHeight = singleStar.size.height / singleStar.size.width * starWidth;
    starHeight = round(starHeight * 2) / 2.f; //精确到0.5
    CGRect frame = CGRectMake(origin.x, origin.y, starWidth * starNumber + starMargin * (starNumber - 1), starHeight);
    if (self = [super initWithFrame:frame]) {
        _viewType = viewType;
        _starWidth = starWidth;
        _starMargin = starMargin;
        _numberOfStars = starNumber;
        
        self.foregroundStarView = [self createStarViewWithImage:FOREGROUND_STAR_IMAGE_NAME];
        self.foregroundStarView.frame = CGRectMake(0, 0, 0, self.bounds.size.height);
        self.backgroundStarView = [self createStarViewWithImage:BACKGROUND_STAR_IMAGE_NAME];
        
        [self addSubview:self.backgroundStarView];
        [self addSubview:self.foregroundStarView];
        
        if (self.viewType == FBO2OStarViewTypeTapAndPan) {
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
            [self addGestureRecognizer:tapGesture];
            
            UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
            [self addGestureRecognizer:panGesture];
        }
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
                     viewType:(FBO2OStarViewType)viewType {
    return [self initWithOrigin:frame.origin viewType:viewType starWidth:20 starMargin:3 starNumber:DEFALUT_STAR_NUMBER];
}

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame viewType:FBO2OStarViewTypeForDisplay];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    __weak FBO2OStarView *weakSelf = self;
    [UIView animateWithDuration:self.animationInterval animations:^{
        BOOL hasPoint5 = ((NSInteger)(self.score * 10) % 10 == 5);
        if (self.roundRule == FBO2OStarViewRoundToHalf && hasPoint5) {
            CGFloat width = (self.starWidth + self.starMargin) * (self.score - 0.5) + self.starWidth * 0.5;
            weakSelf.foregroundStarView.frame = CGRectMake(0, 0, width, weakSelf.bounds.size.height);
        } else {
            weakSelf.foregroundStarView.frame = CGRectMake(0, 0, (self.starWidth + self.starMargin) * self.score, weakSelf.bounds.size.height);
        }
    }];
}

# pragma mark - Public Methods

+ (CGFloat)starViewHeightFromStarWidth:(CGFloat)starWidth {
    UIImage *singleStar = [UIImage imageNamed:FOREGROUND_STAR_IMAGE_NAME];
    CGFloat starHeight = singleStar.size.height / singleStar.size.width * starWidth;
    starHeight = round(starHeight * 2) / 2.f; //精确到0.5
    
    return starHeight;
}

//+ (CGFloat)scoreFromNewRoundRule:(CGFloat)originalScore {
//    CGFloat formattedScore = 0;
//    NSInteger decimal = (NSInteger)(originalScore * 10) % 10;
//    if (decimal == 9) {
//        formattedScore = ceil(originalScore);
//    } else if (decimal <= 4) {
//        formattedScore = floor(originalScore);
//    } else if (decimal > 4) { //必定<9
//        formattedScore = originalScore - (double)decimal / 10 + 0.5;
//    }
//    
//    return formattedScore;
//}

# pragma mark - Private Methods

- (UIView *)createStarViewWithImage:(NSString *)imageName {
    UIView *view = [[UIView alloc] initWithFrame:self.bounds];
    view.backgroundColor = self.backgroundColor;
    view.clipsToBounds = YES;
    for (NSInteger i = 0; i < self.numberOfStars; i ++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        imageView.frame = CGRectMake(i * (self.starWidth + self.starMargin), 0, self.starWidth, self.bounds.size.height);
        imageView.contentMode = UIViewContentModeScaleToFill;
        [view addSubview:imageView];
    }
    
    return view;
}

- (void)handleTap:(UITapGestureRecognizer *)gesture {
    CGPoint tapPoint = [gesture locationInView:self];
    NSInteger index = 0;
    BOOL indexValid = NO;
    for (UIView *image in [self.backgroundStarView subviews]) {
        index++;
        if(CGRectContainsPoint(image.frame, tapPoint)) {
            indexValid = YES;
            break;
        }
    }
    
    if (index > 0 && indexValid) {
        [self setScore:index];
        
        if(gesture.state == UIGestureRecognizerStateEnded) {
            if ([self.delegate respondsToSelector:@selector(tapGestureEnded:)]) {
                [self.delegate tapGestureEnded:self];
                return;
            }
        }
    }
}

- (void)handlePan:(UIPanGestureRecognizer *)panGesture {
    CGPoint point = [panGesture locationInView:self];
    
    //不允许pan到starView外面
    if (!CGRectContainsPoint(CGRectMake(0, 0, self.frame.size.width, self.frame.size.height), point)) {
        return;
    }
    
    CGFloat floatScore = point.x / (self.starWidth + self.starMargin);
    [self setScore:[self formatScore:floatScore]];
    
    if(panGesture.state == UIGestureRecognizerStateEnded) {
        if ([self.delegate respondsToSelector:@selector(panGestureEnded:)]) {
            [self.delegate panGestureEnded:self];
            return;
        }
    }
}

- (CGFloat)formatScore:(CGFloat)originalScore {
    switch (self.roundRule) {
        case FBO2OStarViewRoundNo:
            return originalScore;
            
        case FBO2OStarViewRoundTo1:
            return round(originalScore);
            
        case FBO2OStarViewRoundToHalf:
            return round(originalScore * 2) / 2.f;
            
//        case FBO2OStarViewRoundNewRule:
//        {
//            return [self.class scoreFromNewRoundRule:originalScore];
//        }
    }
}

# pragma mark - Setter

- (void)setScore:(CGFloat)score {
    if (_score == score) {
        return;
    }
    
    if (score < 0) {
        _score = 0;
    } else if (score > self.numberOfStars) {
        _score = self.numberOfStars;
    } else {
        _score = [self formatScore:score];
    }
    
    if ([self.delegate respondsToSelector:@selector(starView:scoreDidChange:)]) {
        [self.delegate starView:self scoreDidChange:score];
    }
    
    [self setNeedsLayout];
}

- (void)born{
    NSLog(@"%s",__PRETTY_FUNCTION__);
}
- (void)dead{
    NSLog(@"%s",__PRETTY_FUNCTION__);
}
- (void)resetState{
    NSLog(@"%s",__PRETTY_FUNCTION__);
}
- (void)prepareForReuse{
    NSLog(@"%s",__PRETTY_FUNCTION__);
}
- (void)willEnterReusePool{
    NSLog(@"%s",__PRETTY_FUNCTION__);
}
- (void)didLeaveReusePool{
    NSLog(@"%s",__PRETTY_FUNCTION__);

}

@end
