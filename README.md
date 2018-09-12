## VZFlexLayout

FlexLayout is an iOS declaretive UI framework in Objective-C++ inspired by Facebook [ComponentKit](https://componentkit.org/)

[![Build Status](https://travis-ci.org/Vizzle/VZFlexLayout.svg?branch=master)](https://travis-ci.org/Vizzle/VZFlexLayout)
[![Version](https://img.shields.io/cocoapods/v/VZFlexLayout.svg?style=flat)](http://cocoapods.org/pods/VZFlexLayout)
[![License](https://img.shields.io/cocoapods/l/VZFlexLayout.svg?style=flat)](http://cocoapods.org/pods/VZFlexLayout)
[![Platform](https://img.shields.io/cocoapods/p/VZFlexLayout.svg?style=flat)](http://cocoapods.org/pods/VZFlexLayout)


### Features
    
- C++11 aggreate initializer for declaretive APIs
- CSS like properties for UI decoration
- FlexBox Layout Algorithm
            
> FlexLayout is designed to be the core engine of the [MIST framework](https://github.com/Vizzle/MIST). We implemented our own version of Flexbox algorithm instead of using the open sourced [css layout(now is called 'yoga')](https://github.com/facebook/yoga). Together with MIST, VZFlexLayout has been heavily used to implement O2O services in [Alibaba Alipay Wallet](https://www.alipay.com/) since 2016. It has been battle-tested and proven stable for more than two years with millions of users visit per day

### Example

Let's say we have a `UITableViewCell` like this:

![](https://xta0.me/assets/images/2016/03/flex002.png)

Here is an example of how to define a UI component using FlexLayout syntax

```objc
- (FlexLayout )titleLayout:(NSString* )name Time:(NSString* )time Score:(float)score{
    return FlexLayout
        .direction = FlexDirection::Horizontal,
        .spacing = 5,
        .alignItems = FlexAlign::Center,
        .children = {
            {
                .content = TextNode{
                    .text = name,
                    .font = [UIFont systemFontOfSize:14.0f],
                    .color = [UIColor blackColor],
                }
            },
            {
                .viewBuilder = ^{

                    O2OStarView* starView  = [[O2OStarView alloc] initWithOrigin:CGPointMake(0, 0) viewType:O2OStarViewTypeForDisplay starWidth:14 starMargin:0 starNumber:5];
                    starView.score = score;
                    return starView;

                },
                .width = 70,
                .height = 12,
                .flexShrink = 0,
            },
            {
                .content = TextNode{
                    .text = time,
                    .font = [UIFont systemFontOfSize:12.0f],
                    .color = [UIColor grayColor],
                },
                .flexShrink = 0,
                .marginLeft = Auto
            }
        }
    };
}
```

## Installation

[CocoaPods](http://cocoapods.org) is a dependency manager for Swift and Objective-C Cocoa projects. which automates and simplifies the process of using 3rd-party libraries in your projects. See the [Get Started](https://cocoapods.org/#get_started) section for more details.

**Podfile**

```ruby
target YourAwesomeTarget do
  pod 'VZFlexLayout'
end
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

**Cartfile**

```ruby
github "Vizzle/VZFlexLayout" "master"
```

## License

VZFlexLayout is available under the MIT license. See the LICENSE file for more info.
