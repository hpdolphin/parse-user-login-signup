//
//  ProductItemStoreDelegate.h
//  Ribbit
//
//  Created by Lailei Huang on 20/07/2014.
//  Copyright (c) 2014 alex.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ProductItemStoreDelegate <NSObject>

@required
//one item loading from parse finished
-(void)itemLoadingFinished:(NSString*)itemTitle;

//all items loading finished
-(void)allItemsLoadingFinished;

@end
