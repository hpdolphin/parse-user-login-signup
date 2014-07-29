//
//  RAAppDelegate.m
//  Ribbit
//
//  Created by Lailei Huang on 16/07/2014.
//  Copyright (c) 2014 alex.huang. All rights reserved.
//

#import "RAAppDelegate.h"
#import <Parse/Parse.h>
#import "TabBarControllerDelegate.h"

@implementation RAAppDelegate

@synthesize tabBarControllerDelegate;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    [Parse setApplicationId:infoDictionary[@"PARSE_APPLICATION_ID"]
                  clientKey:infoDictionary[@"PARSE_CLIENT_KEY"]];
    //NSLog(@"Parse App ID:%@",infoDictionary[@"PARSE_APPLICATION_ID"]);
    
    //[Parse setApplicationId:@"fXzhkOaiiU5eVbVJNBGsCSvnezXfXlnfHxNuvFaG"
    //              clientKey:@"QR8C3mJi7la2hVWW6OuVEtIljuZWGQw0l5wrAU21"];
    
    // Register for push notifications
    [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert|
                                                    UIRemoteNotificationTypeBadge|
                                                    UIRemoteNotificationTypeSound];
    
    //hook the tab bar delegate
    tabBarControllerDelegate = [[TabBarControllerDelegate alloc] init];
    UITabBarController *rootController = (UITabBarController*)self.window.rootViewController;
    rootController.delegate = tabBarControllerDelegate;
    
    return YES;
}

-(void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    // Store the deviceToken in the current installation and save it to Parse
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    
    // Subscribe to the Channel name as own Email
    PFUser *currentUser = [PFUser currentUser];
    if(currentUser){
        //NSLog(@"User's name is %@",currentUser.username);
        [currentInstallation addUniqueObject:currentUser.username forKey:@"channels"];
    }
    
    [currentInstallation saveInBackground];
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    [PFPush handlePush:userInfo];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
