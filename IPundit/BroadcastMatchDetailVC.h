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


@interface BroadcastMatchDetailVC : UIViewController<UIAlertViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource>

@property (strong, nonatomic) IBOutlet UIImageView *leaqueIconImageView;

@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;

- (IBAction)BackButtonAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *animatedImageView;
@property (nonatomic,strong) MatchListModel *matchlist;
@property (nonatomic,strong) CurrentUser *currentUser;
@property (nonatomic,strong) NSMutableDictionary *teamBroadCastDict ;

@property (strong, nonatomic) IBOutlet UILabel *matchTimeLabel;

@property (strong, nonatomic) IBOutlet UITableView *mTableView;
@property (nonatomic,strong) NSMutableArray *MatchLiveFeedArray;
@property (weak, nonatomic) IBOutlet UILabel *loggedInAsLabel;
@property (weak, nonatomic) IBOutlet UILabel *teamVsTeamLabel;
@property (weak, nonatomic) IBOutlet UILabel *kickOffTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *teamBNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *teamANameLabel;
@property (weak, nonatomic) IBOutlet UILabel *teamAScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *teamBscoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *teamVsTeamLabel2;
@property (weak, nonatomic) IBOutlet UILabel *timeCount1;
@property (weak, nonatomic) IBOutlet UILabel *timeCount2;
@property (strong, nonatomic) IBOutlet UILabel *mTeamTalkLabel;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView1;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView2;
@property (strong, nonatomic) IBOutlet UIButton *mEditScoreButton;

@property (weak, nonatomic) IBOutlet UILabel *mTeamAScoreLable;
@property (weak, nonatomic) IBOutlet UILabel *mTeamBScoreLable;
@property (weak, nonatomic) IBOutlet UILabel *mTeamANameLable;
@property (weak, nonatomic) IBOutlet UILabel *mTeamBNameLable;



@property (strong, nonatomic) IBOutlet UILabel *mListenersCount;
@property (strong, nonatomic) IBOutlet UILabel *matchStatusLabel;


- (IBAction)facebookButtonTap:(id)sender;
- (IBAction)twitterButtonTap:(id)sender;
- (IBAction)ShareButtonPressed:(id)sender;
- (IBAction)ChatButtonPressed:(id)sender;


@property (nonatomic,weak) IBOutlet UIView *mOverlayView;
@property (nonatomic,weak) IBOutlet UIView *mScoreUpdateView;

typedef void (^accountChooserBlock_t)(ACAccount *account, NSString *errorMessage); // don't bother with NSError for that

@property (nonatomic, strong) STTwitterAPI *twitter;
@property (nonatomic, strong) ACAccountStore *accountStore;
@property (nonatomic, strong) NSArray *iOSAccounts;
@property (nonatomic, strong) accountChooserBlock_t accountChooserBlock;
@property (strong, nonatomic) IBOutlet UIView *liveView;
- (IBAction)ScoreDoneButtonPressed:(id)sender;

@end
