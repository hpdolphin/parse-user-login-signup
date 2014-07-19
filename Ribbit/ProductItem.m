//
//  ProductItem.m
//  Ribbit
//
//  Created by Lailei Huang on 19/07/2014.
//  Copyright (c) 2014 alex.huang. All rights reserved.
//

#import "ProductItem.h"

@implementation ProductItem

@synthesize title,price,imageFile;

-(instancetype)initWithTitle:(NSString *)tit price:(NSNumber *)pri andImageFile:(PFFile *)img{
    self = [super init];
    title = tit;
    price = pri;
    imageFile = img;
    return self;
}

@end
