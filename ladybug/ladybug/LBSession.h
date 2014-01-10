//
//  LBSession.h
//  ladybug
//
//  Created by square on 1/10/14.
//  Copyright (c) 2014 square. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBSession : NSObject
@property (strong, nonatomic) NSString *sessionID;
+(LBSession *)defaultSession;
- (void) composePost:(NSString *) content;

@end
