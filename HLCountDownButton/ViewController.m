//
//  ViewController.m
//  HLCountDownButton
//
//  Created by JJB_iOS on 2022/6/1.
//

#import "ViewController.h"
#import "HLCountDownButton.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet HLCountDownButton *noAutoCountDownButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 非自动倒计时按钮示例
    __weak typeof(self) weakSelf = self;
    self.noAutoCountDownButton.startBlock = ^(){
        // 根据自己业务，选择时机触发倒计时，比如获取验证码接口调用成功
        [weakSelf.noAutoCountDownButton startCountDown];
    };

    // 代码添加倒计时按钮示例
    HLCountDownButton *btn = [HLCountDownButton buttonWithType:UIButtonTypeCustom];
    // 可以设置HLCountDownButton各种属性
    btn.countDownSize = 120;
    btn.startBlock = ^(){
        NSLog(@"调接口发送验证码");
    };
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    btn.frame = CGRectMake(145, 500, 120, 40);
    [self.view addSubview:btn];
}


@end
