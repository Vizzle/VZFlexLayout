//
//  VZFlexNode.m
//  VZFlexLayout
//
//  Created by moxin on 15/12/25.
//  Copyright © 2015年 Vizlab. All rights reserved.
//

#import "VZFlexNode.h"
#import "Layout.h"


#import "FlexLayout.h"
//
//static const FlexNode* defaultFlexNode() {
//    
//    static dispatch_once_t onceToken;
//    static FlexNode node;
//    dispatch_once(&onceToken, ^{
//        initFlexNode(&node);
//    });
//    return &node;
//}
//
//
//
//static inline NSString *floatToNSString(float value) {
//    if (value == FlexAuto) {
//        return @"auto";
//    }
//    else if (value == FlexContent) {
//        return @"content";
//    }
//    else if (value == FlexUndefined) {
//        return @"undefined";
//    }
//    else if (value == FlexInfinite) {
//        return @"infinite";
//    }
//    
//    NSString *s = [NSString stringWithFormat:@"%f", value];
//    int i = (int)s.length - 1;
//    for (;i>=0;i--) {
//        if ([s characterAtIndex:i] != '0') {
//            break;
//        }
//    }
//    if (i >= 0 && [s characterAtIndex:i] == '.') i--;
//    return [s substringToIndex:i + 1];
//}
//
//static inline NSString *alignToNSString(FlexAlign align) {
//    switch (align) {
//        case FlexInherit:
//            return @"auto";
//        case FlexStretch:
//            return @"stretch";
//        case FlexStart:
//            return @"flex-start";
//        case FlexCenter:
//            return @"center";
//        case FlexEnd:
//            return @"flex-end";
//        case FlexSpaceBetween:
//            return @"space-between";
//        case FlexSpaceAround:
//            return @"space-around";
//    }
//}
//


@interface VZFlexNode()
{
    css_node_t* _css_node;
    FlexNode* _flex_node;
    NSMutableArray* _childNodes;

}

@property(nonatomic,strong)UIView* internalView;

@end

@implementation VZFlexNode


bool vz_css_node_is_dirty(void* _this){
    return true;
}

css_node_t* vz_css_node_child_at_index(void* _this, int i){
    VZFlexNode* node = (__bridge VZFlexNode* )_this;
    if (i<node.childNodes.count) {
        VZFlexNode* childNode = node.childNodes[i];
        return childNode -> _css_node;
    }
    else{
        return NULL;
    }
    
}

css_dim_t vz_css_node_measure(void* _this, float width)
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

FlexSize flexNodeMeasure(void* context, FlexSize constraintedSize) {
    VZFlexNode* node = (__bridge VZFlexNode*)context;
    CGSize size = [node sizeThatFits:CGSizeMake(constraintedSize.size[FLEX_WIDTH], constraintedSize.size[FLEX_HEIGHT])];
    FlexSize ret;
    ret.size[FLEX_WIDTH] = size.width;
    ret.size[FLEX_HEIGHT] = size.height;
    return ret;
}

