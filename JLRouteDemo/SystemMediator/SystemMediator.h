//
//  SystemMediator.h
//  JLRouteTest
//
//  Created by mac on 2017/3/30.
//  Copyright © 2017年 GY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CustomTabBar.h"

@interface SystemMediator : NSObject
@property (nonatomic, strong) CustomTabBar *tabbar;

+ (instancetype)sharedInstance;

- (void)openModuleWithURL:(NSURL *)url;

@end
