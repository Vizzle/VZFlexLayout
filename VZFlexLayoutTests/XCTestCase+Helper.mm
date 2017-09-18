//
//  XCTestCase+Helper.m
//  VZFlexLayout
//
//  Created by Sleen on 2017/8/8.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import "XCTestCase+Helper.h"
#import "YogaBridge.h"

#import <vector>


#if YOGA
#   define LAYOUT layoutYoga
#else
#   define LAYOUT layoutFlexNode
#endif


struct Node {
    FlexNodeRef flexNode;
    std::vector<std::shared_ptr<Node>> children;
    float measureWidth;
    float measureHeight;
    
    Node() {
        flexNode = newFlexNode();
        initFlexNode(flexNode);
    }

    ~Node() {
        freeFlexNode(flexNode);
    }
    
    static FlexNodeRef childAt(void* context, size_t index) {
        Node *node = (Node *)context;
        return node->children[index]->flexNode;
    }
    
    static FlexSize measure(void *context, FlexSize constraintedSize) {
        struct Node *node = (struct Node *)context;
//        const struct timespec sleeptime = {0, 1000000};
//        nanosleep(&sleeptime, NULL);
        return (FlexSize){
            .size = {node->measureWidth, node->measureHeight}
        };
    }

    void createTree() {
        Flex_setContext(flexNode, this);
        if (measureWidth > 0 || measureHeight > 0) {
            Flex_setMeasureFunc(flexNode, Node::measure);
        }
        Flex_setChildAtFunc(flexNode, Node::childAt);
        Flex_setChildrenCount(flexNode, children.size());
        for (auto child : children) {
            child->createTree();
        }
    }
    
    void layout(float width = FlexAuto, float height = FlexAuto, float scale = 1) {
        createTree();
        LAYOUT(flexNode, width, height, scale);
    }

    void print(int indent = 0) {
        for (int i=0;i<indent;i++) {
            printf("  ");
        }
        printf("%.1f, %.1f - %.1f x %.1f\n",
               Flex_getResultLeft(flexNode),
               Flex_getResultTop(flexNode),
               Flex_getResultWidth(flexNode),
               Flex_getResultHeight(flexNode));
        for (auto child : children) {
            child->print(indent + 1);
        }
    }
};


bool _bool(id obj, bool defaultValue = false) {
    if ([obj isKindOfClass:[NSNumber class]]) {
        return [obj boolValue];
    }
    return defaultValue;
}

float _float(id obj, float defaultValue = 0) {
    if ([obj isKindOfClass:[NSNumber class]]) {
        return [obj floatValue];
    }
    return defaultValue;
}

int _int(id obj, int defaultValue = 0) {
    if ([obj isKindOfClass:[NSNumber class]]) {
        return [obj intValue];
    }
    return defaultValue;
}

FlexWrapMode _wrapMode(id obj) {
    if ([obj isKindOfClass:[NSNumber class]]) {
        return [obj boolValue] ? FlexWrap : FlexNoWrap;
    } else if ([obj isKindOfClass:[NSString class]]) {
        static NSDictionary *dict = @{
                                      @"nowrap" : @(FlexNoWrap),
                                      @"wrap" : @(FlexWrap),
                                      @"wrap-reverse" : @(FlexWrapReverse),
                                      };
        obj = dict[obj];
        return obj ? (FlexWrapMode)[obj integerValue] : FlexNoWrap;
    }
    return FlexNoWrap;
}

FlexDirection _direction(id obj) {
    if ([obj isKindOfClass:[NSString class]]) {
        static NSDictionary *dict = @{
                                      @"horizontal" : @(FlexHorizontal),
                                      @"vertical" : @(FlexVertical),
                                      @"horizontal-reverse" : @(FlexHorizontalReverse),
                                      @"vertical-reverse" : @(FlexVerticalReverse),
                                      };
        obj = dict[obj];
        return obj ? (FlexDirection)[obj integerValue] : FlexHorizontal;
    }
    return FlexHorizontal;
}

