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
    FlexNode flexNode;
    std::vector<Node> children;
    float measureWidth;
    float measureHeight;
    
    Node() {
        initFlexNode(&flexNode);
    }
    
    static FlexNode* childAt(void* context, size_t index) {
        Node *node = (Node *)context;
        return &node->children[index].flexNode;
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
        flexNode.context = this;
        if (measureWidth > 0 || measureHeight > 0) {
            flexNode.measure = Node::measure;
        }
        flexNode.childAt = Node::childAt;
        flexNode.childrenCount = children.size();
        for (Node& child : children) {
            child.createTree();
        }
    }
    
    void layout(float width = FlexAuto, float height = FlexAuto, float scale = 1) {
        createTree();
        LAYOUT(&flexNode, width, height, scale);
    }

    void print(int indent = 0) {
        for (int i=0;i<indent;i++) {
            printf("  ");
        }
        printf("%.1f, %.1f - %.1f x %.1f\n",
               flexNode.result.position[FLEX_LEFT],
               flexNode.result.position[FLEX_TOP],
               flexNode.result.size[FLEX_WIDTH],
               flexNode.result.size[FLEX_HEIGHT]);
        for (Node child : children) {
            child.print(indent + 1);
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

Node _nodeFromDictionary(NSDictionary *dict) {
    Node node;
    node.measureWidth = _float(dict[@"measure-width"], 0);
    node.measureHeight = _float(dict[@"measure-height"], 0);
    node.flexNode.size[FLEX_WIDTH] = _length(dict[@"width"], FlexLengthAuto);
    node.flexNode.size[FLEX_HEIGHT] = _length(dict[@"height"], FlexLengthAuto);
    node.flexNode.minSize[FLEX_WIDTH] = _length(dict[@"min-width"], FlexLengthZero);
    node.flexNode.minSize[FLEX_HEIGHT] = _length(dict[@"min-height"], FlexLengthZero);
    node.flexNode.maxSize[FLEX_WIDTH] = _length(dict[@"max-width"], FlexLengthUndefined);
    node.flexNode.maxSize[FLEX_HEIGHT] = _length(dict[@"max-height"], FlexLengthUndefined);
    node.flexNode.margin[FLEX_LEFT] = _length(dict[@"margin-left"], _length(dict[@"margin"], FlexLengthZero));
    node.flexNode.margin[FLEX_TOP] = _length(dict[@"margin-top"], _length(dict[@"margin"], FlexLengthZero));
    node.flexNode.margin[FLEX_RIGHT] = _length(dict[@"margin-right"], _length(dict[@"margin"], FlexLengthZero));
    node.flexNode.margin[FLEX_BOTTOM] = _length(dict[@"margin-bottom"], _length(dict[@"margin"], FlexLengthZero));
//    node.flexNode.margin[FLEX_START] = _length(dict[@"margin-start"], _length(dict[@"margin"], FlexLengthZero));
//    node.flexNode.margin[FLEX_END] = _length(dict[@"margin-end"], _length(dict[@"margin"], FlexLengthZero));
    node.flexNode.padding[FLEX_LEFT] = _length(dict[@"padding-left"], _length(dict[@"padding"], FlexLengthZero));
    node.flexNode.padding[FLEX_TOP] = _length(dict[@"padding-top"], _length(dict[@"padding"], FlexLengthZero));
    node.flexNode.padding[FLEX_RIGHT] = _length(dict[@"padding-right"], _length(dict[@"padding"], FlexLengthZero));
    node.flexNode.padding[FLEX_BOTTOM] = _length(dict[@"padding-bottom"], _length(dict[@"padding"], FlexLengthZero));
//    node.flexNode.padding[FLEX_START] = _length(dict[@"padding-start"], _length(dict[@"padding"], FlexLengthZero));
//    node.flexNode.padding[FLEX_END] = _length(dict[@"padding-end"], _length(dict[@"padding"], FlexLengthZero));
    node.flexNode.border[FLEX_LEFT] = _length(dict[@"border-left"], _length(dict[@"border"], FlexLengthZero));
    node.flexNode.border[FLEX_TOP] = _length(dict[@"border-top"], _length(dict[@"border"], FlexLengthZero));
    node.flexNode.border[FLEX_RIGHT] = _length(dict[@"border-right"], _length(dict[@"border"], FlexLengthZero));
    node.flexNode.border[FLEX_BOTTOM] = _length(dict[@"border-bottom"], _length(dict[@"border"], FlexLengthZero));
//    node.flexNode.border[FLEX_START] = _length(dict[@"border-start"], _length(dict[@"border"], FlexLengthZero));
//    node.flexNode.border[FLEX_END] = _length(dict[@"border-end"], _length(dict[@"border"], FlexLengthZero));
    node.flexNode.wrap = _wrapMode(dict[@"wrap"]);
    node.flexNode.direction = _direction(dict[@"direction"]);
    node.flexNode.alignItems = _align(dict[@"align-items"], FlexStretch);
    node.flexNode.alignSelf = _align(dict[@"align-self"], FlexInherit);
    node.flexNode.alignContent = _align(dict[@"align-content"], FlexStretch);
    node.flexNode.justifyContent = _align(dict[@"justify-content"], FlexStart);
    node.flexNode.flexBasis = _length(dict[@"flex-basis"], FlexLengthAuto);
    node.flexNode.flexGrow = _float(dict[@"flex-grow"], 0);
    node.flexNode.flexShrink = _float(dict[@"flex-shrink"], 1);
    
    node.flexNode.fixed = _bool(dict[@"fixed"]);
    node.flexNode.spacing = _length(dict[@"spacing"]);
    node.flexNode.lineSpacing = _length(dict[@"line-spacing"]);
    node.flexNode.lines = _int(dict[@"lines"]);
    node.flexNode.itemsPerLine = _int(dict[@"items-per-line"]);
    
    NSArray *children = dict[@"children"];
    if ([children isKindOfClass:[NSArray class]]) {
        for (NSDictionary *child in children) {
            Node childNode = _nodeFromDictionary(child);
            node.children.push_back(childNode);
        }
    }
    return node;
}

Node readLayout(NSString *layout) {
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[layout dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
    return _nodeFromDictionary(dict);
}


@implementation XCTestCase (Helper)

- (void)_checkNode:(const FlexNode&)node withDict:(NSDictionary *)result error:(NSMutableString *)error {
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
    CHECK_RESULT(node.result.size[FLEX_WIDTH], @"width");
    CHECK_RESULT(node.result.size[FLEX_HEIGHT], @"height");
    CHECK_RESULT(node.result.position[FLEX_LEFT], @"x");
    CHECK_RESULT(node.result.position[FLEX_TOP], @"y");
    
    NSArray *children = result[@"children"];
    XCTAssertEqual(node.childrenCount, children.count);
    for (int i = 0; i < node.childrenCount; i++) {
        [self _checkNode:*node.childAt(node.context, i) withDict:children[i] error:error];
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
    Node node = _nodeFromDictionary(dict);
    node.layout(width, height, scale);
    NSDictionary *resultDict = [self getResultDictInLayout:dict];

    NSMutableString *error = [NSMutableString new];
    [self _checkNode: node.flexNode withDict:resultDict error:error];
    return error.length > 0 ? error : nil;
}

- (NSString *)checkLayout:(NSString *)layoutWithResult {
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[layoutWithResult dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
    Node node = _nodeFromDictionary(dict);
    node.layout();
    NSDictionary *resultDict = [self getResultDictInLayout:dict];

    NSMutableString *error = [NSMutableString new];
    [self _checkNode:node.flexNode withDict:resultDict error:error];
    return error.length > 0 ? error : nil;
}

@end
