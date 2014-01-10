//
//  LBUser.h
//  ladybug
//
//  Created by square on 1/10/14.
//  Copyright (c) 2014 square. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface LBUser : NSObject
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) CLLocation *location;
@property (strong, nonatomic) UIImage *pic;
@property (strong, nonatomic) NSString *bio;
@property (strong, nonatomic) NSString *github;


@end
