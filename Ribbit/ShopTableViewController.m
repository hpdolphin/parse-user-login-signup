//
//  ShopTableViewController.m
//  Ribbit
//
//  Created by Lailei Huang on 18/07/2014.
//  Copyright (c) 2014 alex.huang. All rights reserved.
//

#import "ShopTableViewController.h"
#import "ShopTableViewCell.h"
#import "ProductItemStore.h"
#import "ProductItem.h"


@interface ShopTableViewController ()

@end

@implementation ShopTableViewController

@synthesize loadIndicator;

- (id)init{
    self = [super init];
    loadIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    return self;
}

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
    [loadIndicator startAnimating];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated{
    //ProductItemStore *productStore = [ProductItemStore sharedStore];
    //NSLog(@"%d data unit(s) loaded",[productStore count]);
    //reload the table, due the possibility product is loading
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    ProductItemStore *productStore = [ProductItemStore sharedStore];
    return [productStore count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     ShopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProductItemCell"];
    //Obtain one productItem from the store
    ProductItemStore *productStore = [ProductItemStore sharedStore];
    //NSLog(@"Total %d items",[productStore count]);
    if ([productStore count]!= 0) {
        //Construct one cell from the productItem
        ProductItem *oneItem = [productStore.allItems objectAtIndex:indexPath.row];
        
        //NSLog(@"Try construct a cell for:%@",oneItem.title);
        
        cell.productTitleField.text = oneItem.title;
        cell.productPriceField.text = [NSString stringWithFormat:@"$ %@",oneItem.price];
        //get the image from Parse
        //cell.productImageField.image = [UIImage imageNamed:@"camera.png"];
        cell.productImageField.image = [UIImage imageWithData:oneItem.imageData];
        //NSLog(@"Image Data for %@ is %@.",oneItem.title,oneItem.imageData);
    }
    
    //return the cell to the table view
    return cell;
}

@end