FlexAlign _align(id obj, FlexAlign defaultValue) {
    if ([obj isKindOfClass:[NSString class]]) {
        static NSDictionary *dict = @{
                                      @"auto" : @(FlexInherit),
                                      @"start" : @(FlexStart),
                                      @"center" : @(FlexCenter),
                                      @"end" : @(FlexEnd),
                                      @"stretch" : @(FlexStretch),
                                      @"space-between" : @(FlexSpaceBetween),
                                      @"space-around" : @(FlexSpaceAround),
                                      @"baseline" : @(FlexBaseline),
                                      };
        obj = dict[obj];
        return obj ? (FlexAlign)[obj integerValue] : defaultValue;
    }
    return defaultValue;
}

FlexLength _length(id obj, FlexLength defaultValue = {0, FlexLengthTypeDefault}) {
    if ([obj isKindOfClass:[NSString class]]) {
        if ([@"auto" isEqualToString:obj]) {
            return FlexLengthAuto;
        } else if ([@"content" isEqualToString:obj]) {
            return FlexLengthContent;
        } else {
            static NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^-?(0|[1-9]\\d*)(\\.\\d+)?([eE][+-]?\\d+)?" options:0 error:nil];
            NSTextCheckingResult *result = [regex firstMatchInString:obj options:0 range:NSMakeRange(0, [obj length])];
            if (result) {
                NSString *suffix = [obj substringFromIndex:result.range.length];
                FlexLengthType type;
                if ([@"%" isEqualToString:suffix]) {
                    type = FlexLengthTypePercent;
                } else if ([@"px" isEqualToString:suffix]) {
                    type = FlexLengthTypePx;
                } else if ([@"cm" isEqualToString:suffix]) {
                    type = FlexLengthTypeCm;
                } else if ([@"mm" isEqualToString:suffix]) {
                    type = FlexLengthTypeMm;
                } else if ([@"q" isEqualToString:suffix]) {
                    type = FlexLengthTypeQ;
                } else if ([@"in" isEqualToString:suffix]) {
                    type = FlexLengthTypeIn;
                } else if ([@"pc" isEqualToString:suffix]) {
                    type = FlexLengthTypePc;
                } else if ([@"pt" isEqualToString:suffix]) {
                    type = FlexLengthTypePt;
//                } else if ([@"em" isEqualToString:suffix]) {
//                    type = FlexLengthTypeEm;
//                } else if ([@"ex" isEqualToString:suffix]) {
//                    type = FlexLengthTypeEx;
//                } else if ([@"ch" isEqualToString:suffix]) {
//                    type = FlexLengthTypeCh;
//                } else if ([@"rem" isEqualToString:suffix]) {
//                    type = FlexLengthTypeRem;
                } else if ([@"vw" isEqualToString:suffix]) {
                    type = FlexLengthTypeVw;
                } else if ([@"vh" isEqualToString:suffix]) {
                    type = FlexLengthTypeVh;
                } else if ([@"vmin" isEqualToString:suffix]) {
                    type = FlexLengthTypeVmin;
                } else if ([@"vmax" isEqualToString:suffix]) {
                    type = FlexLengthTypeVmax;
                } else {
                    type = FlexLengthTypeDefault;
                }
                
                return flexLength([[obj substringWithRange:result.range] doubleValue], type);
            }
        }
    }
    if ([obj isKindOfClass:[NSNumber class]]) {
        return flexLength([obj floatValue], FlexLengthTypeDefault);
    }
    return defaultValue;
}

