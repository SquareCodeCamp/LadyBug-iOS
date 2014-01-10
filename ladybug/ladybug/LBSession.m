//
//  LBSession.m
//  ladybug
//
//  Created by square on 1/10/14.
//  Copyright (c) 2014 square. All rights reserved.
//

#import "LBSession.h"

@implementation LBSession
+ (LBSession*) defaultSession{
    static LBSession *defaultSession;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultSession=[[LBSession alloc ] init];
    });
    return defaultSession;
}
@end
