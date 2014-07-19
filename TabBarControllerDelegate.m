//
//  TabBarControllerDelegate.m
//  Ribbit
//
//  Created by Lailei Huang on 18/07/2014.
//  Copyright (c) 2014 alex.huang. All rights reserved.
//

#import "TabBarControllerDelegate.h"
#import "ProductItemStore.h"

@implementation TabBarControllerDelegate

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    NSUInteger index = [tabBarController.viewControllers indexOfObject:viewController];
    //NSLog(@"Select tab %d",index);
    //if shop tab is selected, fetch data from Parse to prepare the datasource for the ShopTableViewController
    if (index == 3) {
        //Shop tab tapped
        ProductItemStore *productStore = [ProductItemStore sharedStore];
        if ([productStore count]==0) {
            NSLog(@"no data yet, now load from Parse...");
            [productStore loadData];
            //asynchronous code, will load progressively
            //NSLog(@"%d data unit(s) loaded",[productStore count]);
        }
    }
}

@end
