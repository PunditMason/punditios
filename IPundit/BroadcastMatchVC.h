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
#import "MatchListModel.h"
#import "LeaquesModel.h"

#import <Applozic/Applozic.h>
#import "ALChatManager.h"

@interface BroadcastMatchVC : UIViewController<JTCalendarDelegate,UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;
- (IBAction)BackButtonAction:(id)sender;
- (IBAction)StreemingButtonAction:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *dateSelectionTextField;

@property (strong, nonatomic)  NSMutableArray *mMatchArray;
@property (strong, nonatomic) IBOutlet UITableView *mMatchTableView;

@property (nonatomic,strong)UIRefreshControl *refreshControl ;
@property (strong, nonatomic) IBOutlet JTHorizontalCalendarView *calenderManager;
@property (strong, nonatomic) IBOutlet UILabel *leaquenameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *leaqueImageIcon;

@property (strong, nonatomic) JTCalendarManager *calendarMa;
@property (strong, nonatomic) IBOutlet MarqueeLabel *breakingNewsLabel;

@property (strong, nonatomic) IBOutlet UILabel *noBroadCastersLabel;

@property (nonatomic,weak) IBOutlet UIView *mOverlayView;
@property (nonatomic,weak) IBOutlet UIView *mProfileView;
@property (nonatomic,weak)IBOutlet UIImageView  *mProfileBlurImageView;
@property (nonatomic,strong) LeaquesModel *leaquesmodel;
@property (nonatomic,strong) MatchListModel *matchlistmodel;
@property (strong, nonatomic) IBOutlet UIView *matchView;
@property (strong, nonatomic) IBOutlet UIView *breakingNewsView;
@property (strong, nonatomic) IBOutlet UIButton *teamTable;
@property (nonatomic, strong) ALUser * CurrentALUser;


@end
