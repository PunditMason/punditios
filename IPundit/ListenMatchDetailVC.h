//
//  BroadcastMatchDetailVC.h
//  IPundit
//
//  Created by Deepak Kumar on 03/03/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "ChannelListModel.h"
#import "UIImage+Additions.h"
#import "Helper.h"
#import "DataManager.h"
#import "SCFacebook.h"
#import "CurrentUser.h"


#define kfbPrefixStr @"https://www.facebook.com/"


@interface ListenMatchDetailVC : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (nonatomic,strong) ChannelListModel *channellist;
@property (nonatomic,strong) CurrentUser *currentUser;
@property (strong, nonatomic) IBOutlet UIView *broadcastersView;
@property (strong, nonatomic) IBOutlet UIImageView *broadcasterViewImageView;
@property (strong, nonatomic) IBOutlet UIImageView *playNPauseImageView;
@property (nonatomic,strong) NSMutableDictionary *teamListenDetails ;
@property (strong, nonatomic) IBOutlet UIView *liveView;


- (IBAction)ShowHideProfileNameButtonAction:(id)sender;
- (IBAction)BackButtonAction:(id)sender;

- (IBAction)FollowButtonPressed:(id)sender;
- (IBAction)FacebookButtonPressed:(id)sender;
- (IBAction)FacebookShareButtonPressed:(id)sender;
- (IBAction)TwitterShareButtonPressed:(id)sender;
- (IBAction)SitchBroadcasterTap:(id)sender;
- (IBAction)goToLiveButtonTap:(id)sender;
- (IBAction)ShareButtonPressed:(id)sender;
- (IBAction)ChatButtonPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *animatedImageView;

@property (nonatomic,weak) IBOutlet UIView *mOverlayView;
@property (nonatomic,weak) IBOutlet UIView *mProfileView;
@property (nonatomic,weak) IBOutlet UIImageView *mProfileBlurImageView;
@property (nonatomic,weak) IBOutlet UIImageView *mProfileImageView;
@property (weak, nonatomic) IBOutlet UILabel *mTagsLabel;
@property (weak, nonatomic) IBOutlet UILabel *mFollowersLabel;
@property (weak, nonatomic) IBOutlet UILabel *mFollowingLabel;
@property (weak, nonatomic) IBOutlet UILabel *mListenersCountLabel;

@property (weak, nonatomic) IBOutlet UITextView *mUserBioTextView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *mTeamVsTeamLabel;
@property (weak, nonatomic) IBOutlet UILabel *mKickOFTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *loggedInAsLabel;
@property (weak, nonatomic) IBOutlet UILabel *mTeamANameLabel;
@property (weak, nonatomic) IBOutlet UILabel *mTeamBNameLabel;


@property (strong, nonatomic) IBOutlet UITableView *mTableView;
@property (weak, nonatomic) IBOutlet UITableView *broadCastersTableView;
@property (nonatomic,strong) NSMutableArray *MatchLiveFeedArray;
@property (weak, nonatomic) IBOutlet UIImageView *leagueIconImageView;
@property (strong, nonatomic) IBOutlet UILabel *matchStatus;
@property (strong, nonatomic) IBOutlet UILabel *mMatchStatusLabel;

@property (nonatomic,strong) NSMutableDictionary * channelDict;
@property (nonatomic,strong) NSMutableDictionary * matchInfoDict;
@property (nonatomic,strong) NSString * punditsMessage;

@property (strong, nonatomic) IBOutlet UIButton *mFollowButton;
@property (strong, nonatomic) IBOutlet UIButton *mProfileShowHideButton;
@property (strong, nonatomic) IBOutlet UILabel *mTeamTalkLabel;
@property (strong, nonatomic) IBOutlet UIButton *playNPuseButton;
- (IBAction)mPlaynPauseButton:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *listenLabel;

@property (nonatomic,strong)UIRefreshControl *refreshControl ;


@end
