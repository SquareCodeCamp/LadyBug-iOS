//
//  LBPosts.h
//  ladybug
//
//  Created by square on 1/10/14.
//  Copyright (c) 2014 square. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LBPost.h"

@interface LBPosts : NSObject

@property (strong, nonatomic) NSArray * postsArray;

-(void)updatePosts:(NSData *)jsonData;

@end
