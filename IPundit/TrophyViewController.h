//
//  TrophyViewController.h
//  IPundit
//
//  Created by softuvo on 20/04/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Helper.h"
#import "LeaquesModel.h"
#import "MatchListModel.h"
#import <Applozic/Applozic.h>
#import "ALChatManager.h"

@interface TrophyViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UILabel *leaqueNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *notifyLabel;
@property (strong,nonatomic) LeaquesModel *leaquesModel ;
@property (nonatomic,strong) MatchListModel *matchlistmodel;

@property NSMutableArray *serverResponse;
@property (nonatomic,strong)UIRefreshControl *refreshControl ;
- (IBAction)backButtonAction:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *noMatchesLabel;

@property (nonatomic,strong)NSMutableArray * mliveBroadcastersArray;

- (IBAction)StreemingButtonAction:(id)sender;
@property (nonatomic,weak) IBOutlet UIView *mOverlayView;
@property (nonatomic,weak) IBOutlet UIView *mProfileView;
@property (nonatomic, strong) ALUser * CurrentALUser;




@end