FlexNode* flexNodeChildAt(void* context, int index) {
    VZFlexNode* node = (__bridge VZFlexNode*)context;
    VZFlexNode* child = node.childNodes[index];
    return child -> _flex_node;
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

- (void)setWrap:(BOOL)wrap{
    _wrap = wrap;
    _flex_node -> wrap = wrap;
}

- (void)setFixed:(BOOL)fixed{
    _fixed = fixed;
    _flex_node -> fixed = fixed;
}

- (void)setMaxSize:(CGSize)maxSize{
    _maxSize = maxSize;
    _flex_node -> maxSize[FLEX_WIDTH] = maxSize.width;
    _flex_node -> maxSize[FLEX_HEIGHT] = maxSize.height;
}

- (void)setMinSize:(CGSize)minSize{
    _minSize = minSize;
    _flex_node -> minSize[FLEX_WIDTH] = minSize.width;
    _flex_node -> maxSize[FLEX_HEIGHT] = minSize.height;
}

- (void)setSize:(CGSize)size{
    _size = size;
    _flex_node -> size[FLEX_WIDTH] = size.width;
    _flex_node -> size[FLEX_HEIGHT] = size.height;
}

- (void)setMargin:(UIEdgeInsets)margin
{
    _margin = margin;
    
    _flex_node -> margin[FLEX_LEFT] = margin.left;
    _flex_node -> margin[FLEX_TOP] = margin.top;
    _flex_node -> margin[FLEX_RIGHT] = margin.right;
    _flex_node -> margin[FLEX_BOTTOM] = margin.bottom;
    
//    _css_node->style.margin[CSS_LEFT] = margin.left;
//    _css_node->style.margin[CSS_TOP] = margin.top;
//    _css_node->style.margin[CSS_RIGHT] = margin.right;
//    _css_node->style.margin[CSS_BOTTOM] = margin.bottom;
}

- (void)setPadding:(UIEdgeInsets)padding
{
    _padding = padding;
    
    _flex_node -> padding[FLEX_LEFT] = padding.left;
    _flex_node -> padding[FLEX_TOP] = padding.top;
    _flex_node -> padding[FLEX_RIGHT] = padding.right;
    _flex_node -> padding[FLEX_BOTTOM] = padding.bottom;
    
//    _css_node->style.padding[CSS_LEFT] = padding.left;
//    _css_node->style.padding[CSS_TOP] = padding.top;
//    _css_node->style.padding[CSS_RIGHT] = padding.right;
//    _css_node->style.padding[CSS_BOTTOM] = padding.bottom;
}


- (void)setFlexGrow:(VZFlexNodeFlexValue)flexGrow{

    _flexGrow = flexGrow;
//    _css_node -> style.flex = flexGrow;
    _flex_node -> flexGrow = flexGrow;
}

- (void)setFlexShrink:(VZFlexNodeFlexValue)flexShrink{
    _flexShrink = flexShrink;
    _flex_node -> flexShrink = flexShrink;
}

- (void)setJustifyContent:(VZFlexNodeJustifyContent)justifyContent
{
    _justifyContent = justifyContent;
//    _css_node->style.justify_content = (css_justify_t)justifyContent;
    

    FlexAlign value = FlexInherit;
    switch (justifyContent) {
        case VZFLEX_JC_START:
            value = FlexStart;
            break;
        case VZFLEX_JC_CENTER:
            value = FlexCenter;
            break;
        case VZFLEX_JC_END:
            value = FlexEnd;
            break;
        case VZFLEX_JC_SPACE_AROUND:
            value = FlexSpaceAround;
            break;
            
        case VZFLEX_JC_SPACE_BETWEEN:
            value = FlexSpaceBetween;
            break;
            
        default:
            break;
    }
    
    _flex_node -> justifyContent = value;
}

- (void)setFlexDirection:(VZFlexNodeDirection)flexDirection{
    _flexDirection = flexDirection;
//    _css_node ->style.flex_direction = (css_flex_direction_t)flexDirection;
    _flex_node -> direction = (FlexDirection)flexDirection;
}

- (void)setAlignSelf:(VZFlexNodeAlignSelf)alignSelf{
    _alignSelf = alignSelf;
    
    FlexAlign value = FlexStretch;
    
    switch (alignSelf) {
        case VZFLEX_ALIGN_CONTENT_START:
            value = FlexStart;
            break;
            
        case VZFLEX_ALIGN_CONTENT_CENTER:
            value = FlexCenter;
            break;
            
        case VZFLEX_ALIGN_CONTENT_END:
            value = FlexEnd;
            break;
            
        case VZFLEX_ALIGN_CONTENT_STRETCH:
            value = FlexStretch;
            break;
            
        default:
            break;
    }

    
    _flex_node -> alignSelf = value;
}

- (void)setAlignContent:(VZFlexNodeAlignContent)alignContent{
    _alignContent = alignContent;
//    _css_node ->style.align_content = (css_align_t)alignContent;
    

    FlexAlign value = FlexStretch;
    switch (alignContent) {
        case VZFLEX_ALIGN_CONTENT_START:
            value = FlexStart;
            break;
            
        case VZFLEX_ALIGN_CONTENT_CENTER:
            value = FlexCenter;
            break;
            
        case VZFLEX_ALIGN_CONTENT_END:
            value = FlexEnd;
            break;
        
        case VZFLEX_ALIGN_CONTENT_STRETCH:
            value = FlexStretch;
            break;
            
        default:
            break;
    }
    _flex_node -> alignContent = (FlexAlign)value;
}

- (void)setAlignItems:(VZFlexNodeAlignItems)alignItems{
    _alignItems = alignItems;
//    _css_node -> style.align_items = (css_align_t)alignItems;
    
    FlexAlign value = FlexStretch;
    switch (alignItems) {
        case VZFLEX_ALIGN_CONTENT_START:
            value = FlexStart;
            break;
            
        case VZFLEX_ALIGN_CONTENT_CENTER:
            value = FlexCenter;
            break;
            
        case VZFLEX_ALIGN_CONTENT_END:
            value = FlexEnd;
            break;
            
        case VZFLEX_ALIGN_CONTENT_STRETCH:
            value = FlexStretch;
            break;
            
        default:
            break;
    }
    _flex_node -> alignItems = (FlexAlign)value;
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
        
        _flex_node = (FlexNode* )calloc(1, sizeof(*_flex_node));
        initFlexNode(_flex_node);
        _flex_node->context = (__bridge void* )self;
        _flex_node->measure = flexNodeMeasure;
        _flex_node->childAt = flexNodeChildAt;
        
//        _css_node = new_css_node();
//        _css_node -> measure = vz_css_node_measure;
//        _css_node -> context = (__bridge void*)self;
//        _css_node -> is_dirty = vz_css_node_is_dirty;
//        _css_node -> get_child = vz_css_node_child_at_index;
        _childNodes = [NSMutableArray new];
        
    }
    return self;
}

