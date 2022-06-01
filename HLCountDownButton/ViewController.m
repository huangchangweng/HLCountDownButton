//
//  ViewController.m
//  HLCountDownButton
//
//  Created by JJB_iOS on 2022/6/1.
//

#import "ViewController.h"
#import "HLCountDownButton.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

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
