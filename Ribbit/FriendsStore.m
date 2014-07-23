//
//  FriendsStore.m
//  Ribbit
//
//  Created by Lailei Huang on 23/07/2014.
//  Copyright (c) 2014 alex.huang. All rights reserved.
//

#import "FriendsStore.h"
#import <Parse/Parse.h>

@interface FriendsStore ()

@end

@implementation FriendsStore

@synthesize friends;

+(instancetype)sharedStore{
    static FriendsStore *sharedStore = nil;
    
    if (!sharedStore) {
        sharedStore = [[self alloc] initPrivate];
    }
    
    return sharedStore;
}

-(instancetype)initPrivate{
    self = [super init];
    if (self) {
    }
    return self;
}

-(BOOL)isAFriend:(NSString *)name{
    BOOL isfriend = false;
    
    for (PFUser *user in friends) {
        if ([name isEqualToString:user[@"username"]]) {
            return true;
        }
    }
    return isfriend;
}

@end
