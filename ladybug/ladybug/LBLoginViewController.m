//
//  LBLoginViewController.m
//  ladybug
//
//  Created by square on 1/10/14.
//  Copyright (c) 2014 square. All rights reserved.
//

#import "LBLoginViewController.h"
#import "LBSession.h"

@interface LBLoginViewController ()
@property NSOperationQueue* loginQueue;
@end

@implementation LBLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _loginQueue= [NSOperationQueue new];
        [_loginQueue setMaxConcurrentOperationCount:1];
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
    [self.scrollView setContentInset: UIEdgeInsetsMake(0, 0, endFrame.size.height, 0)];
}
-(void) keyboardWillHide: (NSNotification*) notification{
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logInButtonPressed:(id)sender {
    //send stuff to the server
    NSURLRequest * request= [NSURLRequest requestWithURL:[NSURL URLWithString:@"codecamp-ladybug.herokuapp.com"]];
    
    [NSURLConnection sendAsynchronousRequest:request  queue:self.loginQueue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            LBSession * current= [LBSession defaultSession];
            current.sessionID=@"placeholder";
            [self dismissViewControllerAnimated:YES completion: nil];
    }];

    
}

@end
