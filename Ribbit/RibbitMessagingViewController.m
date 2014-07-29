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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSLog(@"RibbitMessagingViewController loaded");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancel:(id)sender {
}

- (IBAction)send:(id)sender {
}
@end
