//
//  AppDelegate.m
//  MyCrime
//
//  Created by mini2 on 15/7/27.
//  Copyright (c) 2015年 yzy. All rights reserved.
//

#import "AppDelegate.h"
#import "MyCrime.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (id)init {
    self = [super init];
    if (self) {
        _crimeLab = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i<100; i++) {
            MyCrime *crime = [[MyCrime alloc] init];
            crime.title = [NSString stringWithFormat:@"MyCrime #%@",@(i)];
            crime.isChecked = i % 2;
            crime.date = [NSDate date];
            [_crimeLab addObject:crime];
        }
    }
    return self;
}

- (void)showModal:(UIViewController *)controller {
//    self.window.rootView
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:self.window.rootViewController];
    self.window.rootViewController = controller;
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
