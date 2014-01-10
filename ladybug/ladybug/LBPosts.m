//
//  LBPosts.m
//  ladybug
//
//  Created by square on 1/10/14.
//  Copyright (c) 2014 square. All rights reserved.
//

#import "LBPosts.h"

@implementation LBPosts
-(void)updatePosts:(NSData *)jsonData{
    NSArray * posts = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    NSMutableArray * newsfeedPosts = [[NSMutableArray alloc] init];
    for(NSDictionary * dictionary in posts){
        LBPost * post = [[LBPost alloc] initWithDictionary:dictionary];
        [newsfeedPosts addObject:post];
    }
    LBPost * post = [[LBPost alloc] initWithDictionary:nil];
    [newsfeedPosts addObject:post];
    self.postsArray = newsfeedPosts; 
}
@end
