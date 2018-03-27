//
//  RNOpenNativeMediator.m
//  JLRouteTest
//
//  Created by mac on 2017/4/5.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "RNOpenNativeMediator.h"
#import "SystemMediator.h"
#import <React/RCTBridgeModule.h>

@interface RNOpenNativeMediator ()<RCTBridgeModule>
@end

@implementation RNOpenNativeMediator
RCT_EXPORT_MODULE()
//RN跳转原生界面
RCT_EXPORT_METHOD(RNOpenOneVC:(NSDictionary *)pageParameter) {
    NSLog(@"RN传入原生界面的数据为:%@",pageParameter);
    NSString *module = pageParameter[@"module"];
    NSString *target = pageParameter[@"target"];
    NSString *action = pageParameter[@"action"];
    NSDictionary *actionParameter = pageParameter[@"parameter"];
    NSString *parameterJsonStr = [self dataTOjsonString:actionParameter];
    NSString *urlStr = [NSString stringWithFormat:@"JLRoutesDemo://%@/%@/%@/%@",module,target,action,parameterJsonStr];
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    __block NSURL *url = [NSURL URLWithString:urlStr];
    //主要这里必须使用主线程发送,不然有可能失效
    dispatch_async(dispatch_get_main_queue(), ^{
        [[SystemMediator sharedInstance] openModuleWithURL:url];
    });
}

- (NSString *)dataTOjsonString:(id)object {
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (!jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

@end
