//
//  InboxViewControllerTableViewController.h
//  Ribbit
//
//  Created by Lailei Huang on 16/07/2014.
//  Copyright (c) 2014 alex.huang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InboxViewControllerTableViewController : UITableViewController


@property (nonatomic,strong) NSArray *messages;
- (IBAction)logout:(id)sender;

@end
