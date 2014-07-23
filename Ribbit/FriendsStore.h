//
//  FriendsStore.h
//  Ribbit
//
//  Created by Lailei Huang on 23/07/2014.
//  Copyright (c) 2014 alex.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendsStore : NSObject

@property (nonatomic,strong) NSArray *friends;

+(instancetype)sharedStore;

-(BOOL)isAFriend:(NSString *)name;

@end
