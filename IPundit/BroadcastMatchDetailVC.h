//
//  BroadcastMatchDetailVC.h
//  IPundit
//
//  Created by Deepak Kumar on 03/03/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Helper.h"
#import "DataManager.h"
#import "MatchListModel.h"
#import "CurrentUser.h"
#import "SCFacebook.h"
#import <AVFoundation/AVFoundation.h>
#import "STTwitter.h"
#import <Social/Social.h>
#import "UIViewController+MJPopupViewController.h"
#import <Applozic/Applozic.h>
#import "ALChatManager.h"
#import "MZTimerLabel.h"
#import "LineupCell.h"
#import <MediaPlayer/MediaPlayer.h>

//@property (strong, nonatomic) id <ALChatViewControllerDelegate> chatViewDelegate;


@interface BroadcastMatchDetailVC : UIViewController<UIAlertViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,ALChatViewControllerDelegate,ALMessagesViewDelegate,ALChatCellDelegate,MZTimerLabelDelegate,UITableViewDelegate,UITableViewDataSource>{
    
    NSTimer * timer;
    NSTimer * matchTimer;
    NSTimer * listnersCount;
    
    
    
    int timeSec ;
    int timeMin ;
    
    int matchTimeSec ;
    int matchTimeMin ;
    
    NSString * stationName ;
    NSString * teams;
    NSString * channelId;
    NSString * streamName ;
    NSString * NewStreamName;
    NSString * allowScoreEdit ;
    
    NSMutableDictionary *followInfo ;
    NSDictionary *dictData;
    NSArray * myArray1;
    NSArray * myArray2;
    
    
    NSMutableArray *referenceArray;
    
    NSTimer *functionTimer;
    BOOL matchStatusCheck;
    
    UIAlertView * stopBroadcastingAlert;
    
    NSString * sharingString;
    NSString * notificationString;
    
    ALChatViewController *ChatViewObj;
    UINavigationController *ChatController;
    BOOL ChatViewCheckBool;
    BOOL PlayPauseCheckBool;

    ALChatViewController *chatView;
}


@property (strong, nonatomic) MPMoviePlayerController *streamPlayer;
@property (strong, nonatomic) IBOutlet UIImageView *leaqueIconImageView;
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (strong, nonatomic) IBOutlet UIButton *mPlayPause;


- (IBAction)PlayPauseButtonAction:(id)sender;

- (IBAction)BackButtonAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *animatedImageView;
@property (nonatomic,strong) MatchListModel *matchlist;
@property (nonatomic,strong) CurrentUser *currentUser;
@property (nonatomic,strong) NSString *ChatChannelid;
@property (nonatomic,strong) NSMutableDictionary *teamBroadCastDict ;

@property (weak, nonatomic) IBOutlet UILabel *matchTimeLabel;



@property (nonatomic,strong) NSMutableArray *MatchLiveFeedArray;
@property (weak, nonatomic) IBOutlet UILabel *loggedInAsLabel;
@property (weak, nonatomic) IBOutlet UILabel *teamVsTeamLabel;
@property (weak, nonatomic) IBOutlet MZTimerLabel *kickOffTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *teamBNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *teamANameLabel;
@property (weak, nonatomic) IBOutlet UILabel *teamAScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *teamBscoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *teamVsTeamLabel2;
@property (weak, nonatomic) IBOutlet UILabel *timeCount1;
@property (weak, nonatomic) IBOutlet MZTimerLabel *timeCount2;
@property (weak, nonatomic) IBOutlet UILabel *mTeamTalkLabel;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView1;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView2;
@property (weak, nonatomic) IBOutlet UIButton *mEditScoreButton;

@property (weak, nonatomic) IBOutlet UITableView *mOverviewTableView;
@property (weak, nonatomic) IBOutlet UITableView *mLineupTableView;

@property (weak, nonatomic) IBOutlet UIButton *mOverviewButton;
@property (weak, nonatomic) IBOutlet UIButton *mLineupButton;

- (IBAction)OverviewButtonTap:(id)sender;
- (IBAction)LineupButtonTap:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *mTeamAScoreLable;
@property (weak, nonatomic) IBOutlet UILabel *mTeamBScoreLable;
@property (weak, nonatomic) IBOutlet UILabel *mTeamANameLable;
@property (weak, nonatomic) IBOutlet UILabel *mTeamBNameLable;

@property (nonatomic,strong) ALUser * CurrentALUser;


@property (weak, nonatomic) IBOutlet UILabel *mListenersCount;
@property (weak, nonatomic) IBOutlet UILabel *matchStatusLabel;


@property (weak, nonatomic) IBOutlet MarqueeLabel *breakingNewsLabel;
@property (weak, nonatomic) IBOutlet UIView *breakingNewsView;

- (IBAction)facebookButtonTap:(id)sender;
- (IBAction)twitterButtonTap:(id)sender;
- (IBAction)ShareButtonPressed:(id)sender;
- (IBAction)ChatButtonPressed:(id)sender;
- (IBAction)LiveButtonAction:(id)sender;


@property (nonatomic,weak) IBOutlet UIView *mOverlayView;
@property (nonatomic,weak) IBOutlet UIView *mScoreUpdateView;

typedef void (^accountChooserBlock_t)(ACAccount *account, NSString *errorMessage); // don't bother with NSError for that

@property (nonatomic, strong) STTwitterAPI *twitter;
@property (nonatomic, strong) ACAccountStore *accountStore;
@property (nonatomic, strong) NSArray *iOSAccounts;
@property (nonatomic, strong) accountChooserBlock_t accountChooserBlock;

@property (weak, nonatomic) IBOutlet UIView *liveView;
- (IBAction)ScoreDoneButtonPressed:(id)sender;

@end
