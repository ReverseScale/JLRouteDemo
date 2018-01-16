//
//  ModuleRNPageViewController.m
//  JLRouteTest
//
//  Created by mac on 2017/3/30.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "ModuleARNPageViewController.h"
#import <React/RCTRootView.h>

@interface ModuleARNPageViewController ()

@end

@implementation ModuleARNPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    NSURL *jsCodeLocation;
    jsCodeLocation = [NSURL URLWithString:@"http://10.0.0.65:8081/index.ios.bundle?platform=ios&dev=true"];
    RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                        moduleName:@"SimpleApp"
                                                 initialProperties:nil
                                                     launchOptions:nil];
    //注意，这里是 @"EmbedRNMeituan"
    rootView.frame = CGRectMake(0, 64, 300, 300);
    [self.view addSubview:rootView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, CGRectGetHeight(self.view.frame)-44, CGRectGetWidth(self.view.frame), 44)];
    [button setTitle:@"点击返回" forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button setBackgroundColor:[UIColor redColor]];
}

-(void)dealloc {
    NSLog(@"%@",@"ModuleARNPageViewController dealloc");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buttonAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
