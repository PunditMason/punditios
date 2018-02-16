//
//  LiveRightNowCell.h
//  IPundit
//
//  Created by Deepak  on 27/07/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LiveRightNowCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *mTeam1Image;
@property (strong, nonatomic) IBOutlet UIImageView *mTeam2Image;
@property (strong, nonatomic) IBOutlet UILabel *mTeam1Label;
@property (strong, nonatomic) IBOutlet UILabel *mTeam2Label;
@property (strong, nonatomic) IBOutlet UILabel *mPunditNameLabel;

@end