# HLCountDownButton
倒计时按钮，可通过xib、storyboard自定义样式[博客地址](https://www.jianshu.com/p/ebd3a27389a2)

✅  应用切换前后台计时准确

##### 支持使用CocoaPods引入, Podfile文件中添加:

``` objc
pod 'HLCountDownButton', '1.0.5'
```
注意：需要在`Podfile`中添加`use_frameworks!`，不然在xib、storyboard中渲染会报以下错误：

```shell
error: IB Designables: Failed to render and update auto layout status for ViewController (BYZ-38-t0r): Failed to load designables from path (null)
```
# Demonstration
![image](https://github.com/huangchangweng/HLCountDownButton/blob/main/QQ20220610-112617.gif)
![image](https://github.com/huangchangweng/HLCountDownButton/blob/main/QQ20220610-112252.gif)

可设置属性:<p>

``` objc
/// 样式，默认HLCountDownButtonTypeNormal
@property (nonatomic, assign) IBInspectable NSInteger hlType UI_APPEARANCE_SELECTOR;
/// 是否可用，默认YES
@property (nonatomic, assign) IBInspectable BOOL hlEnabled UI_APPEARANCE_SELECTOR;
/// 正常标题，默认“获取验证码”
@property (nonatomic, copy) IBInspectable NSString *normalTitle UI_APPEARANCE_SELECTOR;
/// 重新获取标题，默认“获取验证码”
@property (nonatomic, copy) IBInspectable NSString *againTitle UI_APPEARANCE_SELECTOR;
/// 发送中标题格式，默认“%ds 后获取”
@property (nonatomic, copy) IBInspectable NSString *sendingTitleFormat UI_APPEARANCE_SELECTOR;
/// 高亮颜色，默认0x4181FE
@property (nonatomic, strong) IBInspectable UIColor *highlightedColor UI_APPEARANCE_SELECTOR;
/// 非高亮颜色，默认0xd2d2d2
@property (nonatomic, strong) IBInspectable UIColor *disabledColor UI_APPEARANCE_SELECTOR;
/// 圆角半径，默认4
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius UI_APPEARANCE_SELECTOR;
/// 边框宽度，默认0.5
@property (nonatomic, assign) IBInspectable CGFloat borderWidth UI_APPEARANCE_SELECTOR;
/// 倒计时长，默认60s
@property (nonatomic, assign) IBInspectable NSInteger countDownSize UI_APPEARANCE_SELECTOR;
```

# GlobalSetting

如果您项目中多个地方使用到该组件，您可以全局设置样式，例在`AppDelegate`添加

``` objc
[HLCountDownButton appearance].highlightedColor = [UIColor redColor];
```

> 注意：`代码` > `appearance` > `interface builder`，所以appearance设置的会覆盖在xib或storyboard中设置的属性，当然`代码`会覆盖`appearance`设置

# Requirements

iOS 9.0 +, Xcode 7.0 +

# Version

* 1.0.5 :

  添加全局设置样式功能
  
* 1.0.4 :

  修改在应用切换前后台计时不准确问题
  
* 1.0.3 :

  修改在xib、storyboard显示问题
  
* 1.0.2 :

  此版本和1.0.0一样，请勿使用此版本

* 1.0.1 :

  此版本和1.0.0一样，请勿使用此版本
  
* 1.0.0 :

  完成HLCountDownButton基础搭建

# License
HLCountDownButton is available under the MIT license. See the LICENSE file for more info.
