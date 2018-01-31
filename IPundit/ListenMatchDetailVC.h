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

#import <Applozic/Applozic.h>
#import "ALChatManager.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "MZTimerLabel.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>
#import <AudioToolbox/AudioToolbox.h>

#define kfbPrefixStr @"https://www.facebook.com/"


@interface ListenMatchDetailVC : UIViewController<ALChatViewControllerDelegate,ALMessagesViewDelegate,ALChatCellDelegate,MZTimerLabelDelegate,UITableViewDelegate,UITableViewDataSource>{
    BOOL ProfileCheckBool;
    BOOL playerCheckBool;
    BOOL matchStatusCheck;
    
    NSMutableDictionary *broadcasterInfo;
    NSMutableDictionary *postingData;
    NSMutableArray *referenceArray;
    NSMutableDictionary * dictData;
    
    int timeSec ;
    int timeMin ;
    
    int matchTimeSec ;
    int matchTimeMin ;
    
    NSTimer * matchTimer;
    NSTimer *timer;
    NSTimer *functionTimer;
    NSTimer *broadcastersTimer;
    NSTimer *ReconnectbroadcastersTimer;
    NSTimer *AdsTimer;

    NSTimer * listnersCount;
    
    
    UIAlertView * checkAlert;
    UIAlertView * broadcasterAlert;
    UIAlertView * followAlert;
    UIAlertView * stopListening;
    UIAlertView * switchBroadcasting;
    
    NSString * listenersUnmountParameter;
    NSString * sharingString;
    
    ALChatViewController *ChatViewObj;
    UINavigationController *ChatController;
    BOOL ChatViewCheckBool;

}
@property (strong, nonatomic) MPMoviePlayerController *streamPlayer;
@property (strong, nonatomic) AVPlayer *player;




@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (nonatomic,strong) ChannelListModel *channellist;
@property (nonatomic,strong) CurrentUser *currentUser;
@property (nonatomic,strong) NSString *ViewName;

@property (nonatomic,strong) NSString *ChatChannelid;

@property (strong, nonatomic) IBOutlet UIView *broadcastersView;
@property (strong, nonatomic) IBOutlet UIImageView *broadcasterViewImageView;
@property (strong, nonatomic) IBOutlet UIImageView *playNPauseImageView;
@property (nonatomic,strong) NSMutableDictionary *teamListenDetails ;
@property (strong, nonatomic) IBOutlet UIView *liveView;
@property (nonatomic,strong)NSMutableArray * mrliveBroadcastersArray;

- (IBAction)MuteUnMuteButtonAction:(id)sender;
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
@property (nonatomic,weak) IBOutlet UIView *mNewOverlayView;
@property (nonatomic,weak) IBOutlet UILabel *mNewOverlayLabel;

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
@property (weak, nonatomic) IBOutlet MZTimerLabel *mKickOFTimeLabel;
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
@property (strong, nonatomic) IBOutlet UIButton *mProfileShowHideButtonn;
@property (strong, nonatomic) IBOutlet UIButton *mSitchBroadcasterButton;
@property (strong, nonatomic) IBOutlet UIButton *mShareButtonButton;
@property (weak, nonatomic) IBOutlet UISwitch *mLowSignalModeSwitch;
- (IBAction)LowSignalModeAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *mRefreshListener;
- (IBAction)RefreshListenerButtonTap:(id)sender;



@property (weak, nonatomic) IBOutlet UITableView *mLineupTableView;

@property (weak, nonatomic) IBOutlet UIButton *mOverviewButton;
@property (weak, nonatomic) IBOutlet UIButton *mLineupButton;

- (IBAction)OverviewButtonTap:(id)sender;
- (IBAction)LineupButtonTap:(id)sender;


@property (strong, nonatomic) IBOutlet UILabel *mTeamTalkLabel;
@property (strong, nonatomic) IBOutlet UIButton *playNPuseButton;
- (IBAction)mPlaynPauseButton:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *listenLabel;

@property (nonatomic,strong)UIRefreshControl *refreshControl ;
@property (nonatomic, strong) ALUser * CurrentALUser;

@property (strong, nonatomic) IBOutlet MarqueeLabel *breakingNewsLabel;
@property (strong, nonatomic) IBOutlet UIView *breakingNewsView;

@property (strong, nonatomic) IBOutlet UIButton *mPlayPauseAudioButton;


- (IBAction)PlayPauseAudioButtonAction:(id)sender;

@end
