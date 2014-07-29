//
//  FriendsViewController.m
//  Ribbit
//
//  Created by Lailei Huang on 23/07/2014.
//  Copyright (c) 2014 alex.huang. All rights reserved.
//

#import "FriendsViewController.h"
#import "FriendsStore.h"

@interface FriendsViewController ()

-(void)showFriends;

@end

@implementation FriendsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //_messagingViewController = [[UIViewController alloc] init];
    _messagingViewController = [[RibbitMessagingViewController alloc] init];
    
    self.friendsRelation = [[PFUser currentUser] objectForKey:@"friendsRelation"];
    [self showFriends];
}

-(void)viewWillAppear:(BOOL)animated{
    [self showFriends];
}

-(void)showFriends{
    
    if([self.friends count]==0){
        PFQuery *query = [self.friendsRelation query];
        [query orderByAscending:@"username"];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (error) {
                NSLog(@"Error %@ %@",error,[error userInfo]);
            }else{
                self.friends = objects;
                //save loaded friends
                FriendsStore *friendsStore = [FriendsStore sharedStore];
                friendsStore.friends = self.friends;
                
                //NSLog(@"Load %d friends",[objects count]);
                [self.tableView reloadData];
            }
        }];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.friends count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    PFUser *user = [self.friends objectAtIndex:indexPath.row];
    cell.textLabel.text = user.username;
    
    return cell;
}

#pragma mark - Table view delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //geth the user
    
    //Pop up messaging view
    [self.navigationController pushViewController:_messagingViewController animated:YES];
}

@end
