//
//  AppDelegate.m
//  ChatDemo
//
//  Created by Jerry on 2018/3/12.
//  Copyright © 2018年 xuPeng. All rights reserved.
//

#import "AppDelegate.h"
#import "FriendsViewController.h"
#import <Hyphenate/Hyphenate.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    EMOptions *options = [EMOptions optionsWithAppkey:@"easemob-demo#chatdemoui"];
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    
    FriendsViewController *friendVC = [[FriendsViewController alloc] init];
    UINavigationController *friendNVC = [[UINavigationController alloc] initWithRootViewController:friendVC];
    self.window.rootViewController = friendNVC;
    
    [self loginEM];
    return YES;
}

- (void)loginEM{
    [[EMClient sharedClient] loginWithUsername:@"8002"
                                      password:@"111111"
                                    completion:^(NSString *aUsername, EMError *aError) {
                                        if (!aError) {
                                            NSLog(@"登录成功");
                                        } else {
                                            NSLog(@"登录失败");
                                        }
                                    }];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[EMClient sharedClient] applicationDidEnterBackground:application];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[EMClient sharedClient] applicationWillEnterForeground:application];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