std::shared_ptr<Node> _nodeFromDictionary(NSDictionary *dict) {
    std::shared_ptr<Node> node = std::shared_ptr<Node>(new Node);
    node->measureWidth = _float(dict[@"measure-width"], 0);
    node->measureHeight = _float(dict[@"measure-height"], 0);
    Flex_setWidth_Length(node->flexNode, _length(dict[@"width"], FlexLengthAuto));
    Flex_setHeight_Length(node->flexNode, _length(dict[@"height"], FlexLengthAuto));
    Flex_setMinWidth_Length(node->flexNode, _length(dict[@"min-width"], FlexLengthZero));
    Flex_setMinHeight_Length(node->flexNode, _length(dict[@"min-height"], FlexLengthZero));
    Flex_setMaxWidth_Length(node->flexNode, _length(dict[@"max-width"], FlexLengthUndefined));
    Flex_setMaxHeight_Length(node->flexNode, _length(dict[@"max-height"], FlexLengthUndefined));
    Flex_setMarginLeft_Length(node->flexNode, _length(dict[@"margin-left"], _length(dict[@"margin"], FlexLengthZero)));
    Flex_setMarginTop_Length(node->flexNode, _length(dict[@"margin-top"], _length(dict[@"margin"], FlexLengthZero)));
    Flex_setMarginRight_Length(node->flexNode, _length(dict[@"margin-right"], _length(dict[@"margin"], FlexLengthZero)));
    Flex_setMarginBottom_Length(node->flexNode, _length(dict[@"margin-bottom"], _length(dict[@"margin"], FlexLengthZero)));
//    Flex_setMarginStart_Length(node->flexNode, _length(dict[@"margin-start"], _length(dict[@"margin"], FlexLengthZero)));
//    Flex_setMarginEnd_Length(node->flexNode, _length(dict[@"margin-end"], _length(dict[@"margin"], FlexLengthZero)));
    Flex_setPaddingLeft_Length(node->flexNode, _length(dict[@"padding-left"], _length(dict[@"padding"], FlexLengthZero)));
    Flex_setPaddingTop_Length(node->flexNode, _length(dict[@"padding-top"], _length(dict[@"padding"], FlexLengthZero)));
    Flex_setPaddingRight_Length(node->flexNode, _length(dict[@"padding-right"], _length(dict[@"padding"], FlexLengthZero)));
    Flex_setPaddingBottom_Length(node->flexNode, _length(dict[@"padding-bottom"], _length(dict[@"padding"], FlexLengthZero)));
//    Flex_setPaddingStart_Length(node->flexNode, _length(dict[@"padding-start"], _length(dict[@"padding"], FlexLengthZero)));
//    Flex_setPaddingEnd_Length(node->flexNode, _length(dict[@"padding-end"], _length(dict[@"padding"], FlexLengthZero)));
    Flex_setBorderLeft(node->flexNode, _float(dict[@"border-left"], _float(dict[@"border"], 0)));
    Flex_setBorderTop(node->flexNode, _float(dict[@"border-top"], _float(dict[@"border"], 0)));
    Flex_setBorderRight(node->flexNode, _float(dict[@"border-right"], _float(dict[@"border"], 0)));
    Flex_setBorderBottom(node->flexNode, _float(dict[@"border-bottom"], _float(dict[@"border"], 0)));
//    Flex_setBorderStart_Length(node->flexNode, _float(dict[@"border-start"], _float(dict[@"border"], 0)));
//    Flex_setBorderEnd_Length(node->flexNode, _float(dict[@"border-end"], _float(dict[@"border"], 0)));
    Flex_setWrap(node->flexNode, _wrapMode(dict[@"wrap"]));
    Flex_setDirection(node->flexNode, _direction(dict[@"direction"]));
    Flex_setAlignItems(node->flexNode, _align(dict[@"align-items"], FlexStretch));
    Flex_setAlignSelf(node->flexNode, _align(dict[@"align-self"], FlexInherit));
    Flex_setAlignContent(node->flexNode, _align(dict[@"align-content"], FlexStretch));
    Flex_setJustifyContent(node->flexNode, _align(dict[@"justify-content"], FlexStart));
    Flex_setFlexBasis_Length(node->flexNode, _length(dict[@"flex-basis"], FlexLengthAuto));
    Flex_setFlexGrow(node->flexNode, _float(dict[@"flex-grow"], 0));
    Flex_setFlexShrink(node->flexNode, _float(dict[@"flex-shrink"], 1));

    Flex_setFixed(node->flexNode, _bool(dict[@"fixed"]));
    Flex_setSpacing_Length(node->flexNode, _length(dict[@"spacing"]));
    Flex_setLineSpacing_Length(node->flexNode, _length(dict[@"line-spacing"]));
    Flex_setLines(node->flexNode, _int(dict[@"lines"]));
    Flex_setItemsPerLine(node->flexNode, _int(dict[@"items-per-line"]));
    
    NSArray *children = dict[@"children"];
    if ([children isKindOfClass:[NSArray class]]) {
        for (NSDictionary *child in children) {
            node->children.push_back(_nodeFromDictionary(child));
        }
    }
    return node;
}

