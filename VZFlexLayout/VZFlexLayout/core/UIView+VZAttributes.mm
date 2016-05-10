//
//  UIView+VZAttributes.m
//  O2OReact
//
//  Created by moxin on 16/4/29.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import "UIView+VZAttributes.h"
#import "VZFNodeInternal.h"
#import "VZFNodeViewManager.h"
#import "VZFNodeSpecs.h"
#import "VZFNodeViewClass.h"
#import "VZFButtonNode.h"
#import "VZFButtonNodeSpecs.h"
#import "VZFTextNode.h"
#import "VZFTextNodeSpecs.h"
#import "VZFImageNode.h"
#import "VZFImageNodeSpecs.h"
#import "VZFActionWrapper.h"
#import "VZFScrollNode.h"
#import "VZFScrollNodeSpecs.h"
#import <objc/runtime.h>

@implementation UIView (VZAttributes)

- (void)applyAttributes{

    VZFNode* node = self.node;
    
    const ViewAttrs vs = node.specs.view;
    
    [self _applyAttributes:vs];
    
    [self _applyGestures:node.specs.gesture];
    
    if ([node isKindOfClass:[VZFImageNode class]])
    {
        [self _applyImageAttributes:((VZFImageNode* )node).imageSpecs];
    }
    else if ([node isKindOfClass:[VZFButtonNode class]])
    {
        [self _applyButtonAttributes:((VZFButtonNode* )node).buttonSpecs];
    }
    else if ([node isKindOfClass:[VZFTextNode class]])
    {
        [self _applyTextAttributes:((VZFTextNode* )node).textSpecs];
    }
    else if ([node isKindOfClass:[VZFScrollNode class]]){
        [self _applyScrollAttributes:((VZFScrollNode* )node).scrollNodeSpecs];
    }
}

- (void)_applyAttributes:(const ViewAttrs&)vs {
    
    self.tag                    = vs.tag;
    self.backgroundColor        = vs.backgroundColor?:[UIColor clearColor];
    self.clipsToBounds          = vs.clip;
    self.hidden                 = vs.hidden;
    
    int userInteractionEnabled = vs.userInteractionEnabled;
    if (userInteractionEnabled != INT_MIN) {
        self.userInteractionEnabled = YES;
    }

    self.layer.cornerRadius     = vs.layer.cornerRadius;
    self.layer.borderColor      = vs.layer.borderColor.CGColor;
    self.layer.borderWidth      = vs.layer.borderWidth;
    if (vs.layer.contents.CGImage) {
        self.layer.contents     = (__bridge id)vs.layer.contents.CGImage;
    }
    
    if (vs.unapplicator) {
        vs.unapplicator(self);
    }
    
    if (vs.applicator) {
        vs.applicator(self);
    }

}


- (void)_applyGestures:(MultiMap<Class, ActionWrapper>)gestures{
    
    if (!gestures.empty()) {
        self.userInteractionEnabled = YES;
    }
    
    static const void* _id = &_id;
    // 移除重用的view上的recognizer
    [self.gestureRecognizers enumerateObjectsUsingBlock:^(__kindof UIGestureRecognizer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (objc_getAssociatedObject(obj, _id)) {
            [self removeGestureRecognizer:obj];
        }
    }];
    
    NSMutableArray *gestureArray = [NSMutableArray array];
    objc_setAssociatedObject(self, _id, gestureArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    for (auto iter=gestures.begin(); iter!=gestures.end(); iter=gestures.equal_range(iter->first).second){
        auto key = iter->first;
        UIGestureRecognizer *gestureRecognizer = [[key alloc] initWithTarget:nil action:nil];
        auto range = gestures.equal_range(key);
        for (auto it=range.first; it!=range.second; it++){
            id<VZFActionWrapper> wrapper = vz_actionWrapper(it->second);
            [gestureArray addObject:wrapper];
            [gestureRecognizer addTarget:wrapper action:@selector(invoke:)];
        }
        
        // 标记这个recognizer是根据nodeSpec生成的
        objc_setAssociatedObject(gestureRecognizer, _id, @YES, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self addGestureRecognizer:gestureRecognizer];
    }
}


- (void)_applyButtonAttributes:(const ButtonNodeSpecs& )buttonNodeSpecs{
    
    UIButton* btn = (UIButton* )self;
    
    btn.titleLabel.font = buttonNodeSpecs.getFont();
    
    for (auto title : buttonNodeSpecs.title) {
        [btn setTitle:title.second forState:title.first];
    }
    
    for (auto color : buttonNodeSpecs.titleColor) {
        [btn setTitleColor:color.second forState:color.first];
    }
    
    for (auto image : buttonNodeSpecs.backgroundImage) {
        [btn setBackgroundImage:image.second forState:image.first];
    }
    
    for (auto image : buttonNodeSpecs.image){
        [btn setImage:image.second forState:image.first];
    }
    
    [btn removeTarget:nil action:nil forControlEvents:UIControlEventAllEvents];
    static const void* _id = &_id;
    NSMutableArray * actionArray = objc_getAssociatedObject(btn, _id);
    if (actionArray == nil) {
        actionArray = [NSMutableArray array];
        objc_setAssociatedObject(btn, _id, actionArray, OBJC_ASSOCIATION_RETAIN);
    }
    for (auto action : buttonNodeSpecs.action) {
        id<VZFActionWrapper> wrapper = vz_actionWrapper(action.second);
        [actionArray addObject:wrapper];
        [btn addTarget:wrapper action:@selector(invoke:event:) forControlEvents:action.first];
    }
}

- (void)_applyTextAttributes:(const TextNodeSpecs& )textNodeSpecs{
    
    UILabel* label = (UILabel* )self;
    if (textNodeSpecs.attributedString) {
        label.attributedText = textNodeSpecs.attributedString;
    }
    else {
        label.text = textNodeSpecs.text;
        label.font = textNodeSpecs.getFont();
        label.textColor = textNodeSpecs.color;
    }
    label.textAlignment = textNodeSpecs.alignment;
    label.lineBreakMode = textNodeSpecs.lineBreakMode;
    label.numberOfLines = textNodeSpecs.lines;
}

- (void)_applyImageAttributes:(const ImageNodeSpecs& )imageSpec{
    
    UIImageView<VZFNetworkImageDownloadProtocol>* networkImageView = (UIImageView<VZFNetworkImageDownloadProtocol>* )self;
    networkImageView.image = imageSpec.image;
    networkImageView.contentMode = imageSpec.contentMode;
    
    if (imageSpec.imageUrl.length > 0) {
        //just call protocol
        [networkImageView vz_setImageWithURL:[NSURL URLWithString:imageSpec.imageUrl]
                                        size:self.bounds.size
                            placeholderImage:imageSpec.image
                                  errorImage:imageSpec.errorImage
                                     context:imageSpec.context
                             completionBlock:vz_actionWrapper(imageSpec.completion)];   
    }
    
}

- (void)_applyScrollAttributes:(const VZ::ScrollNodeSpecs& )scrollSpecs{
    
    UIScrollView* scrollView = (UIScrollView* )self;
    scrollView.scrollEnabled = scrollSpecs.scrollEnabled;
    scrollView.pagingEnabled = scrollSpecs.paging;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;

    UIScrollView* node = (UIScrollView* )scrollView.node;
    scrollView.contentSize = node.contentSize;
    [scrollView setNeedsLayout];
    
}

@end
