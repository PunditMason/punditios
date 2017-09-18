//
//  SKSliderVC.h
//  SHKUN
//
//  Created by Gaurav Verma on 21/12/16.
//  Copyright © 2016 Gaurav Verma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Helper.h"
#import "Constants.h"
#import "SKSliderCell.h"
#import "SKUser.h"
#import "Helper.h"
#import "UIImageView+WebCache.h"
#import "DataManager.h"
#import "AppDelegate.h"

#import "CVBWebsiteVC.h"
#define kfbPrefixStr @"https://www.facebook.com/"
#define ktwitterPrefixStr @"https://twitter.com/"




@interface SKSliderVC : UIViewController{
NSMutableDictionary  *dct;
}



@property (strong, nonatomic)  NSMutableArray *mSliderTableArray;





@property (strong, nonatomic) IBOutlet UITableView *mSliderTableView;
@property (strong, nonatomic) IBOutlet UILabel *mNameLbl;
@property (strong, nonatomic) IBOutlet UILabel *mLocationLbl;

@property (strong, nonatomic) IBOutlet UIImageView *mLogoImageView;

-(IBAction)facebookClicked:(id)sender;
-(IBAction)twitterClicked:(id)sender;
-(IBAction)openWebsiteAction:(id)sender;

@end
