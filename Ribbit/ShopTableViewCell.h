//
//  ShopTableViewCell.h
//  Ribbit
//
//  Created by Lailei Huang on 18/07/2014.
//  Copyright (c) 2014 alex.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface ShopTableViewCell : UITableViewCell //PFTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *productImageField;
@property (weak, nonatomic) IBOutlet UILabel *productTitleField;
@property (weak, nonatomic) IBOutlet UIButton *orderButton;
@property (weak, nonatomic) IBOutlet UILabel *productPriceField;

- (IBAction)clickOrder:(id)sender;

@end
