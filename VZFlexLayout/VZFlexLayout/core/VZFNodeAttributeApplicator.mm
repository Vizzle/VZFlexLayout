//
//  VZFNodeAttributeApplicator.m
//  O2OReact
//
//  Created by moxin on 16/4/1.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import "VZFNodeAttributeApplicator.h"
#import "VZFNode.h"
#import "VZFNodeInternal.h"
#import "VZFCompositeNode.h"
#import "VZFImageNode.h"
#import "VZFNetworkImageNode.h"
#import "VZFButtonNode.h"
#import "VZFTextNode.h"
#import "VZFNodeSpecs.h"
#import "VZFNetworkImageView.h"
#import "VZFTextNodeSpecs.h"
#import "VZFImageNodeSpecs.h"
#import "VZFButtonNodeSpecs.h"



using namespace VZ;
@implementation VZFNodeAttributeApplicator

+ (void)applyNodeAttributes:(VZFNode* )node toView:(UIView* )view{

    const ViewAttrs vs = node.specs.view;
    [self _applyAttributes:vs ToUIView:view];
    [self _applyGestures:node.specs.gesture ToUIView:view];

    if ([node isKindOfClass:[VZFImageNode class]]) {
        VZFImageNode* imageNode = (VZFImageNode* )node;
        [self _applyImageAttributes:imageNode.imageSpecs ToImageView:(UIImageView* )view];
    }
    else if ([node isKindOfClass:[VZFButtonNode class]]){
        
        VZFButtonNode* buttonNdoe = (VZFButtonNode* )node;
        [self _applyButtonAttributes:buttonNdoe.buttonSpecs ToUIButton:(UIButton* )view];
    }
    else if ([node isKindOfClass:[VZFTextNode class]]){
        
        VZFTextNode* textNode = (VZFTextNode* )node;
        [self _applyTextAttributes:textNode.textSpecs ToUILabel:(UILabel* )view];
    }
    else if([node isKindOfClass:[VZFNetworkImageNode class]]){
        VZFNetworkImageNode* networkImageNode = (VZFNetworkImageNode* )node;
        
        [self _appleyNetworkImageAttributes:networkImageNode ToNetworkImageView:(VZFNetworkImageView* )view];
    }
}


+ (void)_applyAttributes:(const ViewAttrs&)vs ToUIView:(UIView* )view {
    
    view.tag                    = vs.tag;
    view.backgroundColor        = vs.backgroundColor?:[UIColor clearColor];
    view.clipsToBounds          = vs.clipsToBounds;
    view.layer.cornerRadius     = vs.layer.cornerRadius;
    view.layer.borderColor      = vs.layer.borderColor.CGColor;
    if (vs.layer.contents.CGImage) {
        view.layer.contents     = (__bridge id)vs.layer.contents.CGImage;
    }
    
    if (vs.block) {
        vs.block(view);
    }
    
 
}


+ (void)_applyGestures:(MultiMap<Class, ActionWrapper>)gestures ToUIView:(UIView* )view{
    [view.gestureRecognizers enumerateObjectsUsingBlock:^(__kindof UIGestureRecognizer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj conformsToProtocol:@protocol(VZFActionWrapper)]) {
            [view removeGestureRecognizer:obj];
        }
    }];
    static const void* _id = &_id;
    NSMutableArray *gestureArray = [NSMutableArray array];
    objc_setAssociatedObject(view, _id, gestureArray, OBJC_ASSOCIATION_RETAIN);
    for (auto iter=gestures.begin(); iter!=gestures.end(); iter=gestures.equal_range(iter->first).second){
        auto key = iter->first;
        UIGestureRecognizer *gestureRecognizer = [[key alloc] initWithTarget:nil action:nil];
        auto range = gestures.equal_range(key);
        for (auto it=range.first; it!=range.second; it++){
            id<VZFActionWrapper> wrapper = vz_actionWrapper(it->second);
            [gestureArray addObject:wrapper];
            [gestureRecognizer addTarget:wrapper action:@selector(invoke:)];
        }
        [view addGestureRecognizer:gestureRecognizer];
    }
}

+ (void)_applyImageAttributes:(const ImageNodeSpecs& )imageNodeSpecs ToImageView:(UIImageView* )imageView{
    
    imageView.image = imageNodeSpecs.image;
    imageView.contentMode = imageNodeSpecs.contentMode;
    
}

+ (void)_applyButtonAttributes:(const ButtonNodeSpecs& )buttonNodeSpecs ToUIButton:(UIButton* )btn{
    btn.titleLabel.font = buttonNodeSpecs.font;
    
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

+ (void)_applyTextAttributes:(const TextNodeSpecs& )textNodeSpecs ToUILabel:(UILabel* )label{
    
    if (textNodeSpecs.attributedString) {
        label.attributedText = textNodeSpecs.attributedString;
    }
    else {
        label.text = textNodeSpecs.text;
        label.font = textNodeSpecs.font;
        label.textColor = textNodeSpecs.color;
    }
    label.textAlignment = textNodeSpecs.textAlignment;
    label.lineBreakMode = textNodeSpecs.lineBreakMode;
    label.numberOfLines = textNodeSpecs.maximumNumberOfLines;
}

+ (void)_appleyNetworkImageAttributes:(VZFNetworkImageNode* )node ToNetworkImageView:(VZFNetworkImageView* )networkImageView{
    
    
    ImageNodeSpecs imageSpec = node.imageSpecs;
    NSURL* url = imageSpec.url;
    id<VZFNetworkImageDownloadProtocol> imageDownloader = node.imageDownloader;
    UIImage*(^block)(UIImage* ) = node.imageProcessingBlock;
    
    VZFNetworkImageSpec* spec = [[VZFNetworkImageSpec alloc]initWithURL:url defaultImage:imageSpec.image imageProcessingFunc:block imageDownloader:imageDownloader];
    [networkImageView setSpec:spec];
    
}


@end
