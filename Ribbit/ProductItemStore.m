//
//  ProductItemStore.m
//  Ribbit
//
//  Created by Lailei Huang on 19/07/2014.
//  Copyright (c) 2014 alex.huang. All rights reserved.
//

#import "ProductItemStore.h"
#import <Parse/Parse.h>
#import "ProductItem.h"

@interface ProductItemStore ()

//private properity here
@property (nonatomic) NSMutableArray *privateItems;
@property (nonatomic) BOOL isLoading;

@end

@implementation ProductItemStore

@synthesize allItems;

+(instancetype)sharedStore{
    static ProductItemStore *sharedStore = nil;
    
    if (!sharedStore) {
        sharedStore = [[self alloc] initPrivate];
    }
    
    return sharedStore;
}

-(instancetype)initPrivate{
    self = [super init];
    if (self) {
        _privateItems = [[NSMutableArray alloc] init];
        _isLoading = false;
    }
    return self;
}

//override allItems's getter
-(NSArray *)allItems{
    return self.privateItems;
}

// In case a programmer calls init
-(instancetype)init{
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use +[ProductItemStore sharedStore]" userInfo:nil];
    return nil;
}

// load data from Parse
-(void)loadData{
    if ([self.privateItems count] !=0 || self.isLoading==true) {
        return; //already loaded or is loading
    }
    self.isLoading = true;
    
    PFQuery *query = [PFQuery queryWithClassName:@"Item"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            //NSLog(@"Find %d items in total.",[objects count]);
            //The find succeeded
            for (PFObject *object in objects) {
                
                NSString *title = object[@"description"];
                NSNumber *price = object[@"price"];
                PFFile *imageFile = object[@"image"];
                
                ProductItem *oneItem = [[ProductItem alloc] initWithTitle:title price:price andImageFile:nil];
                
                //NSLog(@"try add %@",[oneItem title]);
                
                //Fetch image
                [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                    if (!error) {
                        [oneItem setImageData:data];
                        //all attributes settled
                        [self.privateItems addObject:oneItem];
                        NSLog(@"add %@",[oneItem title]);
                    }else{
                        @throw [NSException exceptionWithName:@"Load Data"
                                                       reason:[NSString stringWithFormat:@"Can't load %@ data from Parse",oneItem.title]
                                                     userInfo:nil];
                        NSLog(@"Can't add %@",[oneItem title]);
                    }
                } progressBlock:^(int percentDone) {
                    NSLog(@"load %@'s image, %d percent done.",title,percentDone);
                }];
                
                /*//get file syncronizly
                [oneItem setImageData:[imageFile getData]];
                [self.privateItems addObject:oneItem];*/
                
                //[self.privateItems addObject:oneItem];
                
                //NSLog(@"Title:%@, Price:%@, Image:%@",title,price,imageData);
            }
            
            //load finish
            
        }else{
            @throw [NSException exceptionWithName:@"Load Data" reason:@"Can't load product item data from Parse" userInfo:nil];
        }
    }];
}

-(int)count{
    return [self.privateItems count];
}

@end