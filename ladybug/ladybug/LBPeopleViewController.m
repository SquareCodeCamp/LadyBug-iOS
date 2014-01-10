//
//  LBNewsfeedViewController.m
//  ladybug
//
//  Created by square on 1/10/14.
//  Copyright (c) 2014 square. All rights reserved.
//


#import "LBNewsfeedCell.h"
#import "LBpost.h"
#import "LBPeopleViewController.h"

@interface LBPeopleViewController ()
@property NSOperationQueue* newsfeedQueue;

@end

@implementation LBPeopleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _posts = [[LBPosts alloc] init];
        self.newsfeedQueue = [[NSOperationQueue alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //TODO: create list with User objects
    
    [self makeJSONRequest];
    
}

-(void)makeJSONRequest{
    
    NSMutableURLRequest * request= [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://codecamp-ladybug.herokuapp.com/posts.json"]];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    
    [NSURLConnection sendAsynchronousRequest:request  queue:self.newsfeedQueue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (!connectionError){
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self.posts updatePosts:data];
                [self.tableView reloadData];
            }];
            
        }else{
            NSLog(@"%@", connectionError);
        }
    }];
    
}
//delegate method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //TODO: change to however many users we have
    return [self.posts.postsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"mytable";
    
    LBNewsfeedCell *cell = (LBNewsfeedCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"LBNewsfeedCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
    }
    
    //TODO: change to actual user data
    LBPost *post = self.posts.postsArray[indexPath.row];
    cell.name.text = post.user.name;
    cell.location.text=post.user.city;
    cell.profileImage.image = post.user.pic;
    cell.postText.text = post.content;
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //TODO: modify height to message length
    return 118;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
