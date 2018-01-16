//
//  SystemMediator+CreateMainPage.m
//  JLRouteTest
//
//  Created by mac on 2017/3/31.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "SystemMediator+CreateMainPage.h"

@implementation SystemMediator (CreateMainPage)

- (void)createMainPage {
    Class mainClass = NSClassFromString(@"MianViewController");
    Class moduleAClass = NSClassFromString(@"ModuleAMainViewController")?:NSClassFromString(@"UIViewController");
    Class moduleBClass = NSClassFromString(@"ModuleBMainViewController")?:NSClassFromString(@"UIViewController");
    
    id mainController = [[mainClass alloc] init];
    UIViewController *moduleAController = [[moduleAClass alloc] init];
    UIViewController *moduleBController = [[moduleBClass alloc] init];
    
    moduleAController.tabBarItem.title = @"A";
    moduleBController.tabBarItem.title = @"B";
    
    if ([mainController isKindOfClass:[UITabBarController class]]) {
        [mainController performSelector:@selector(setViewControllers:) withObject:@[moduleAController,moduleBController]];
    }
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:mainController];
    [nav setNavigationBarHidden:YES];
    [[[UIApplication sharedApplication] delegate] window].rootViewController = nav;
}

@end
