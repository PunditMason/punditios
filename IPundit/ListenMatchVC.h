//
//  BroadcastMatchVC.h
//  IPundit
//
//  Created by Deepak Kumar on 03/03/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JTCalendar/JTCalendar.h>
#import "Helper.h"
#import "DataManager.h"
#import "ChannelListModel.h"
#import "LeaquesModel.h"
#import "UIViewController+MJPopupViewController.h"
#import <Applozic/Applozic.h>
#import "ALChatManager.h"


@interface ListenMatchVC : UIViewController<JTCalendarDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;

- (IBAction)BackButtonAction:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *dateSelectionTextField;


@property (strong, nonatomic)  NSMutableArray *mMatchArray;
@property (strong, nonatomic) IBOutlet UITableView *mMatchTableView;
@property (nonatomic,strong)NSMutableArray * mliveBroadcastersArray;

@property (strong, nonatomic) IBOutlet JTCalendarMenuView *calendarMenuView;

@property (strong, nonatomic) IBOutlet JTHorizontalCalendarView *calenderManager;
@property (strong, nonatomic) JTCalendarManager *calendarMa;


@property (weak, nonatomic) IBOutlet MarqueeLabel *mNewsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *mLeaqueIcon;
@property (weak, nonatomic) IBOutlet UILabel *mLeaqueName;
@property (strong, nonatomic) IBOutlet UILabel *mNoBroadCastersAvilable;

@property (strong, nonatomic) IBOutlet UIButton *todayButton;

- (IBAction)todayButtonTap:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *broadcasterCountLabel;
@property (strong, nonatomic) IBOutlet UIImageView *broadcasterCountImageView;

@property (nonatomic,strong) LeaquesModel *leaquesmodel;
@property (nonatomic,strong) ChannelListModel *channellistmodel;

@property (strong, nonatomic) IBOutlet UIView *matchView;
@property (strong, nonatomic) IBOutlet UIView *breakingNewsView;
@property (strong, nonatomic) IBOutlet UIButton *teamTable;
@property (nonatomic, strong) ALUser * CurrentALUser;
- (IBAction)VideoHighlightsPressedButtonAction:(id)sender;
- (IBAction)OtherLeagueStationPressedButtonAction:(id)sender;
@end


