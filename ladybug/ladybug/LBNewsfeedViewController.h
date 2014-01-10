//
//  LBNewsfeedViewController.h
//  ladybug
//
//  Created by square on 1/10/14.
//  Copyright (c) 2014 square. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBNewsfeedViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) NSArray * tableData;


@end
