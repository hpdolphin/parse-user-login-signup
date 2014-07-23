//
//  EditFriendsViewController.h
//  Ribbit
//
//  Created by Lailei Huang on 23/07/2014.
//  Copyright (c) 2014 alex.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface EditFriendsViewController : UITableViewController

@property (nonatomic,strong) NSArray *allUsers;
@property (nonatomic,strong) PFUser *currentUser;

@end
