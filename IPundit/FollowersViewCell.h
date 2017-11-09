//
//  FollowersViewCell.h
//  IPundit
//
//  Created by Manoj Gadamsetty on 01/11/17.
//  Copyright © 2017 James Mason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FollowersViewCell : UITableViewCell
@property (nonatomic,weak)IBOutlet UIImageView *mProfileImage;
@property (nonatomic,weak)IBOutlet UILabel *mNameLable;
@property (nonatomic,weak)IBOutlet UIButton *mFollowButton;
@property (nonatomic,weak)IBOutlet UIButton *mPodcastButton;


@end
