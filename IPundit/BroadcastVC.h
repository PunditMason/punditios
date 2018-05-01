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
#import "Constants.h"
#import "CurrentUser.h"
@interface BroadcastVC : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate>{
    
}


@property (strong, nonatomic) IBOutlet UIButton *mXButton;
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;

@property (nonatomic,strong) NSArray *mleaqueArray;
@property (nonatomic,strong) NSString *mSearchString;
@property (nonatomic,weak)IBOutlet UITextField *mSearchTextField;
@property (nonatomic,weak)IBOutlet UICollectionView *mCollectionView;

@property (nonatomic,strong)SportsModel *Sports;
@property (nonatomic,strong)UIRefreshControl *refreshControl ;

- (IBAction)BackButtonAction:(id)sender;
- (IBAction)xButtonTap:(id)sender;

@end
