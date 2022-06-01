# HLCountDownButton
倒计时按钮，可通过xib、storyboard自定义样式

##### 支持使用CocoaPods引入, Podfile文件中添加:

``` objc
pod 'HLCountDownButton', '1.0.0'
```

基本使用方法:<p>

``` objc
/// 正常标题，默认“获取验证码”
@property (nonatomic, copy) IBInspectable NSString *normalTitle;
/// 重新获取标题，默认“获取验证码”
@property (nonatomic, copy) IBInspectable NSString *againTitle;
/// 发送中标题格式，默认“%ds 后获取”
@property (nonatomic, copy) IBInspectable NSString *sendingTitleFormat;
/// 高亮颜色，默认0x4181FE
@property (nonatomic, strong) IBInspectable UIColor *highlightedColor;
/// 非高亮颜色，默认0xd2d2d2
@property (nonatomic, strong) IBInspectable UIColor *disabledColor;
/// 圆角半径，默认4
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;
/// 边框宽度，默认0.5
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;
/// 样式，默认HLCountDownButtonTypeNormal
@property (nonatomic, assign) IBInspectable NSInteger hlType;
/// 倒计时长，默认60s
@property (nonatomic, assign) IBInspectable NSInteger countDownSize;
/// 是否可用，默认YES
@property (nonatomic, assign) IBInspectable BOOL hlEnabled;
```

# Requirements

iOS 9.0 +, Xcode 7.0 +

# Version
    
* 1.0.0 :

  完成HLCountDownButton基础搭建

# License
HLCountDownButton is available under the MIT license. See the LICENSE file for more info.
