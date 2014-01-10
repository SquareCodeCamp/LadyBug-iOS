//
//  LBViewController.m
//  ladybug
//
//  Created by square on 1/10/14.
//  Copyright (c) 2014 square. All rights reserved.
//

#import "LBViewController.h"
#import "LBNewsfeedViewController.h"
#import "LBSession.h"
#import "LBLoginViewController.h"

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

    if (!self.newsfeedViewController){
        self.newsfeedViewController = [[LBNewsfeedViewController alloc] initWithNibName:@"LBNewsfeedViewController" bundle:nil];
        [self.newsfeedViewController.view setFrame:self.containerView.bounds];
    }
    [self.containerView addSubview:self.newsfeedViewController.view];
    

    
}
-(void) viewDidAppear:(BOOL)animated{
    if(![LBSession defaultSession].sessionID){
        [self presentViewController:[[LBLoginViewController alloc]init] animated:YES completion:nil];
        
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) pickOne:(id)sender{
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    [[self.containerView subviews]
     makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    //change the view
    //1. newsfeed, 2. people, 3. profile
    if ([segmentedControl selectedSegmentIndex] == 0){
        //init view controller with nib
        if (!self.newsfeedViewController){
            self.newsfeedViewController = [[LBNewsfeedViewController alloc] initWithNibName:@"LBNewsfeedViewController" bundle:nil];
            [self.newsfeedViewController.view setFrame:self.containerView.bounds];
        }
        [self.containerView addSubview:self.newsfeedViewController.view];
    }
    
    if ([segmentedControl selectedSegmentIndex] == 1){
        //init view controller with nib
        if (!self.peopleViewController){
            self.peopleViewController = [[LBPeopleViewController alloc] initWithNibName:@"LBPeopleViewController" bundle:nil];
            [self.peopleViewController.view setFrame:self.containerView.bounds];

        }
        [self.containerView addSubview:self.peopleViewController.view];
    }
    
    if ([segmentedControl selectedSegmentIndex] == 2){
        //add newsfeed subview for prettiness and whatnot
        if (!self.newsfeedViewController){
            NSLog(@"newsfeed guy doesnt exist");
            self.newsfeedViewController = [[LBNewsfeedViewController alloc] initWithNibName:@"LBNewsfeedViewController" bundle:nil];
            [self.newsfeedViewController.view setFrame:self.containerView.bounds];
        }
        [self.containerView addSubview:self.newsfeedViewController.view];
        
        //init view controller with nib
        if (!self.profileViewController){
            self.profileViewController = [[LBProfileViewController alloc] initWithNibName:@"LBProfileViewController" bundle:nil];
            [self.profileViewController.view setFrame:self.containerView.bounds];
        }
        [self.containerView addSubview:self.profileViewController.view];
    }
}

@end
