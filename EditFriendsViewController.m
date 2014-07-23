//
//  EditFriendsViewController.m
//  Ribbit
//
//  Created by Lailei Huang on 23/07/2014.
//  Copyright (c) 2014 alex.huang. All rights reserved.
//

#import "EditFriendsViewController.h"
#import "FriendsStore.h"

@interface EditFriendsViewController ()

@end

@implementation EditFriendsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    PFQuery *query = [PFUser query];
    [query orderByAscending:@"username"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"Error: %@ %@",error,[error userInfo]);
        }else{
            self.allUsers = objects;
            //NSLog(@"%@",self.allUsers);
            [self.tableView reloadData];
        }
    }];
    
    self.currentUser = [PFUser currentUser];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{    // Return the number of rows in the section.
    return [self.allUsers count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    //Configure the cell...
    PFUser *user = [self.allUsers objectAtIndex:indexPath.row];
    cell.textLabel.text = user.username;
    
    //add checkmark if the user is part of the friends
    //NSLog(@"Friends number:%d",[[[FriendsStore sharedStore] friends] count]);
    //NSArray *myfriends = [[FriendsStore sharedStore] friends];
    
    if ([[FriendsStore sharedStore] isAFriend:user.username]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        //clear the checkmark for preventing cell reusing
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

//tap a row (cell) and get called
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    //create a new relation with the current user
    PFRelation *friendsRelation = [self.currentUser relationForKey:@"friendsRelation"];
    PFUser *user = [self.allUsers objectAtIndex:indexPath.row];
    [friendsRelation addObject:user];
    
    //save the added relation to the back end
    [self.currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error) {
            NSLog(@"Error: %@ %@",error,[error userInfo]);
        }else{
            NSLog(@"save friendsRelation with %@",user[@"username"]);
        }
    }];
}

@end
