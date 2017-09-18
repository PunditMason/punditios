//
//  BroadcastMatchCell.h
//  IPundit
//
//  Created by Deepak Kumar on 03/03/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BroadcastMatchCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *mMatchStartTime;

@property (strong, nonatomic) IBOutlet UILabel *mTeam1Name;
@property (strong, nonatomic) IBOutlet UILabel *mTeam2Name;
@property (strong, nonatomic) IBOutlet UILabel *mTeam1Score;
@property (strong, nonatomic) IBOutlet UILabel *mteam2Score;
@property (strong, nonatomic) IBOutlet UILabel *mmatchStatus;


@end
