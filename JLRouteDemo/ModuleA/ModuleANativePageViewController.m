//
//  ModuleANativePageViewController.m
//  JLRouteTest
//
//  Created by mac on 2017/3/30.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "ModuleANativePageViewController.h"
#import "ModuleAModel.h"

@interface ModuleANativePageViewController ()

@property (nonatomic, strong) NSDictionary *parameter;

@end

@implementation ModuleANativePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Native";
    
    self.view.backgroundColor = [UIColor whiteColor];

    [self setupLabel];
}

- (void)setupLabel {
    NSString *textTitle = [self.parameter objectForKey:@"text"];
    
    NSLog(@"userId:%@, age:%@", [self.parameter objectForKey:@"userId"], [self.parameter objectForKey:@"age"]);
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 64)];
    label.text = textTitle;
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    label.center = self.view.center;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSDictionary *)parameter {
    if (!_parameter) {
        _parameter = [self dictionaryWithJsonString:self.parameterJsonString];
    }
    return _parameter;
}

- (void)buttonAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
//    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    
    if (err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
@end
