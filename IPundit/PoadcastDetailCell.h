//
//  PoadcastDetailCell.h
//  IPundit
//
//  Created by Gaurav Verma on 13/09/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PoadcastDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *mMatchDetail;
@property (weak, nonatomic) IBOutlet UILabel *mPodcastNameLable;
@property (weak, nonatomic) IBOutlet UILabel *mTimeLable;
@property (weak, nonatomic) IBOutlet UIImageView *mImageview;
@property (weak, nonatomic) IBOutlet UIImageView *mPlayImageview;


@property (weak, nonatomic) IBOutlet UIButton *mPodcastNameButton;




@end