- (void)dealloc{
    
//    free(_css_node);
//    _css_node = NULL;
    
    free(_flex_node);
    _flex_node = NULL;
}

- (CGRect)frame
{
    return (CGRect) {
//        .origin.x = _css_node->layout.position[CSS_LEFT],
//        .origin.y = _css_node->layout.position[CSS_TOP],
//        .size.width = _css_node->layout.dimensions[CSS_WIDTH],
//        .size.height = _css_node->layout.dimensions[CSS_HEIGHT]
        
        .origin.x = _flex_node -> result.position[0],
        .origin.y = _flex_node ->result.position[1],
        .size.width = _flex_node->result.size[FLEX_WIDTH],
        .size.height = _flex_node->result.size[FLEX_HEIGHT]
    };
}


- (void)prepareLayout
{
    _flex_node -> childrenCount = (int)self.childNodes.count;
    for(VZFlexNode* node in self.childNodes)
    {
        [node prepareLayout];
    }
    
    _flex_node -> result.size[0] = 0;
    _flex_node -> result.size[1] = 0;
    _flex_node -> result.position[0] = 0;
    _flex_node -> result.position[1] = 0;
    _flex_node -> result.margin[0] = 0;
    _flex_node -> result.margin[1] = 0;
    _flex_node -> result.margin[2] = 0;
    _flex_node -> result.margin[3] = 0;
    
//    
//    _css_node ->layout.position[CSS_LEFT] = 0;
//    _css_node ->layout.position[CSS_TOP] = 0;
//    _css_node ->layout.dimensions[CSS_WIDTH] = CSS_UNDEFINED;
//    _css_node ->layout.dimensions[CSS_HEIGHT] = CSS_UNDEFINED;
    
}

- (void)layout:(CGSize)constrainedSize{
    
    //prepare layout递归
    [self prepareLayout];
    
    layoutFlexNode(_flex_node, constrainedSize.width, constrainedSize.height);
//    layoutNode(_css_node, constrainedSize.width, CSS_DIRECTION_LTR);
    
//    [self printCSSNode];
}

- (CGSize)sizeThatFits:(CGSize)constraintedSize{
    return CGSizeZero;
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
//
//- (void)printCSSNode{
//
//    for (VZFlexNode* node in self.childNodes) {
//        [node printCSSNode];
//    }
//    print_css_node(_css_node, CSS_PRINT_LAYOUT);
//}


- (void)addSubNode:(VZFlexNode* )node{
    
    [_childNodes addObject:node];
    _flex_node -> childrenCount = (int)self.childNodes.count;
//    _css_node -> children_count = (int)self.childNodes.count;
}

- (void)removeSubNode:(VZFlexNode* )node{
    
    [_childNodes removeObject:node];
    _flex_node -> childrenCount = (int)self.childNodes.count;
//    _css_node -> children_count = (int)self.childNodes.count;

}





@end
