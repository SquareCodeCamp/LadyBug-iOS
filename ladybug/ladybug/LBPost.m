//
//  LBPost.m
//  ladybug
//
//  Created by square on 1/10/14.
//  Copyright (c) 2014 square. All rights reserved.
//

#import "LBPost.h"

@implementation LBPost
-(id)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if (self){
        LBUser * user = [[LBUser alloc] init];
        user.name = @"blah mcblaberson";
        user.city = @"San Francisco";
        user.pic = [UIImage imageNamed:@"bri.jpg"];
        self.content = @"I like to do things";
        self.user = user;
    }
    return self;
}

@end
