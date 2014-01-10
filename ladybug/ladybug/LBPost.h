//
//  LBPost.h
//  ladybug
//
//  Created by square on 1/10/14.
//  Copyright (c) 2014 square. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LBUser.h"

@interface LBPost : NSObject
@property (strong, nonatomic) LBUser * user;
@property (strong, nonatomic) NSString * content;
@property (strong, nonatomic) NSString * timestamp;
@property (strong, nonatomic) CLLocation * location;
-(id) initWithDictionary:(NSDictionary *)dictionary;

@end
