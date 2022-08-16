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
@property (nonatomic, assign) int timeout;              ///< 倒计时长
@property (nonatomic, assign) BOOL haveBeenIn;          ///< 发送中
@property (nonatomic, assign) CFAbsoluteTime lastTime;  ///< 进入后台的绝对时间
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

#if TARGET_INTERFACE_BUILDER
- (void)prepareForInterfaceBuilder
{
    [self setTitle:_normalTitle forState:UIControlStateNormal];
    [self setupStyle];
}
#endif

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationDidEnterBackgroundNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationWillEnterForegroundNotification
                                                  object:nil];
}

#pragma mark - Noti Method

- (void)applicationDidEnterBackground
{
    BOOL backgroudRecord = _timer != nil && self.haveBeenIn;
    if (backgroudRecord) {
        self.lastTime = CFAbsoluteTimeGetCurrent();
    }
}

- (void)applicationWillEnterForeground
{
    BOOL backgroudRecord = _timer != nil && self.haveBeenIn;
    if (backgroudRecord) {
        CFAbsoluteTime timeInterval = CFAbsoluteTimeGetCurrent() - self.lastTime;
        self.timeout -= (int)timeInterval;
    }
}

#pragma mark - Private Method

- (void)build
{
    _normalTitle = @"获取验证码";
    _againTitle = @"获取验证码";
    _sendingTitleFormat = @"%ds 后获取";
    _highlightedColor = UIColorFromHEX(0x4181FE);
    _disabledColor = UIColorFromHEX(0xd2d2d2);
    _cornerRadius = 4;
    _borderWidth = 0.5f;
    _hlType = HLCountDownButtonTypeNormal;
    _countDownSize = 60;
    _hlEnabled = YES;
    _autoCountDown = YES;

    [self setTitle:_normalTitle forState:UIControlStateNormal];
    [self setupStyle];
    
    [self addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
    
    // 监听进入前台与进入后台的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationDidEnterBackground)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationWillEnterForeground)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil];
}

- (void)setupStyle
{
    self.backgroundColor = [UIColor clearColor];
    self.layer.borderColor = [UIColor clearColor].CGColor;
    self.layer.borderWidth = 0;
    self.layer.masksToBounds = NO;
    
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
                self.layer.masksToBounds = self.cornerRadius > 0;
                self.layer.borderColor = self.highlightedColor.CGColor;
                self.layer.borderWidth = self.borderWidth;
                break;
            case HLCountDownButtonTypeOnlyBackground:
                [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                self.layer.cornerRadius = self.cornerRadius;
                self.layer.masksToBounds = self.cornerRadius > 0;
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
                self.layer.masksToBounds = self.cornerRadius > 0;
                self.layer.borderColor = self.disabledColor.CGColor;
                self.layer.borderWidth = self.borderWidth;
                break;
            case HLCountDownButtonTypeOnlyBackground:
                [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                self.layer.cornerRadius = self.cornerRadius;
                self.layer.masksToBounds = self.cornerRadius > 0;
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

- (void)startCountDown
{
    self.userInteractionEnabled = NO;
    self.haveBeenIn = YES;
    
    _timeout = (int)self.countDownSize;//倒计时时间
    dispatch_queue_t queue =dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    _timer = timer;
    dispatch_source_set_timer(timer, dispatch_walltime(NULL,0), 1.0*NSEC_PER_SEC,0); //每秒执行
    dispatch_source_set_event_handler(timer, ^{
        if(self.timeout <= 0){//倒计时结束,关闭
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
                [self setTitle:[NSString stringWithFormat:self.sendingTitleFormat, self.timeout] forState:UIControlStateNormal];
                [UIView commitAnimations];
                [self setupStyle];
            });
            self.timeout --;
        }
    });
    dispatch_resume(timer);
}

#pragma mark - Response Event

- (void)tapAction:(UIButton *)sender
{
    if (self.startBlock) {
        self.startBlock();
    }
    
    if (self.autoCountDown) {
        [self startCountDown];
    }
}

#pragma mark - Setter

- (void)setNormalTitle:(NSString *)normalTitle
{
    if (![_normalTitle isEqualToString:normalTitle]) {
        _normalTitle = normalTitle;
        [self setTitle:_normalTitle forState:UIControlStateNormal];
        [self setupStyle];
    }
}

- (void)setHighlightedColor:(UIColor *)highlightedColor
{
    if (![_highlightedColor isEqual:highlightedColor]) {
        _highlightedColor = highlightedColor;
        [self setupStyle];
    }
}

- (void)setDisabledColor:(UIColor *)disabledColor
{
    if (![_disabledColor isEqual:disabledColor]) {
        _disabledColor = disabledColor;
        [self setupStyle];
    }
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    if (_cornerRadius != cornerRadius) {
        _cornerRadius = cornerRadius;
        [self setupStyle];
    }
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    if (_borderWidth != borderWidth) {
        _borderWidth = borderWidth;
        [self setupStyle];
    }
}

- (void)setHlType:(NSInteger)hlType
{
    if (_hlType != hlType) {
        _hlType = hlType;
        [self setupStyle];
    }
}

- (void)setHlEnabled:(BOOL)hlEnabled
{
    if (_hlEnabled != hlEnabled) {
        _hlEnabled = hlEnabled;
        [self setupStyle];
    }
}

@end
