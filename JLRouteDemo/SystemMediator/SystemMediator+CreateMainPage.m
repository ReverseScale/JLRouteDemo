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
    self.tabbar = [[CustomTabBar alloc] init];
    
    //设置数字角标(可选)
    [self.tabbar showBadgeMark:100 index:1];
    //设置为根控制器
    [[[UIApplication sharedApplication] delegate] window].rootViewController = self.tabbar;

}

- (void)cleanTabBar:(NSInteger)index {
    [self.tabbar hideMarkIndex:1];
}

@end
