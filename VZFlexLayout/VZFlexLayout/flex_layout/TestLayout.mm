
#include "TestLayout.h"

using namespace flex;

@interface DashLineView : OSView

@property (strong, nonatomic) OSColor *lineColor;
@property (strong, nonatomic) OSColor *cornerColor;

@end

@implementation DashLineView

- (void)setLineColor:(OSColor *)lineColor {
    _lineColor = lineColor;
    SET_NEEDS_DISPLAY(self);
}

- (void)setCornerColor:(OSColor *)cornerColor {
    _cornerColor = cornerColor;
    SET_NEEDS_DISPLAY(self);
}

- (void)drawRect:(CGRect)rect {
    CGFloat radius = self.bounds.size.height / 2;
    
    CGContextRef context = CURRENT_GRAPHICS;
    
    CGContextSetStrokeColorWithColor(context, _lineColor.CGColor);
    CGContextSetLineWidth(context, 1 / SCREEN_SCALE);
    CGFloat lengths[] = {5, 2.5};
    CGContextSetLineDash(context, 0, lengths, 2);
    CGContextMoveToPoint(context, radius, radius);
    CGContextAddLineToPoint(context, self.bounds.size.width - radius, radius);
    CGContextStrokePath(context);
    
    CGContextSetFillColorWithColor(context, _cornerColor.CGColor);
    CGContextBeginPath(context);
    CGContextAddArc(context, 0, radius, radius, M_PI / 2, M_PI / 2 * 3, 1);
    CGContextClosePath(context);
    CGContextFillPath(context);
    
    CGContextBeginPath(context);
    CGContextAddArc(context, self.bounds.size.width, radius, radius, M_PI / 2 * 3, M_PI / 2, 1);
    CGContextClosePath(context);
    CGContextFillPath(context);
}

@end

FlexLayout line() {
    return FlexLayout {
        .alignSelf = FlexAlign::Stretch,
        .height = 1_px,
        .backColor = "#e5e5e5",
    };
}

FlexLayout item(std::string title, std::string subtitle = "") {
    FlexLayout layout = {
        .name = "item",
        .direction = FlexDirection::Horizontal,
        .spacing = 8,
        .margin = { 0, -15 },
        .padding = { 15, 15 },
        .content = ButtonNode {
            .background = {
                { UIControlStateNormal, Color(0U) },
                { UIControlStateHighlighted, Color("#1000") },
            }
        },
        .attrs = {
            TapGestrue(^(id sender) { NSLog(@"%@", [NSString stringWithUTF8String:title.c_str()]); })
        },
        .children = {
            {
                .marginRight = Auto,
                .content = TextNode {
                    .text = title,
                    .color = "#333",
                    .font = Font{.size = 16},
                },
            },
            {
                .width = 15,
                .height = 15,
                .alignSelf = FlexAlign::Center,
                .content = ImageNode {
                    .image = "right",
                }
            }
        }
    };
    
    if (!subtitle.empty()) {
        layout.children.insert(layout.children.begin() + 1, {
            .content = TextNode{
                .text = subtitle,
                .color = "#999",
                .font = Font{.size = 15},
            },
        });
    }
    
    return layout;
}

