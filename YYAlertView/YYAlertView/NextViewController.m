//
//  NextViewController.m
//  YYAlertView
//
//  Created by 于云飞 on 17/4/5.
//  Copyright © 2017年 于云飞. All rights reserved.
//

#import "NextViewController.h"

@interface NextViewController ()

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"测试页面";
    
    UIImage *image = [UIImage imageNamed:@"back"];
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(0,0,50,40);
    button1.titleLabel.font = [UIFont systemFontOfSize:14];
    button1.contentMode = UIViewContentModeCenter;
    [button1 setImage:image forState:UIControlStateNormal];
    [button1 setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
    [button1 setTitleEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
    [button1 setTitle:@"返回" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    
//    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
//    button2.frame = CGRectMake(0,0,40,40);
//    button2.titleLabel.font = [UIFont systemFontOfSize:14];
//    [button2 setTitle:@"关闭" forState:UIControlStateNormal];
//    [button2 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//    [button2 addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithCustomView:button1];
//    UIBarButtonItem *item3 = [[UIBarButtonItem alloc] initWithCustomView:button2];
    
    [self.navigationItem setLeftBarButtonItems:@[item1]];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:219/255.0 green:236/255.0 blue:199/255.0 alpha:1.0];
}
- (void)pop {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
