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
    if ([self.privateItems count] !=0) {
        return; //already loaded
    }
    
    PFQuery *query = [PFQuery queryWithClassName:@"Item"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            //The find succeeded
            for (PFObject *object in objects) {
                
                NSString *title = object[@"description"];
                NSNumber *price = object[@"price"];
                PFFile *imageData = object[@"image"];
                
                ProductItem *oneItem = [[ProductItem alloc] initWithTitle:title price:price andImageFile:imageData];
                [self.privateItems addObject:oneItem];
                
                //NSLog(@"Title:%@, Price:%@, Image:%@",title,price,imageData);
            }
        }else{
            @throw [NSException exceptionWithName:@"Load Data" reason:@"Can't load product item data from Parse" userInfo:nil];
        }
    }];
}

-(int)count{
    return [self.privateItems count];
}

@end
