//
//  AppDelegate.m
//  亿利MIS
//
//  Created by WangZhengHong on 15/9/18.
//  Copyright © 2015年 WangZhengHong. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"

#import "NewsViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    
    
    
    NewsViewController *newsVc =[[NewsViewController alloc]init];
    UIImage * NewsImage1= [UIImage imageNamed:@"tab_shouye@2x"];
    UIImage * NewsImage2= [UIImage imageNamed:@"tab_shouye@2x"];
    newsVc.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"首页" image:NewsImage1 selectedImage:NewsImage2];
    
    
//    UINavigationController * rootNc = [[UINavigationController alloc]initWithRootViewController:newsVc];
//    rootNc.title=@"新闻";
    RootViewController * MoreVc =[[RootViewController alloc]init];
    
    UIImage * setImage1= [UIImage imageNamed:@"tech_edit@2x"];
    UIImage * setImage2= [UIImage imageNamed:@"tech_edit@2x"];
    MoreVc.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"常用" image:setImage1 selectedImage:setImage2];

    
    
//    ViewController *aboutVc =[[ViewController alloc]init];
//    UIImage * MoreImage1= [UIImage imageNamed:@"More@2x.png"];
//    UIImage * MoreImage2= [UIImage imageNamed:@"More@2x.png"];
//    aboutVc.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"关于" image:MoreImage1 selectedImage:MoreImage2];
//
    UITabBarController * tabController=[[UITabBarController alloc]init];
    tabController.viewControllers=[NSArray arrayWithObjects:newsVc,MoreVc, nil];
    
    
    self.window.rootViewController=tabController;
    
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
