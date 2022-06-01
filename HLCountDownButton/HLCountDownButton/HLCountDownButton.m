//
//  HLCountDownButton.m
//  HLCountDownButton
//
//  Created by JJB_iOS on 2022/6/1.
//

#define UIColorFromHEX(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#import "HLCountDownButton.h"

@interface HLCountDownButton() {
    dispatch_source_t _timer;
}
@property (nonatomic, assign) BOOL haveBeenIn; ///< 发送中
@end

@implementation HLCountDownButton

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        [self build];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self build];
    }
    return self;
}

#pragma mark - Private Method

- (void)build
{
    self.normalTitle = @"获取验证码";
    self.againTitle = @"获取验证码";
    self.sendingTitleFormat = @"%ds 后获取";
    self.highlightedColor = UIColorFromHEX(0x4181FE);
    self.disabledColor = UIColorFromHEX(0xd2d2d2);
    self.cornerRadius = 4;
    self.borderWidth = 0.5f;
    self.hlType = HLCountDownButtonTypeNormal;
    self.countDownSize = 60;
    self.hlEnabled = YES;

    [self setTitle:self.normalTitle forState:UIControlStateNormal];
    [self setupStyle];
    
    [self addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setupStyle
{
    self.backgroundColor = [UIColor clearColor];
    self.layer.borderColor = [UIColor clearColor].CGColor;
    self.layer.borderWidth = 0;
    
    // 可用 并 非发送中
    if (self.hlEnabled && (!self.haveBeenIn)) {
        self.userInteractionEnabled = YES;
        
        switch (self.hlType) {
            case HLCountDownButtonTypeNormal:
                [self setTitleColor:self.highlightedColor forState:UIControlStateNormal];
                break;
            case HLCountDownButtonTypeOnlyLine:
                [self setTitleColor:self.highlightedColor forState:UIControlStateNormal];
                self.layer.cornerRadius = self.cornerRadius;
                self.layer.borderColor = self.highlightedColor.CGColor;
                self.layer.borderWidth = self.borderWidth;
                break;
            case HLCountDownButtonTypeOnlyBackground:
                [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                self.layer.cornerRadius = self.cornerRadius;
                self.backgroundColor = self.highlightedColor;
                break;
        }
    }
    // 不可用
    else {
        self.userInteractionEnabled = NO;
        
        switch (self.hlType) {
            case HLCountDownButtonTypeNormal:
                [self setTitleColor:self.disabledColor forState:UIControlStateNormal];
                break;
            case HLCountDownButtonTypeOnlyLine:
                [self setTitleColor:self.disabledColor forState:UIControlStateNormal];
                self.layer.cornerRadius = self.cornerRadius;
                self.layer.borderColor = self.disabledColor.CGColor;
                self.layer.borderWidth = self.borderWidth;
                break;
            case HLCountDownButtonTypeOnlyBackground:
                [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                self.layer.cornerRadius = self.cornerRadius;
                self.backgroundColor = self.disabledColor;
                break;
        }
    }
}

#pragma mark - Public Method

- (void)reset
{
    self.haveBeenIn = NO;
    dispatch_source_cancel(_timer);
    self.userInteractionEnabled = YES;
    [self setTitle:self.normalTitle forState:0];
}

#pragma mark - Response Event

- (void)tapAction:(UIButton *)sender
{
    self.userInteractionEnabled = NO;
    self.haveBeenIn = YES;
    
    __block int timeout = (int)self.countDownSize;//倒计时时间
    dispatch_queue_t queue =dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    _timer = timer;
    if (self.startBlock) {
        self.startBlock();
    }
    dispatch_source_set_timer(timer,dispatch_walltime(NULL,0),1.0*NSEC_PER_SEC,0); //每秒执行
    dispatch_source_set_event_handler(timer, ^{
        if(timeout<=0){//倒计时结束,关闭
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setTitle:self.againTitle forState:UIControlStateNormal];
                self.userInteractionEnabled = YES;
                self.haveBeenIn = NO;
                [self setupStyle];
           });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示根据自己需求设置
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [self setTitle:[NSString stringWithFormat:self.sendingTitleFormat, timeout] forState:UIControlStateNormal];
                [UIView commitAnimations];
                [self setupStyle];
            });
            timeout--;
        }
    });
    dispatch_resume(timer);
}

#pragma mark - Setter

- (void)setNormalTitle:(NSString *)normalTitle {
    _normalTitle = normalTitle;

    [self setTitle:_normalTitle forState:UIControlStateNormal];
    [self setupStyle];
}

- (void)setAgainTitle:(NSString *)againTitle {
    _againTitle = againTitle;
    
    [self setTitle:_againTitle forState:UIControlStateNormal];
    [self setupStyle];
}

- (void)setHighlightedColor:(UIColor *)highlightedColor {
    _highlightedColor = highlightedColor;

    [self setupStyle];
}

- (void)setDisabledColor:(UIColor *)disabledColor {
    _disabledColor = disabledColor;

    [self setupStyle];
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;

    [self setupStyle];
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    _borderWidth = borderWidth;

    [self setupStyle];
}

- (void)setHlType:(NSInteger)hlType {
    _hlType = hlType;

    [self setupStyle];
}

- (void)setHlEnabled:(BOOL)hlEnabled {
    _hlEnabled = hlEnabled;

    [self setupStyle];
}

@end
