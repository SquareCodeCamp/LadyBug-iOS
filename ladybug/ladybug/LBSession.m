//
//  LBSession.m
//  ladybug
//
//  Created by square on 1/10/14.
//  Copyright (c) 2014 square. All rights reserved.
//

#import "LBSession.h"

@interface LBSession()
@property NSOperationQueue* postQueue;
@end

@implementation LBSession
+ (LBSession*) defaultSession{
    static LBSession *defaultSession;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultSession=[[LBSession alloc ] init];
    });
    return defaultSession;
}
- (void) composePost:(NSString *) content{
    NSMutableURLRequest * request= [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://codecamp-ladybug.herokuapp.com"]];
    NSDictionary * body=@{@"token": [LBSession defaultSession].sessionID, @"post": @{@"content": content}};
    NSData* json=[NSJSONSerialization dataWithJSONObject:body options:0 error:0];
    [request setHTTPBody: json];
    [request setHTTPMethod:@"POST"];
    [NSURLConnection sendAsynchronousRequest:request  queue:self.postQueue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        
           }];

}
@end
