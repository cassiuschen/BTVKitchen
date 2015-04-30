//
//  AppDelegate.m
//  BTVKichen
//
//  Created by 夏 子皓 on 14/11/16.
//  Copyright (c) 2014年 com.seaver. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <AVOSCloud/AVOSCloud.h>

@interface AppDelegate ()
@end

@implementation AppDelegate
NSString *urlParams;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [AVOSCloud setApplicationId:@"4q5lj4x9fb41lpzl76ara0t4twp4ebjdokeptw6evd9iuhfu"
                      clientKey:@"xmieotk7xgofub983uedxr4osicyk1ag2jn5adm2f3593aua"];
    [AVAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
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

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    // btvkitchen://
    urlParams = url.absoluteString;
    NSLog(@"GET VISIT FROM PAGE:%@, length: %lu  \n", [urlParams substringFromIndex:13], (unsigned long)[[urlParams substringFromIndex:13] length]);
    if((unsigned long)[[urlParams substringFromIndex:13] length] > 0) {
        //[ViewController* rootView];
    }
    return YES;
}

@end