FlexLayout makeTestLayout1() {
    FlexLayout logo = {
        .fixed = true,
        .name = "logo",
        .width = 50.0f,
        .height = 50,
        .marginLeft = Auto,
        .marginRight = Auto,
        .alignSelf = FlexAlign::Center,
        .backColor = "#bbb",
        .borderColor = "#ddd",
        .borderWidth = 1,
        .cornerRadius = 25,
        .content = ImageNode {
            .image = "logo",
        },
    };
    
    FlexLayout head = {
        .marginTop = 10,
        .name = "main",
        .direction = FlexDirection::Vertical,
        .alignItems = FlexAlign::Center,
        .children = {
            {
                .name = "shopName",
                .marginTop = 10,
                .content = TextNode{
                    .text = "世纪联华超市",
                    .color = "#A5A5A5",
                    .font = Font{.size = 12},
                },
            },
            {
                .name = "filedA",
                .marginTop = 6,
                .content = TextNode{
                    .text = "光明莫斯利安酸奶",
                    .color = "#333",
                    .font = Font{.size = 12},
                },
            },
            {
                .marginTop = 15,
                .direction = FlexDirection::Horizontal,
                .alignItems = FlexAlign::Center,
                .spacing = 0,
                .children = {
                    {
                        .name = "filedB",
                        .content = TextNode{
                            .text = "8.8折",
                            .font = Font{.size = 25},
                        },
                    },
                    //                    {
                    //                        .name = "filedC",
                    //                        .children = {
                    //                            {
                    //                                .content = TextNode{
                    //                                    .text = "券名称字段C",
                    //                                    .color = hsla(0, 0, 0.5, 1),
                    //                                    .font = Font{.size = 15},
                    //                                },
                    //                            },
                    //                            {
                    //                                .fixed = true,
                    //                                .width = 1_cent,
                    //                                .height = 1,
                    //                                .margin = Auto,
                    //                                .backColor = "gray",
                    //                            }
                    //                        }
                    //                    },
                }
            },
            {
                .marginTop = 15,
                .content = TextNode {
                    .text = "3658人已领",
                    .color = "#666",
                    .font = Font{.size = 12},
                },
            },
        }
    };
    
    FlexLayout second = {
        .direction = FlexDirection::Vertical,
        .spacing = 10,
        .marginBottom = 15,
        .children = {
            {
                .direction = FlexDirection::Horizontal,
                .alignItems = FlexAlign::Start,
                .spacing = 5,
                .children = {
                    {
                        .content = ImageNode {
                            .image = "quan",
                        },
                    },
                    {
                        .content = TextNode {
                            .text = "消费满200元可用",
                            .font = Font { .size = 12 },
                        },
                    }
                },
            },
            {
                .direction = FlexDirection::Horizontal,
                .alignItems = FlexAlign::Start,
                .spacing = 5,
                .children = {
                    {
                        .content = ImageNode {
                            .image = "jian",
                        },
                    },
                    {
                        .content = TextNode {
                            .text = "折后满50减20，最高减50元",
                            .font = Font { .size = 12 },
                        },
                    }
                },
            },
        }
    };
    
    FlexLayout detail = {
        .direction = FlexDirection::Vertical,
        .children = {
            item("商品详情"),
            {
                .marginTop = -5,
                .content = TextNode{
                    .text = "光明莫斯利安是光明乳业推出的高端酸奶，2009年初正式推向市场，2012年开始在全国铺货上市",
                    .color = "#A5A5A5",
                    .font = Font{.size = 12},
                },
            },
            {
                .width = 270,
                .height = 111,
                .marginTop = 10,
                .marginBottom = 5,
                .alignSelf = FlexAlign::Center,
                .backColor = "#ddd",
                .content = ImageNode {
                    .image = "pic",
                }
            },
            line(),
        }
    };
    
    FlexLayout button = {
        .height = 43,
        .cornerRadius = 3,
        .attrs = {
            TapGestrue(^(id sender) { NSLog(@"立即领取"); })
        },
        .content = ButtonNode {
            .text = "立即领取",
            .color = "#4D7CBE",
            .font = Font { .size = 18 },
            .align = TextAlign::Center,
            .background = {
                { UIControlStateNormal, Color("white") },
                { UIControlStateHighlighted, Color("#cfff") },
            },
        },
    };
    
    return {
        .direction = FlexDirection::Vertical,
        .margin = {20, 10},
        .spacing = 20,
        .children = {
            {
                .name = "main",
                .marginTop = 25,
                .padding = 15,
                .paddingBottom = 0,
                .direction = FlexDirection::Vertical,
                .alignItems = FlexAlign::Stretch,
                .backColor = "white",
                .cornerRadius = 3,
                .children = {
                    head,
                    {
                        .viewClass = [DashLineView class],
                        .height = 9,
                        .alignSelf = FlexAlign::Stretch,
                        .margin = {11, -15},
                        .attrs = {
                            {@selector(setLineColor:), (OSColor *)Color("#e5e5e5")},
                            {@selector(setCornerColor:), (OSColor *)Color("#4D7CBE")},
                        },
                    },
                    second,
                    line(),
                    detail,
                    item("适用门店", "最近700米"),
                    line(),
                    item("折扣须知"),
                }
            },
            button,
            logo,
        }
    };
}

