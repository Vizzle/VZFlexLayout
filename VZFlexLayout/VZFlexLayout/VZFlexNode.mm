//
//  VZFlexNode.m
//  VZFlexLayout
//
//  Created by moxin on 15/12/25.
//  Copyright © 2015年 Vizlab. All rights reserved.
//

#import "VZFlexNode.h"
#import "Layout.h"



@interface VZFlexNode()
{
    css_node_t* _css_node;
    NSMutableArray* _childNodes;

}

@property(nonatomic,strong)UIView* internalView;

@end

@implementation VZFlexNode


bool vz_flexnode_is_dirty(void* _this){
    return true;
}

css_node_t* vz_flexnode_child_at_index(void* _this, int i){
    VZFlexNode* node = (__bridge VZFlexNode* )_this;
    if (i<node.childNodes.count) {
        VZFlexNode* childNode = node.childNodes[i];
        return childNode -> _css_node;
    }
    else{
        return NULL;
    }
    
}

css_dim_t vz_flexnode_measure(void* _this, float width)
{
    VZFlexNode* node = (__bridge VZFlexNode* )_this;
    if (node.measureBlock) {
        CGSize sz = node.measureBlock(width);
        css_dim_t ret;
        ret.dimensions[CSS_WIDTH] = sz.width;
        ret.dimensions[CSS_HEIGHT] = sz.height;
        return ret;
    }
    else{
        return (css_dim_t){};
    }
    
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - getters

- (UIView* )internalView{
    if (!_internalView) {
        _internalView = [[UIView alloc]initWithFrame:CGRectZero];
        UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 14)];
        label.tag = 100;
        label.text = @"";
        label.font = [UIFont systemFontOfSize:12.0f];
        [_internalView addSubview:label];
    }
    return _internalView;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - setters

- (void)setSize:(CGSize)size{
    _size = size;
    _css_node -> style.dimensions[CSS_WIDTH] = size.width;
    _css_node -> style.dimensions[CSS_HEIGHT] = size.height;
}

- (void)setPosition:(CGPoint)position{
    _position = position;
    _css_node -> style.dimensions[CSS_LEFT] = position.x;
    _css_node -> style.dimensions[CSS_TOP] = position.y;
}

- (void)setMargin:(UIEdgeInsets)margin
{
    _margin = margin;
    _css_node->style.margin[CSS_LEFT] = margin.left;
    _css_node->style.margin[CSS_TOP] = margin.top;
    _css_node->style.margin[CSS_RIGHT] = margin.right;
    _css_node->style.margin[CSS_BOTTOM] = margin.bottom;
}

- (void)setPadding:(UIEdgeInsets)padding
{
    _padding = padding;
    _css_node->style.padding[CSS_LEFT] = padding.left;
    _css_node->style.padding[CSS_TOP] = padding.top;
    _css_node->style.padding[CSS_RIGHT] = padding.right;
    _css_node->style.padding[CSS_BOTTOM] = padding.bottom;
}


- (void)setFlexValue:(VZFlexNodeFlexValue)flexValue{

    _flexValue = flexValue;
    _css_node -> style.flex = flexValue;
}

- (void)setJustifyContent:(VZFlexNodeJustifyContent)justifyContent
{
    _justifyContent = justifyContent;
    _css_node->style.justify_content = (css_justify_t)justifyContent;
}

- (void)setFlexDirection:(VZFlexNodeDirection)flexDirection{
    _flexDirection = flexDirection;
    _css_node ->style.flex_direction = (css_flex_direction_t)flexDirection;
}

- (void)setAlignContent:(VZFlexNodeAlignContent)alignContent{
    _alignContent = alignContent;
    _css_node ->style.align_content = (css_align_t)alignContent;
}

- (void)setAlignItems:(VZFlexNodeAlignItems)alignItems{
    _alignItems = alignItems;
    _css_node -> style.align_items = (css_align_t)alignItems;
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - life cycle

- (NSString* )description{
    return self.name;
}

- (id)init
{
    self = [super init];
    if (self) {
        
        _css_node = new_css_node();
        _css_node -> measure = vz_flexnode_measure;
        _css_node -> context = (__bridge void*)self;
        _css_node -> is_dirty = vz_flexnode_is_dirty;
        _css_node -> get_child = vz_flexnode_child_at_index;
        
        _flexDirection  = VZFLEX_DIRECTION_ROW;
        _alignItems     = VZFLEX_ALIGN_ITEMS_START;
        _alignSelf      = VZFLEX_ALIGN_SELF_STRETCH;
        _alignContent   = VZFLEX_ALIGN_CONTENT_START;
        _justifyContent = VZFLEX_JC_START;
        _margin = UIEdgeInsetsZero;
        _padding = UIEdgeInsetsZero;
        _childNodes = [NSMutableArray new];
        
    }
    return self;
}

- (void)dealloc{
    
    free(_css_node);
    _css_node = NULL;
}

- (CGRect)frame
{
    return (CGRect) {
        .origin.x = _css_node->layout.position[CSS_LEFT],
        .origin.y = _css_node->layout.position[CSS_TOP],
        .size.width = _css_node->layout.dimensions[CSS_WIDTH],
        .size.height = _css_node->layout.dimensions[CSS_HEIGHT]
    };
}


- (void)prepareLayout
{
    for(VZFlexNode* node in self.childNodes)
    {
        [node prepareLayout];
    }
    
    _css_node ->layout.position[CSS_LEFT] = 0;
    _css_node ->layout.position[CSS_TOP] = 0;
    _css_node ->layout.dimensions[CSS_WIDTH] = CSS_UNDEFINED;
    _css_node ->layout.dimensions[CSS_HEIGHT] = CSS_UNDEFINED;
    
}

- (void)layout:(CGFloat)width{

    //prepare layout递归
    [self prepareLayout];
    

    layoutNode(_css_node, width, CSS_DIRECTION_LTR);
}

- (void)renderRecursively
{
    for (VZFlexNode* node in self.childNodes) {
        [node renderRecursively];
    }
    [self render];
}

- (UIView* )view{
    return _internalView;
}

- (void)render{

    self.internalView.frame = [self frame];
    UILabel* label = [self.internalView viewWithTag:100];
    label.text = self.name;
    self.internalView.backgroundColor = [UIColor colorWithRed:(arc4random()%255)/255.0
                                                        green:(arc4random()%255)/255.0
                                                         blue:(arc4random()%255)/255.0 alpha:1.0];

    for(VZFlexNode* node in self.childNodes)
    {
        [self.internalView addSubview:node.internalView];
        
    }
}



- (void)addSubNode:(VZFlexNode* )node{
    
    
    [_childNodes addObject:node];
    _css_node -> children_count = (int)self.childNodes.count;
}

- (void)removeSubNode:(VZFlexNode* )node{
    
    [_childNodes removeObject:node];
    _css_node -> children_count = (int)self.childNodes.count;

}

@end
