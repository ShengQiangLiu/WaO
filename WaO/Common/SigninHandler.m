//
//  SiginHandler.m
//  ReactiveCocoaDemo
//
//  Created by admin on 15/9/12.
//  Copyright (c) 2015年 ShengQiangLiu. All rights reserved.
//

#import "SigninHandler.h"
#import "SignInViewController.h"


@implementation SigninHandler

+ (instancetype)sharedInstance {
    static SigninHandler *handler = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handler = [[[self class] alloc] init];
    });
    return handler;
}

- (void)setupLoginViewController {
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:[[SignInViewController alloc] init]];
    [self setupWindowWithController:navigationController];
}

//- (void)setupHomeViewController {
//    UITabBarController *tabViewController = [[UITabBarController alloc] init];
////    UIViewController <SQWaterfallViewControllerProtocol> *waterfallViewController = [[JSObjection defaultInjector] getObject:@protocol(SQWaterfallViewControllerProtocol)];
////    [waterfallViewController configureWithLatest];
//    SQWaterfallViewController *waterfallViewController = [[SQWaterfallViewController alloc] init];
//    SlideNavigationController *waterfallNavigationController = [[SlideNavigationController alloc] initWithRootViewController:waterfallViewController];
//    LeftMenuViewController *leftMenu=[[LeftMenuViewController alloc] init];
//    [SlideNavigationController sharedInstance].leftMenu = leftMenu;
//    [SlideNavigationController sharedInstance].menuRevealAnimationDuration=.18;
//
//    waterfallViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"最新" image:[UIImage imageNamed:@"latest"] tag:0];
//    
////    UIViewController <SQTagsViewControllerProtocol> *tagsViewController = [[JSObjection defaultInjector] getObject:@protocol(SQTagsViewControllerProtocol)];
//    SQTagsViewController *tagsViewController = [[SQTagsViewController alloc] init];
//    
//    UINavigationController *tagsNavigationController = [[UINavigationController alloc] initWithRootViewController:tagsViewController];
//    tagsViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"分类" image:[UIImage imageNamed:@"categories"] tag:1];
//    tagsViewController.title = @"分类";
//    
//    
////    UIViewController <SQSettingsViewControllerProtocol> *settingsViewController = [[JSObjection defaultInjector] getObject:@protocol(SQSettingsViewControllerProtocol)];
//    SQSettingsViewController *settingsViewController = [[SQSettingsViewController alloc] init];
//    settingsViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"设置" image:[UIImage imageNamed:@"settings"] tag:2];
//    
//    UINavigationController *settingsNavigationController = [[UINavigationController alloc] initWithRootViewController:settingsViewController];
//    settingsViewController.title = @"设置";
//    
//    tabViewController.viewControllers = @[waterfallNavigationController, tagsNavigationController, settingsNavigationController];
//    tabViewController.tabBar.backgroundImage = [UIImage imageFromContextWithColor:[UIColor lightRandom]];
//    tabViewController.tabBar.barStyle = UIBarStyleBlack;
//    
//    [self setupWindowWithController:tabViewController];
//}

- (void)setupWindowWithController:(UIViewController *)ctrl {
    UIWindow *window =  [[UIApplication sharedApplication].delegate window];
//    window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    window.backgroundColor = [UIColor whiteColor];
    [window makeKeyAndVisible];
    window.rootViewController = ctrl;
}

@end