FlexLayout makeTestLayout2() {
    FlexLayout logo = {
        .flexShrink = 0,
        .width = 75,
        .height = 60,
        .cornerRadius = 4,
        .content = ImageNode { .image = "shop" },
    };
    
    FlexLayout title = {
        .name = "name",
        .direction = FlexDirection::Horizontal,
        .alignItems = FlexAlign::Center,
        .spacing = 4,
        .children = {
            {
                .content = TextNode{
                    .text = "新白鹿餐厅(滨江店)",
                    .color = "#333",
                    .font = Font{.size = 15},
                    .wrap = TextWrap::TruncateTail,
                },
            },
            {
                .flexShrink = 0,
                .content = ImageNode {.image = "xue"},
            },
            {
                .flexShrink = 0,
                .content = ImageNode {.image = "zhe"},
            },
            {
                .flexShrink = 0,
                .content = ImageNode {.image = "qiang"},
            }
        }
    };
    
    FlexLayout rating = {
        .direction = FlexDirection::Horizontal,
        .spacing = 8,
        .children = {
            {
                .flexShrink = 0,
                .content = TextNode{
                    .text = "⭐️⭐️⭐️⭐️⭐️",
                    .font = Font{.size = 12},
                },
            },
            {
                .content = TextNode{
                    .text = "52元/人",
                    .color = "#A5A5A5",
                    .font = Font{.size = 12},
                },
            }
        }
    };
    
    FlexLayout tags = {
        .direction = FlexDirection::Horizontal,
        .alignSelf = FlexAlign::Stretch,
        .spacing = 3,
        .children = {
            {
                .minWidth = 24,
                .content = TextNode{
                    .text = "杭帮菜",
                    .color = "#A5A5A5",
                    .font = Font{.size = 10},
                    .wrap = TextWrap::TruncateTail,
                },
            },
            {
                .width = 1,
                .flexShrink = 0,
                .alignSelf = FlexAlign::Stretch,
                .backColor = "#ccc",
            },
            {
                .minWidth = 24,
                .content = TextNode{
                    .text = "开发区",
                    .color = "#A5A5A5",
                    .font = Font{.size = 10},
                    .wrap = TextWrap::TruncateTail,
                },
            },
            {
                .width = 1,
                .flexShrink = 0,
                .alignSelf = FlexAlign::Stretch,
                .backColor = "#ccc",
            },
            {
                .flexShrink = 0.01f,
                .content = TextNode{
                    .text = "150m",
                    .color = "#A5A5A5",
                    .font = Font{.size = 10},
                    .wrap = TextWrap::TruncateTail,
                },
            }
        }
    };
    
    FlexLayout discount = {
        .alignItems = FlexAlign::End,
        .children = {
            {
                .flexShrink = 0,
                .content = TextNode{
                    .text = "9.5",
                    .color = "red",
                    .font = Font{.size = 34},
                },
            },
            {
                .flexShrink = 0,
                .content = TextNode{
                    .text = "折",
                    .color = "red",
                    .font = Font{.size = 13},
                },
            }
        }
    };
    
    FlexLayout infos = {
        .marginTop = 8,
        .spacing = 4,
        .direction = FlexDirection::Horizontal,
        .children = {
            {
                .flexShrink = 0,
                .content = TextNode{
                    .text = "🤗",
                    .color = "orange",
                    .font = Font{.size = 14},
                },
            },
            {
                .content = TextNode{
                    .text = "10",
                    .color = "orange",
                    .font = Font{.size = 14},
                },
            }
        }
    };
    
    FlexLayout _1212 = {
        .fixed = true,
        .marginLeft = Auto,
        .content = ImageNode{ .image = "1212" },
    };
    
    FlexLayout main = {
        .padding = 15,
        .direction = FlexDirection::Vertical,
        .children = {
            {
                .direction = FlexDirection::Horizontal,
                .alignItems = FlexAlign::Start,
                .spacing = 10,
                .children = {
                    logo,
                    {
                        .direction = FlexDirection::Vertical,
                        .justifyContent = FlexJustify::SpaceBetween,
                        .alignSelf = FlexAlign::Stretch,
                        .flexGrow = 1,
                        .children = {
                            title,
                            {
                                .direction = FlexDirection::Horizontal,
                                .children = {
                                    {
                                        .flexGrow = 1,
                                        .direction = FlexDirection::Vertical,
                                        .children = {
                                            rating,
                                            tags,
                                        }
                                    },
                                    discount,
                                }
                            },
                            infos,
                        }
                    },
                    
                }
            },
        }
    };
    
    return {
        .backColor = "white",
        .direction = FlexDirection::Vertical,
        .children = {
            main,
            _1212,
        }
    };
}
