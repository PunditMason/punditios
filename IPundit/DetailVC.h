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
#import "DataManager.h"
#import "LeaquesModel.h"
#import "MarqueeLabel.h"
#import "SportsModel.h"
#import "Constants.h"

@interface DetailVC : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *mXButton;
- (IBAction)BackButtonAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *breakingNewsView;
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (nonatomic,strong) NSString *mSearchString;
@property (nonatomic,weak)IBOutlet UITextField *mSearchTextField;
@property (nonatomic,weak)IBOutlet UICollectionView *mCollectionView;
@property (weak, nonatomic) IBOutlet UIImageView *profilePicImageView;

@property (weak, nonatomic) IBOutlet MarqueeLabel *breakingNewsLabel;
@property (nonatomic,strong)UIRefreshControl *refreshControl ;
@property (nonatomic,strong)SportsModel *Sports;
@property (nonatomic,strong) NSArray *mLeaqueArray;
@property (nonatomic,strong) LeaquesModel *leaque;

- (IBAction)textFieldXButtonTap:(id)sender;


@end
