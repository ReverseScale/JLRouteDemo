# JLRouteDemo

![](https://img.shields.io/badge/platform-iOS-red.svg) ![](https://img.shields.io/badge/language-Objective--C-orange.svg)  ![](https://img.shields.io/badge/download-9.9MB-yellow.svg) ![](https://img.shields.io/badge/license-MIT%20License-brightgreen.svg) 

[EN](https://github.com/ReverseScale/JLRouteDemo) | [中文](https://github.com/ReverseScale/JLRouteDemo/blob/master/README_zh.md)

Modular examples based on JLRoute implementations, including link-jump native pages, WebView pages, and ReactNative pages 🤖

> Modularization has become a good medicine for adjusting the structure of a huge project. The benefits of project development, maintenance and subsequent expansion have become self-evident.

![](http://ghexoblogimages.oss-cn-beijing.aliyuncs.com/18-11-22/89699261.jpg)

----
### 🤖 Requirements

* iOS 8.0+
* Xcode 7.0+

----
### 🎯 Installation

#### Install

In * iOS *, you need to add in Podfile.
```
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!

pod 'JLRoutes', '~> 2.0.1'

# 'node_modules' directory is generally located in the root directory
# But if your structure is different, then you have to modify the following path according to the actual `path:`
pod 'React', :path => './node_modules/react-native', :subspecs => [
    'Core',
    'RCTText',
    'RCTNetwork',
    'RCTWebSocket', # This module is for debugging purposes
     # Here to continue to add the modules you need
]
# If your RN version> = 0.42.0, please add the following line
pod "Yoga", :path => "./node_modules/react-native/ReactCommon/yoga"
```

#### Start the ReactNative environment
1. Modify the project ModuleARNPageViewController.m IP jump address

![](http://og1yl0w9z.bkt.clouddn.com/18-1-16/87041593.jpg)

2. Into the project directory, run (first run requires npm install)
```
npm start
```

----
### 🛠 JLRoutes workflow and principles

#### A single Scheme registration process:

![](http://og1yl0w9z.bkt.clouddn.com/18-2-7/27262498.jpg)

1. Call registration method (user registration routePattern, the default priority 0)

```Objective-C
- (void)addRoute:(NSString *)routePattern handler:(BOOL (^__nullable)(NSDictionary<NSString *, id> *parameters))handlerBlock;
```

2. Routing Analysis (These resolutions are directly related to the rules we set up routing)

(1) to determine whether the interface URL optional URL and the corresponding URL is encapsulated into JLRRouteDefinition object

(2) The JLRRouteDefinition object is loaded into a variable array, the memory retains all the objects! !

(JLRRouteDefinition object includes a path, parameter analysis, block and other information)

#### Single Scheme Calling Process:

1. Call URL

```Objective-C
+ (BOOL)routeURL:(NSURL *)URL
```

2. Parse the URL, the parameters, routing information package JLRRouteRequest object
```Objective-C
- (instancetype)initWithURL:(NSURL *)URL alwaysTreatsHostAsPathComponent:(BOOL)alwaysTreatsHostAsPathComponent
```

3. JLrouteRequest object and the routing array JLRRouteDefinition object for comparison, and return JLRRouteResponse object extraction parameters and URL in the array

```Objective-C
JLRRouteResponse *response = [route routeResponseForRequest:request decodePlusSymbols:shouldDecodePlusSymbols];
```

4. Call JLRRouteResponse object inside the callback method

```Objective-C
[route callHandlerBlockWithParameters:finalParameters];
```


#### JLRoutes URL Registration Rules:

![](http://og1yl0w9z.bkt.clouddn.com/18-2-7/87488105.jpg)

1. Ordinary registration

```Objective-C
JLRoutes *routes = [JLRoutes globalRoutes];
[routes addRoute:@"/user/view/:userID" handler:^BOOL(NSDictionary *parameters) {
NSString *userID = parameters[@"userID"]; // defined in the route by specifying ":userID"
// present UI for viewing user with ID 'userID'
return YES; // return YES to say we have handled the route
}];
```

In the URL, the semicolon indicates that this is a parameter

Another way to register, subscript registration

```Objective-C
JLRoutes.globalRoutes[@"/route/:param"] = ^BOOL(NSDictionary *parameters) {
// ...
};
```

How to register in the above way, you can call this URL at any time (including other APP).
```Objective-C
NSURL *viewUserURL = [NSURL URLWithString:@"myapp://user/view/joeldev"];
[[UIApplication sharedApplication] openURL:viewUserURL];
```

In this example, the userID in the parmameters dictionary is passed to the block, which is a key-value pair. "UserID": "joeldev". To the UI layer or any place that needs it.

Dictionary parameters:

The dictionary parameters always include at least three keys:

```Objective-C
{
"JLRouteURL":  "(the NSURL that caused this block to be fired)",
"JLRoutePattern": "(the actual route pattern string)",
"JLRouteScheme": "(the route scheme, defaults to JLRoutesGlobalRoutesScheme)"
}
```

Processing Block

You will find that each registered block will return a YES. This value, if you return NO, JLRoutes will skip this match, and then continue to match the other.

If your block is set to nil, it will return YES by default.

 

2. Complex registration

```Objective-C
[[JLRoutes globalRoutes] addRoute:@"/:object/:action/:primaryKey" handler:^BOOL(NSDictionary *parameters) {
NSString *object = parameters[@"object"];
NSString *action = parameters[@"action"];
NSString *primaryKey = parameters[@"primaryKey"];
// stuff
return YES;
}];
```

This address will be matched to many URLs like / user / view / joeldev or / post / edit / 123. These URLs are parameters.

```Objective-C
NSURL *editPost = [NSURL URLWithString:@"myapp://post/edit/123?debug=true&foo=bar"];
[[UIApplication sharedApplication] openURL:editPost];
```

At this time, pramater dictionary will be the following (pass reference)

```Objective-C
{
"object": "post",
"action": "edit",
"primaryKey": "123",
"debug": "true",
"foo": "bar",
"JLRouteURL": "myapp://post/edit/123?debug=true&foo=bar",
"JLRoutePattern": "/:object/:action/:primaryKey",
"JLRouteScheme": "JLRoutesGlobalRoutesScheme"
}
```

3.Scheme (there is no feeling of polymorphism)

JLRoutes supports routing with the specified URL scheme. The same scheme can be matched. By default, all URLs are set to global scheme.
```Objective-C
[[JLRoutes globalRoutes] addRoute:@"/foo" handler:^BOOL(NSDictionary *parameters) {
// This block is called if the scheme is not 'thing' or 'stuff' (see below)
return YES;
}];
[[JLRoutes routesForScheme:@"thing"] addRoute:@"/foo" handler:^BOOL(NSDictionary *parameters) {
// This block is called for thing://foo
return YES;
}];
[[JLRoutes routesForScheme:@"stuff"] addRoute:@"/foo" handler:^BOOL(NSDictionary *parameters) {
// This block is called for stuff://foo
return YES;
}];
```

If you call the use of this is called

```Objective-C
[[JLRoutes globalRoutes] addRoute:@"/global" handler:^BOOL(NSDictionary *parameters) {
return YES;
}];
```

It will only call the corresponding URL of the global scheme. Will not call the ting scheme inside the corresponding URL.

Of course, you can set, if the specified scheme does not have this URL, to check the global scheme. You need to set a property.

```Objective-C
[JLRoutes routesForScheme:@"thing"].shouldFallbackToGlobalRoutes = YES;
```

3. How to set the URL of the wildcard

Wildcards are: *

All parameters on the URL after the wildcard character are stored as an array in the value corresponding to JLRouteWildcardComponentsKey in the parameters dictionary.

For example, if your registration URL is as follows:

```Objective-C
[[JLRoutes globalRoutes] addRoute:@"/wildcard/*" handler:^BOOL(NSDictionary *parameters) {
NSArray *pathComponents = parameters[JLRouteWildcardComponentsKey];
if ([pathComponents count] > 0 && [pathComponents[0] isEqualToString:@"joker"]) {
// the route matched; do stuff
return YES;
}
// not interested unless the joker's in it
return NO;
}];
```

If the calling URL starts with / wildcard, the route may be triggered! ! If the first parameter is joker, it will be triggered, if not, it will be rejected. . .

4. Selective routing

If the routing address is set in brackets, for example: / the (/ foo /: a) (/ bar /: b), in fact it represents the URL as follows:

```Objective-C
/the/foo/:a/bar/:b
/the/foo/:a
/the/bar/:b
/the
```

5. Query Routes

In the following way, you can view all registered URL Routes in Routes.

```Objective-C
/// All registered routes, keyed by scheme
+ (NSDictionary <NSString *, NSArray <JLRRouteDefinition *> *> *)allRoutes;
/// Return all registered routes in the receiving scheme namespace.
- (NSArray <JLRRouteDefinition *> *)routes;
```

Custom routing resolution
If you want to customize a route editor yourself, you can extend the JLRouteDefinition and add your custom class objects using the addRoute: method.

----
### 📝 Submission

JLRoutes：https://github.com/joeldev/JLRoutes

JLRoutes资料博客：https://www.varsiri.com/archives/305

----
### ⚖ License

```
MIT License

Copyright (c) 2017 ReverseScale

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

----
### 😬 Contributions

* 微信 : WhatsXie
* 邮件 : ReverseScale@iCloud.com
* 博客 : https://reversescale.github.io
