//
//  FriendsViewController.h
//  Ribbit
//
//  Created by Lailei Huang on 23/07/2014.
//  Copyright (c) 2014 alex.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "RibbitMessagingViewController.h"

@interface FriendsViewController : UITableViewController <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) PFRelation *friendsRelation;
@property (nonatomic,strong) NSArray *friends;
@property (nonatomic,strong) RibbitMessagingViewController *messagingViewController;

@end
