//
//  SettingsVC.h
//  IPundit
//
//  Created by Deepak Kumar on 28/02/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"
#import "LiveRightNowCell.h"
#import "UIImageView+WebCache.h"

@interface SettingsVC : UIViewController
- (IBAction)BackButtonAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (strong, nonatomic) IBOutlet UITableView *mTableView;

@property (nonatomic,strong)UIRefreshControl *refreshControl ;

@end
