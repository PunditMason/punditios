//
//  BroadcastVC.h
//  IPundit
//
//  Created by Deepak Kumar on 28/02/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IQKeyboardManager.h"
#import "DataManager.h"
#import "SportsModel.h"
#import "LeaquesModel.h"
#import "Constants.h"

@interface ListenVC : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate>{
    
}
@property (weak, nonatomic) IBOutlet UIView *mHideView;

@property (strong, nonatomic) IBOutlet UIButton *mXButton;
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;

@property (nonatomic,strong) NSArray *mleaqueArray;
@property (nonatomic,strong) NSString *mSearchString;
@property (nonatomic,weak)IBOutlet UITextField *mSearchTextField;
@property (nonatomic,strong)IBOutlet UICollectionView *mCollectionView;

@property (nonatomic,strong)SportsModel *Sports;
@property (nonatomic,strong)LeaquesModel *leaques;

@property (nonatomic,strong)UIRefreshControl *refreshControl ;
///// Search

@property (strong, nonatomic) IBOutlet UIView *searchSelectionView;
@property (strong, nonatomic) IBOutlet UIButton *teamButton;
@property (strong, nonatomic) IBOutlet UIButton *userButton;
@property (strong, nonatomic) IBOutlet UIButton *sportButton;


- (IBAction)textFieldXButtonTap:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *mTableView;
@property (strong, nonatomic) IBOutlet UITableView *mTeamTableView;

- (IBAction)BackButtonAction:(id)sender;
- (IBAction)UserButtonSelection:(id)sender;
- (IBAction)TeamButtonSelection:(id)sender;
- (IBAction)SportButtonSelection:(id)sender;

@end
