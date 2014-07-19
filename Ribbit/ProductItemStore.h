//
//  ProductItemStore.h
//  Ribbit
//
//  Created by Lailei Huang on 19/07/2014.
//  Copyright (c) 2014 alex.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductItemStore : NSObject

@property (nonatomic,readonly) NSArray *allItems;

+(instancetype)sharedStore;

-(void)loadData;
-(int)count;

@end
