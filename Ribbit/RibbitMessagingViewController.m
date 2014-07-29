//
//  RibbitMessagingViewController.m
//  Ribbit
//
//  Created by Lailei Huang on 29/07/2014.
//  Copyright (c) 2014 alex.huang. All rights reserved.
//

#import "RibbitMessagingViewController.h"

@interface RibbitMessagingViewController ()

@end

@implementation RibbitMessagingViewController

@synthesize targetName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        targetName = @"";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated{
    NSLog(@"RibbitMessagingViewController loaded, prepare to send message to %@",targetName);
    _messageInputView.text = @"";
}

- (IBAction)backgroundTapped:(id)sender {
    [_messageInputView resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancel:(id)sender {
}

- (IBAction)send:(id)sender {
    if (![targetName isEqualToString:@""]) {
        PFPush *push = [[PFPush alloc] init];
        [push setChannel:targetName];
        [push setMessage:_messageInputView.text];
        [push sendPushInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!succeeded) {
                NSLog(@"fail to send a message to %@",targetName);
            }
        }];
    }
}

@end


