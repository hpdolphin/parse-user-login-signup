//
//  InboxViewControllerTableViewController.m
//  Ribbit
//
//  Created by Lailei Huang on 16/07/2014.
//  Copyright (c) 2014 alex.huang. All rights reserved.
//

#import "InboxViewControllerTableViewController.h"
#import <Parse/Parse.h>

@interface InboxViewControllerTableViewController ()

@end

@implementation InboxViewControllerTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    PFUser *currentUser = [PFUser currentUser];
    if(currentUser){
        //NSLog(@"Current user: %@",currentUser.username);
    }else{
        [self performSegueWithIdentifier:@"showLogin" sender:self];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Messages"];
    //only my id is in recipients
    [query whereKey:@"recipientIds" equalTo:[[PFUser currentUser] objectId]];
    [query orderByDescending:@"createdAt"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"Error: %@ %@",error,[error userInfo]);
        }else{
            // message found
            self.messages = objects;
            [self.tableView reloadData];
            NSLog(@"Retrived %d messages",[self.messages count]);
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.messages count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    PFObject *message = [_messages objectAtIndex:indexPath.row];
    cell.textLabel.text = [message objectForKey:@"senderName"];
    
    NSString *fileType = [message objectForKey:@"fileType"];
    if ([fileType isEqualToString:@"image"]) {
        cell.imageView.image = [UIImage imageNamed:@"icon_image"];
    }else{
        cell.imageView.image = [UIImage imageNamed:@"icon_video"];
    }
    
    return cell;
}

- (IBAction)logout:(id)sender {
    [PFUser logOut];
    [self performSegueWithIdentifier:@"showLogin" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"showLogin"]){
        [segue.destinationViewController setHidesBottomBarWhenPushed:YES];
    }
}

@end
