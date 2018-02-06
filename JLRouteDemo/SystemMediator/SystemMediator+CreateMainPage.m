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
    Class tabBarClass = NSClassFromString(@"TabBarController");
    Class moduleAClass = NSClassFromString(@"ModuleAMainViewController")?:NSClassFromString(@"UIViewController");
    Class moduleBClass = NSClassFromString(@"ModuleBMainViewController")?:NSClassFromString(@"UIViewController");
    
    id tabBarController = [[tabBarClass alloc] init];
    UIViewController *moduleAController = [[moduleAClass alloc] init];
    UIViewController *moduleBController = [[moduleBClass alloc] init];
    
    moduleAController.tabBarItem.title = @"ModuleA";
    moduleBController.tabBarItem.title = @"ModuleB";
    
    if ([tabBarController isKindOfClass:[UITabBarController class]]) {
        [tabBarController performSelector:@selector(setViewControllers:) withObject:@[moduleAController,moduleBController]];
    }
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:tabBarController];
    [nav setNavigationBarHidden:NO];
    [[[UIApplication sharedApplication] delegate] window].rootViewController = nav;
}

@end
