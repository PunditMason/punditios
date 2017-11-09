//
//  FollowersViewCell.m
//  IPundit
//
//  Created by Manoj Gadamsetty on 01/11/17.
//  Copyright © 2017 James Mason. All rights reserved.
//

#import "FollowersViewCell.h"

@implementation FollowersViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    CALayer *imageLayer = self.mProfileImage.layer;
    [imageLayer setCornerRadius:self.mProfileImage.frame.size.width/2];
    [imageLayer setBorderColor:[[UIColor grayColor]CGColor]];
    [imageLayer setBorderWidth:1];
    [imageLayer setMasksToBounds:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
