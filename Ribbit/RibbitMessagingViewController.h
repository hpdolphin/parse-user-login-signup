//
//  RibbitMessagingViewController.h
//  Ribbit
//
//  Created by Lailei Huang on 29/07/2014.
//  Copyright (c) 2014 alex.huang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RibbitMessagingViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextView *messageInputView;
- (IBAction)cancel:(id)sender;
- (IBAction)send:(id)sender;

@end
