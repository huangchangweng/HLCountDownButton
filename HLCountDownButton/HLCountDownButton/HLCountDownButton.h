//
//  HLCountDownButton.h
//  HLCountDownButton
//
//  Created by JJB_iOS on 2022/6/1.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HLCountDownButtonType) {
    HLCountDownButtonTypeNormal,            ///< 无背景，无边框
    HLCountDownButtonTypeOnlyLine,          ///< 无背景，有边框
    HLCountDownButtonTypeOnlyBackground,    ///< 有背景，无边框
};

IB_DESIGNABLE

@interface HLCountDownButton : UIButton
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


/// 点击回调
@property (nonatomic, strong) void(^startBlock)(void);
/// 重置
- (void)reset;

@end

