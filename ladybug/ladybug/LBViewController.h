//
//  LBViewController.h
//  ladybug
//
//  Created by square on 1/10/14.
//  Copyright (c) 2014 square. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBNewsfeedViewController.h"
#import "LBPeopleViewController.h"
#import "LBProfileViewController.h"

@interface LBViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) LBNewsfeedViewController * newsfeedViewController;
@property (strong, nonatomic) LBPeopleViewController * peopleViewController;
@property (strong, nonatomic) LBProfileViewController * profileViewController;


@end
