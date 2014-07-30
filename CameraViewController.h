//
//  CameraViewController.h
//  Ribbit
//
//  Created by Lailei Huang on 30/07/2014.
//  Copyright (c) 2014 alex.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface CameraViewController : UITableViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong,nonatomic) UIImagePickerController *imagePicker;
@property (strong, nonatomic) UIImage *image;
@property (strong,nonatomic) NSString *videoFilePath;

@property (nonatomic,strong) PFRelation *friendsRelation;
@property (nonatomic,strong) NSArray *friends;

@property (nonatomic,strong) NSMutableArray *recipents;

- (IBAction)cancel:(id)sender;
- (IBAction)send:(id)sender;
- (void)uploadMessage;

- (UIImage *)resizeImage:(UIImage *)image toWidth:(float)width andHeight:(float)height;

@end
