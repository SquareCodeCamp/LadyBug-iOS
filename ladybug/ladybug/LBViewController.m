//
//  LBViewController.m
//  ladybug
//
//  Created by square on 1/10/14.
//  Copyright (c) 2014 square. All rights reserved.
//

#import "LBViewController.h"
#import "LBNewsfeedViewController.h"

@interface LBViewController ()

@end

@implementation LBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //add action for segmented control click
    [self.segmentControl addTarget:self
                         action:@selector(pickOne:)
               forControlEvents:UIControlEventValueChanged];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) pickOne:(id)sender{
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    //change the view
    //1. newsfeed, 2. people, 3. profile
    if ([segmentedControl selectedSegmentIndex] == 0){
        //init view controller with nib
        if (!self.newsfeedViewController){
        self.newsfeedViewController = [[LBNewsfeedViewController alloc] initWithNibName:@"LBNewsfeedViewController" bundle:nil];

        }
        [self.containerView addSubview:self.newsfeedViewController.view];
    }
    
    if ([segmentedControl selectedSegmentIndex] == 1){
        //init view controller with nib
        if (!self.peopleViewController){
            self.peopleViewController = [[LBPeopleViewController alloc] initWithNibName:@"LBPeopleViewController" bundle:nil];
        }
        [self.containerView addSubview:self.peopleViewController.view];
    }
    
    if ([segmentedControl selectedSegmentIndex] == 2){
        //init view controller with nib
        if (!self.profileViewController){
            self.profileViewController = [[LBProfileViewController alloc] initWithNibName:@"LBProfileViewController" bundle:nil];
        }
        [self.containerView addSubview:self.profileViewController.view];
    }
}

@end
