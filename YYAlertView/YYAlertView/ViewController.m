//
//  ViewController.m
//  YYAlertView
//
//  Created by 于云飞 on 17/4/5.
//  Copyright © 2017年 于云飞. All rights reserved.
//

#import "ViewController.h"
#import "YYAlertView.h"
#import "SubViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UITextField *tf1;
@property (nonatomic, strong) UITextField *tf2;
@property (nonatomic, strong) UITextField *tf3;

@property (nonatomic, strong) UIButton *cancel;
@property (nonatomic, strong) UIButton *confirm;

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:246/255.0 green:171/255.0 blue:194/255.0 alpha:1];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}
- (void)showAlert {
    YYAlertView *alertView = [YYAlertView alertTitle:@"商户中心" message:@"请输入请求host与描述des"];
    __weak typeof(alertView) weakAlert = alertView;
    __weak typeof(self) weakSelf = self;
    [alertView addView:^UIView *(void) {return self.tf1;}];
    [alertView addView:^UIView *(void) {return self.tf2;}];
    [alertView addView:^UIView *(void) {return self.tf3;}];
    
    [alertView addControl:^UIControl *{return weakSelf.cancel;} Actions:^NSString *{return nil;}];
    [alertView addControl:^UIControl *{return weakSelf.confirm;} Actions:^NSString *{
        UITextField *tf1 = [weakAlert viewWithTag:100];
        UITextField *tf2 = [weakAlert viewWithTag:101];
        if (tf1.text.length && tf2.text.length) {
            return nil;
        }
        return @"请输入正确的host或描述des！";
    }];
    [alertView show];
}
#pragma mark - getter
- (UIButton *)cancel {
    if (_cancel == nil) {
        UIButton *button = [self customButton];
        [button setTitle:@"取消" forState:UIControlStateNormal];
        _cancel = button;
    }
    return _cancel;
}
- (UIButton *)confirm {
    if (_confirm == nil) {
        UIButton *button = [self customButton];
        [button setTitle:@"确认" forState:UIControlStateNormal];
        _confirm = button;
    }
    return _confirm;
}
- (UITextField *)tf1 {
    if (_tf1 == nil) {
        _tf1 = [self customTf];
        _tf1.tag = 100;
        _tf1.placeholder = @"请输入请求des";
    }
    return _tf1;
}
- (UITextField *)tf2 {
    if (_tf2 == nil) {
        _tf2 = [self customTf];
        _tf2.tag = 101;
        _tf2.placeholder = @"请输入请求host";
    }
    return _tf2;
}
- (UITextField *)tf3 {
    if (_tf3 == nil) {
        _tf3 = [self customTf];
        _tf3.tag = 102;
        _tf3.placeholder = @"请输入编辑者";
    }
    return _tf3;
}

#pragma mark - shortcut init

- (UITextField *)customTf {
    UITextField *textTf = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    textTf.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    textTf.borderStyle = UITextBorderStyleRoundedRect;
    textTf.textColor = [UIColor blueColor];
    textTf.font = [UIFont systemFontOfSize:14];
    return textTf;
}

- (UIButton *)customButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 100, 40);
    [button.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    return button;
}

#pragma mark - actions
- (IBAction)push:(UIButton *)sender {
    SubViewController *sub = [[SubViewController alloc] init];
    [self.navigationController pushViewController:sub animated:YES];
}

#pragma mark - touch actions
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self showAlert];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
