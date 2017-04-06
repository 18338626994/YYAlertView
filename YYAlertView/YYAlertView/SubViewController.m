//
//  SubViewController.m
//  YYAlertView
//
//  Created by 于云飞 on 17/4/5.
//  Copyright © 2017年 于云飞. All rights reserved.
//

#import "SubViewController.h"
#import "NextViewController.h"

@interface SubViewController ()

@end

@implementation SubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Web页面";
    self.view.backgroundColor = [UIColor whiteColor];
    
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
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(0,0,40,40);
    button2.titleLabel.font = [UIFont systemFontOfSize:14];
    [button2 setTitle:@"关闭" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithCustomView:button1];
    UIBarButtonItem *item3 = [[UIBarButtonItem alloc] initWithCustomView:button2];
    
    [self.navigationItem setLeftBarButtonItems:@[item1,item3]];
    
    [self drawUI];
}
- (void)drawUI {
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.bounds = CGRectMake(0,0,80,40);
    button1.center = self.view.center;
    button1.titleLabel.font = [UIFont systemFontOfSize:14];
    [button1 setTitle:@"push" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
}
- (void)pop {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)close {
    NSLog(@"关闭");
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)push {
    NextViewController *next = [[NextViewController alloc] init];
    [self.navigationController pushViewController:next animated:YES];
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
