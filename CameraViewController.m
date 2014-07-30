//
//  CameraViewController.m
//  Ribbit
//
//  Created by Lailei Huang on 30/07/2014.
//  Copyright (c) 2014 alex.huang. All rights reserved.
//

#import "CameraViewController.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import "FriendsStore.h"

@interface CameraViewController ()

@end

@implementation CameraViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _friendsRelation = [[PFUser currentUser] objectForKey:@"friendsRelation"];
    _recipents = [[NSMutableArray alloc] init];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //show list of friends
    [self showFriends];
    
    if (self.image == nil && self.videoFilePath.length ==0) {
        _imagePicker = [[UIImagePickerController alloc] init];
        _imagePicker.delegate = self;

        _imagePicker.allowsEditing = NO;
        _imagePicker.videoMaximumDuration = 10; //only 10 sec

        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            _imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
        _imagePicker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:_imagePicker.sourceType];

        [self presentViewController:_imagePicker animated:NO completion:nil];
    }
}

#pragma mark - ImagePickerControllerDelegate

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:NO completion:nil];
    
    //switch to the first tab
    [self.tabBarController setSelectedIndex:0];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:(NSString*)kUTTypeImage]) {
        //a photo was taken / selected
        self.image = [info objectForKey:UIImagePickerControllerOriginalImage];
        if (self.imagePicker.sourceType == UIImagePickerControllerSourceTypeCamera) {
            //save the image
            UIImageWriteToSavedPhotosAlbum(_image, nil, nil, nil);
        }
    }else{
        //a video is taken or selected
        //self.videoFilePath = [[info objectForKey:UIImagePickerControllerMediaURL] path];
        NSURL *imagePickerURL = [info objectForKey:UIImagePickerControllerMediaURL];
        self.videoFilePath = [imagePickerURL path];
        
        if (self.imagePicker.sourceType == UIImagePickerControllerSourceTypeCamera) {
            //save the video
            if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(_videoFilePath)) {
                UISaveVideoAtPathToSavedPhotosAlbum(_videoFilePath, nil, nil, nil);
            }
        }
    }
    [self dismissViewControllerAnimated:YES completion:nil];
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
    return [_friends count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    PFUser *user = [self.friends objectAtIndex:indexPath.row];
    cell.textLabel.text = user.username;
    
    if ([self.recipents containsObject:user.objectId]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

#pragma mark - Table view delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    PFUser *user = [self.friends objectAtIndex:indexPath.row];
    
    if (cell.accessoryType == UITableViewCellAccessoryNone) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [_recipents addObject:user.objectId];
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
        [self.recipents removeObject:user.objectId];
    }
    
    //NSLog(@"%@",_recipents);
}

#pragma mark - assistant method
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

// Check if image or video
// If image, shrink it
// Upload the file
// Upload the message details
-(void)uploadMessage{
    NSData *fileData;
    NSString *fileName;
    NSString *fileType;
    
    if (self.image != nil) {
        UIImage *newImage = [self resizeImage:_image toWidth:320.0f andHeight:480.0f];
        fileData = UIImagePNGRepresentation(newImage);
        fileName = @"image.png";
        fileType = @"image";
    }else{
        fileData = [NSData dataWithContentsOfFile:self.videoFilePath];
        fileName = @"video.mov";
        fileType = @"video";
    }
    
    PFFile *file = [PFFile fileWithName:fileName data:fileData];
    [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        if (error) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"An error occured" message:@"Please try sending your message again!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }else{
            PFObject *message = [PFObject objectWithClassName:@"Messages"];
            [message setObject:file forKey:@"file"];
            [message setObject:fileType forKey:@"fileType"];
            [message setObject:self.recipents forKey:@"recipientIds"];
            [message setObject:[[PFUser currentUser] objectId] forKey:@"senderId"];
            [message setObject:[[PFUser currentUser] username] forKey:@"senderName"];
            
            [message saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (error) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"An error occured" message:@"Please try sending your message again!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                }else{
                    //Everything was successful
                    [self reset];
                    NSLog(@"Successful saved!");
                }
            }];
        }
    }];
}

-(void)reset{
    self.image = nil;
    self.videoFilePath = nil;
    [self.recipents removeAllObjects];
}

- (UIImage *)resizeImage:(UIImage *)image toWidth:(float)width andHeight:(float)height{
    CGSize newSize = CGSizeMake(width, height);
    CGRect newRectangle = CGRectMake(0, 0, width, height);
    
    UIGraphicsBeginImageContext(newSize);
    [self.image drawInRect:newRectangle];
    
    UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resizedImage;
}

#pragma - IBAction

- (IBAction)cancel:(id)sender {
    [self reset];
    //move to inbox
    [self.tabBarController setSelectedIndex:0];
}

- (IBAction)send:(id)sender {
    if (_image == nil && _videoFilePath.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Try again" message:@"Please select or take a picture or video!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [self presentViewController:_imagePicker animated:YES completion:nil];
    }else{
        [self uploadMessage];
        //[self reset];
        [self.tabBarController setSelectedIndex:0];
    }
}
@end
