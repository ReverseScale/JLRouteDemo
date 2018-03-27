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
    Class tabBarClass = NSClassFromString(@"CustomTabBar");
    id tabBarController = [[tabBarClass alloc] init];
    
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:tabBarController];
//    [nav setNavigationBarHidden:NO];
    [[[UIApplication sharedApplication] delegate] window].rootViewController = navi;
}


@end
