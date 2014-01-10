//
//  LBNewsfeedCell.h
//  ladybug
//
//  Created by square on 1/10/14.
//  Copyright (c) 2014 square. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBNewsfeedCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UITextView *postText;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *location;

@end
