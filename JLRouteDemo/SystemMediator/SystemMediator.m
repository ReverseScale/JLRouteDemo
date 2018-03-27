//
//  SystemMediator.m
//  JLRouteTest
//
//  Created by mac on 2017/3/30.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "SystemMediator.h"
#import "JLRoutes.h"

@interface SystemMediator ()
@property (nonatomic, strong) UINavigationController *mainNav;
@end

@implementation SystemMediator
+ (instancetype)sharedInstance {
    static SystemMediator *mediator;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mediator = [[SystemMediator alloc] init];
        [mediator registerModule];
    });
    return mediator;
}

- (UINavigationController *)mainNav {
    if (!_mainNav) {
        _mainNav = (UINavigationController *)[[[UIApplication sharedApplication] delegate] window].rootViewController;
    }
    return _mainNav;
}

- (void)registerModule {
    [[JLRoutes globalRoutes] addRoute:@"/:module/:target/:action/:parameter" handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        
        NSString *targetClassString = parameters[@"target"];
        Class targetClass = NSClassFromString(targetClassString);
        id object = [[targetClass alloc] init];
        if ([object respondsToSelector:@selector(setParameterJsonString:)]) {
            [object performSelector:@selector(setParameterJsonString:) withObject:parameters[@"parameter"]];
        }
        if ([object isKindOfClass:[UIViewController class]]) {
            [self.mainNav pushViewController:(UIViewController *)object animated:YES];
            return YES;
        } else {
            return NO;
        }
    }];
}

- (void)openModuleWithURL:(NSURL *)url {
    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
        if (success) {
            [[JLRoutes globalRoutes] routeURL:url];
        }
    }];
}

//消除警告
- (void)setParameterJsonString:(id)parameter {
    
}

@end