std::shared_ptr<Node> readLayout(NSString *layout) {
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[layout dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
    return _nodeFromDictionary(dict);
}


@implementation XCTestCase (Helper)

- (void)_checkNode:(FlexNodeRef)node withDict:(NSDictionary *)result error:(NSMutableString *)error {
    XCTAssertNotNil(result);
    if (!result) {
        [error appendString:@"result should not be nil."];
        return;
    }
#define FLOAT_EQUAL(a, b) (a == b)
#define CHECK_RESULT(RESULT, VALUE)                                         \
    do {                                                                    \
        float v = [result[VALUE] floatValue];                               \
        if (!FLOAT_EQUAL(RESULT, v)) {                                      \
            [error appendFormat:@"%@: %@ != %@; ", VALUE, @(RESULT), @(v)]; \
        }                                                                   \
    } while (0)
    CHECK_RESULT(Flex_getResultWidth(node), @"width");
    CHECK_RESULT(Flex_getResultHeight(node), @"height");
    CHECK_RESULT(Flex_getResultLeft(node), @"x");
    CHECK_RESULT(Flex_getResultTop(node), @"y");
    
    NSArray *children = result[@"children"];
    XCTAssertEqual(Flex_getChildrenCount(node), children.count);
    for (int i = 0; i < Flex_getChildrenCount(node); i++) {
        [self _checkNode:Flex_getChildAtFunc(node)(Flex_getContext(node), i) withDict:children[i] error:error];
    }
}

- (NSDictionary *)getResultDictInLayout:(NSDictionary *)layoutWithResult {
    NSMutableDictionary *result = [NSMutableDictionary new];
    for (NSString *key in layoutWithResult) {
        if ([key hasPrefix:@"_"]) {
            result[[key substringFromIndex:1]] = layoutWithResult[key];
        }
    }
    
    if (!result[@"width"]) result[@"width"] = layoutWithResult[@"width"];
    if (!result[@"height"]) result[@"height"] = layoutWithResult[@"height"];
    
    NSArray *children = layoutWithResult[@"children"];
    if (children) {
        NSMutableArray *resultChildren = [NSMutableArray new];
        for (NSDictionary *child in children) {
            [resultChildren addObject:[self getResultDictInLayout:child]];
        }
        result[@"children"] = resultChildren;
    }
    return result;
}

- (NSString *)checkLayout:(NSString *)layoutWithResult withWidth:(float)width height:(float)height scale:(float)scale {
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[layoutWithResult dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
    auto node = _nodeFromDictionary(dict);
    node->layout(width, height, scale);
    NSDictionary *resultDict = [self getResultDictInLayout:dict];

    NSMutableString *error = [NSMutableString new];
    [self _checkNode: node->flexNode withDict:resultDict error:error];
    return error.length > 0 ? error : nil;
}

- (NSString *)checkLayout:(NSString *)layoutWithResult {
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[layoutWithResult dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
    auto node = _nodeFromDictionary(dict);
    node->layout();
    NSDictionary *resultDict = [self getResultDictInLayout:dict];

    NSMutableString *error = [NSMutableString new];
    [self _checkNode:node->flexNode withDict:resultDict error:error];
    return error.length > 0 ? error : nil;
}

@end
