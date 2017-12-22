//
//  FollowersVC.h
//  IPundit
//
//  Created by Manoj Gadamsetty on 01/11/17.
//  Copyright © 2017 James Mason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "Helper.h"
#import "DataManager.h"
#import "FollowersViewCell.h"

@interface FollowersVC : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *mVideoHighlightTableView;
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (strong, nonatomic) IBOutlet UILabel *mNoFollowersLable;
@property (strong, nonatomic) NSString *Followstringg;
@property (strong, nonatomic) NSString *mView;
@property (strong, nonatomic) NSString *mSelectedUser_id;
@property (strong, nonatomic) IBOutlet UILabel *mTitalLable;



@end
