//
//  TabBarControllerDelegate.m
//  Ribbit
//
//  Created by Lailei Huang on 18/07/2014.
//  Copyright (c) 2014 alex.huang. All rights reserved.
//

#import "TabBarControllerDelegate.h"

@implementation TabBarControllerDelegate

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    NSUInteger index = [tabBarController.viewControllers indexOfObject:viewController];
    //NSLog(@"Select tab %d",index);
    //if shop tab is selected, fetch data from Parse to prepare the datasource for the ShopTableViewController
}

@end
