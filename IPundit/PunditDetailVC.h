//
//  PunditDetailVC.h
//  IPundit
//
//  Created by Deepak  on 22/08/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListenMatchDetailVC.h"
#import "DataManager.h"
#import <Applozic/Applozic.h>
#import "ALChatManager.h"
@interface PunditDetailVC : UIViewController



@property (strong, nonatomic) IBOutlet UILabel *nNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *mFollowingLable;
@property (strong, nonatomic) IBOutlet UILabel *mFollowersLable;
@property (strong, nonatomic) IBOutlet UIButton *mFollowmwButton;
@property (strong, nonatomic) IBOutlet UIButton *mListenNowButton;
@property (strong, nonatomic) IBOutlet UIImageView *mProfileImageView;
@property (strong, nonatomic) IBOutlet UITextView *mBioTextView;
@property (strong, nonatomic) IBOutlet UIButton *mFacebookButton;
@property (strong, nonatomic) IBOutlet UIButton *mTwitterButton;
@property (strong, nonatomic) IBOutlet UIButton *mYoutubeButton;


@property (nonatomic, strong) ALUser * CurrentALUser;

@property (strong, nonatomic)NSDictionary * dictRefff;
@property (strong, nonatomic)NSMutableArray *mDataArrayyy;
@property (strong, nonatomic)NSIndexPath *mindex;


- (IBAction)BackButtonAction:(id)sender;
- (IBAction)FollowMeButtonAction:(id)sender;
- (IBAction)ListenLiveButtonAction:(id)sender;
- (IBAction)FacebookButtonAction:(id)sender;
- (IBAction)TwitterButtonAction:(id)sender;
- (IBAction)YoutubeButtonAction:(id)sender;

@end
