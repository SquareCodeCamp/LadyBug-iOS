//
//  LBNewsfeedViewController.m
//  ladybug
//
//  Created by square on 1/10/14.
//  Copyright (c) 2014 square. All rights reserved.
//

#import "LBNewsfeedViewController.h"
#import "LBNewsfeedCell.h"
#import "LBpost.h"
#import "LBSession.h"

@interface LBNewsfeedViewController ()<UITextFieldDelegate>

@property NSOperationQueue* newsfeedQueue;

@end

@implementation LBNewsfeedViewController

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
    self.composeText.delegate=self;
    //TODO: create list with User objects
    
    [self makeJSONRequest];

}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.composeText) {
        [textField resignFirstResponder];
    }
    return NO;
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear: animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object: nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object: nil];
    
    
    // Do any additional setup after loading the view from its nib.
}
-(void) keyboardWillShow: (NSNotification*) notification{
    NSDictionary * info=[notification userInfo];
    CGRect endFrame= [((NSValue*)info [UIKeyboardFrameEndUserInfoKey]) CGRectValue];
    CGRect adjOuterFrame= self.outerView.frame;
    adjOuterFrame.size.height-=endFrame.size.height;
    
    NSTimeInterval duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve curve = [[info objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    [UIView animateWithDuration:duration delay:0 options:(curve << 16) animations:^{
        self.outerView.frame = adjOuterFrame;
    } completion:nil];
}
-(void) keyboardWillHide: (NSNotification*) notification{
    NSDictionary * info=[notification userInfo];
    CGRect endFrame= [((NSValue*)info [UIKeyboardFrameEndUserInfoKey]) CGRectValue];
    CGRect adjOuterFrame= self.outerView.frame;
    adjOuterFrame.size.height+=endFrame.size.height;
    
    NSTimeInterval duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve curve = [[info objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    [UIView animateWithDuration:duration delay:0 options:(curve << 16) animations:^{
        self.outerView.frame = adjOuterFrame;
    } completion:nil];
}

-(void)makeJSONRequest{
    
    NSMutableURLRequest * request= [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://codecamp-ladybug.herokuapp.com/posts.json"]];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    
    [NSURLConnection sendAsynchronousRequest:request  queue:self.newsfeedQueue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (!connectionError){
            [self.posts updatePosts:data];
            [self.tableView reloadData];
            
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
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
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

- (IBAction)composeButtonPressed:(id)sender {
    LBSession * current= [LBSession defaultSession];
    [current composePost:self.composeText.text];
    [self.composeText setText:@""];
}
@end
