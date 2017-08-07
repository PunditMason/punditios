//
//  BroadcastMatchCell.h
//  IPundit
//
//  Created by Deepak Kumar on 03/03/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListenMatchCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *mMatchDisplayTime;
@property (weak, nonatomic) IBOutlet UILabel *mTeam1Name;
@property (weak, nonatomic) IBOutlet UILabel *mTeam2name;
@property (weak, nonatomic) IBOutlet UILabel *mTeam1Score;
@property (weak, nonatomic) IBOutlet UILabel *mTeam2Score;
@property (weak, nonatomic) IBOutlet UILabel *mTimeLabel;


@end
