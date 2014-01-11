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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    [self.email becomeFirstResponder];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.logInButton.layer setCornerRadius:5.0 ];
    [self.registerButton.layer setCornerRadius:5.0];
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
    NSMutableURLRequest * request= [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://codecamp-ladybug.herokuapp.com/login.json"]];
    NSDictionary * body=[[NSDictionary alloc] initWithObjectsAndKeys:@"email", self.email.text, @"password", self.password.text, nil];
    NSData* json=[NSJSONSerialization dataWithJSONObject:body options:0 error:0];
    [request setHTTPBody: json];
    [request setHTTPMethod: @"POST"];
    NSLog(@"String sent from server %@",[[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding]);

    [NSURLConnection sendAsynchronousRequest:request  queue:self.loginQueue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
         NSLog(@"String sent from server %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);

            LBSession * current= [LBSession defaultSession];
            NSDictionary* json=[NSJSONSerialization JSONObjectWithData:data options:0 error:0];
            current.sessionID=json [@"token"];
        NSLog(@"hello");

        NSLog(@"%@",current.sessionID);
            [self dismissViewControllerAnimated:YES completion: nil];
    }];



}

- (IBAction)registerButtonPressed:(id)sender {
    NSString * urlString=[NSString stringWithFormat:@"http://codecamp-ladybug.herokuapp.com/register&email=%@", self.email.text];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}
@end
