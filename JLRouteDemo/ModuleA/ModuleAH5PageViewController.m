//
//  ModuleAH5PageViewController.m
//  JLRouteTest
//
//  Created by mac on 2017/3/30.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "ModuleAH5PageViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "SystemMediator.h"

@interface ModuleAH5PageViewController () <UIWebViewDelegate>

@property (strong, nonatomic) JSContext *context;

@end

@implementation ModuleAH5PageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Web";
    
    self.view.backgroundColor = [UIColor whiteColor];

    [self setupWebView];
}

- (void)setupWebView {
    UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-44)];
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.bing.com"]]];
    web.delegate = self;
    [self.view addSubview:web];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buttonAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    self.context[@"openPage"] = ^(NSString *a) {
        NSLog(@"%@",a);
        NSURL *viewUrl = [NSURL URLWithString:@"JLRoutesDemo://MouduleA/ModuleARNPageViewController/setParameter/666"];
        [[SystemMediator sharedInstance] openModuleWithURL:viewUrl];
    };
    
}

@end
