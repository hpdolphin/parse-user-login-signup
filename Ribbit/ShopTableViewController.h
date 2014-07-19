//
//  ShopTableViewController.h
//  Ribbit
//
//  Created by Lailei Huang on 18/07/2014.
//  Copyright (c) 2014 alex.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

//@interface ShopTableViewController : PFQueryTableViewController <UIPickerViewDataSource, UIPickerViewDelegate>
@interface ShopTableViewController : UITableViewController <UITableViewDataSource>
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *loadIndicator;

-(id)initWithStyle:(UITableViewStyle)style;

@end
