//
//  ModuleBMainViewController.m
//  JLRouteTest
//
//  Created by mac on 2017/3/30.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "ModuleBMainViewController.h"

@interface ModuleBMainViewController ()

@end

@implementation ModuleBMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    // 导航栏
    self.navigationController.navigationBarHidden = YES;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    label.center = self.view.center;
    label.text = @"ModuleB";
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
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
