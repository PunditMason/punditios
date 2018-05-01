//
//  DetailVC.h
//  IPundit
//
//  Created by Deepak Kumar on 02/03/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "IQKeyboardManager.h"
#import "LeaquesModel.h"
#import "MarqueeLabel.h"
#import "SportsModel.h"
#import "Constants.h"
#import "CurrentUser.h"
#import "PoadcastVC.h"

@interface ListenDetailVC : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *mXButton;
- (IBAction)BackButtonAction:(id)sender;

@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (strong, nonatomic) IBOutlet UIView *breakingNewsView;
@property (nonatomic,strong)NSMutableArray * mliveBroadcastersArray;

@property (nonatomic,strong) NSString *mSearchString;
@property (nonatomic,weak)IBOutlet UITextField *mSearchTextField;
@property (nonatomic,weak)IBOutlet UICollectionView *mCollectionView;
@property (weak, nonatomic)IBOutlet UIImageView *profilePicImageView;

@property (nonatomic,strong) NSArray *mLeaqueArray;
@property (nonatomic,strong) LeaquesModel *leaque;
@property (nonatomic,strong) UIRefreshControl *refreshControl ;
@property (nonatomic,strong) SportsModel *Sports;

@property (weak, nonatomic) IBOutlet MarqueeLabel *breakingNewsLabel;

- (IBAction)textFieldXButtonTap:(id)sender;


@property (strong, nonatomic) IBOutlet UIView *searchSelectionView;
@property (strong, nonatomic) IBOutlet UIButton *teamButton;
@property (strong, nonatomic) IBOutlet UIButton *userButton;
@property (strong, nonatomic) IBOutlet UIButton *leagueButton;


@property (strong, nonatomic) IBOutlet UITableView *mTableView;
@property (strong, nonatomic) IBOutlet UITableView *mTeamTableView;


- (IBAction)UserButtonSelection:(id)sender;
- (IBAction)TeamButtonSelection:(id)sender;
- (IBAction)leagueButtonSelection:(id)sender;

@end
