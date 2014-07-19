//
//  ProductItem.h
//  Ribbit
//
//  Created by Lailei Huang on 19/07/2014.
//  Copyright (c) 2014 alex.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface ProductItem : NSObject

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSNumber *price;
@property (nonatomic,strong) PFFile *imageFile;

-(instancetype)initWithTitle:(NSString *)tit price:(NSNumber *)pri andImageFile:(PFFile *)img;

@end
