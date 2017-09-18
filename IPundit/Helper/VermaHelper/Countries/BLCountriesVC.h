//
//  BLCountriesVC.h
//  WowzaGoCoderSDKSampleApp
//
//  Created by Gaurav Verma on 14/10/16.
//  Copyright © 2016 Wowza, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Helper.h"

@interface BLCountriesVC : UIViewController<UITableViewDelegate, UITableViewDataSource>



@property (nonatomic,retain)NSMutableArray *mSearchResults;
@property (nonatomic,retain)NSMutableArray *mAllRecods;
@property (nonatomic,retain)NSMutableArray *mSectionIndexArray;
@property (nonatomic,retain)NSDictionary *mDataDict;

@property (nonatomic, weak) IBOutlet UITableView *mTableView;
@property (weak, nonatomic) IBOutlet UISearchBar *mSearchBar;
@property (nonatomic,weak) IBOutlet UILabel *mNoDataLable;
- (IBAction)BackButtonAction:(id)sender;

@end
