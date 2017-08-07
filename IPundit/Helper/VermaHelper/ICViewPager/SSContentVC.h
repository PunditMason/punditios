//
//  SSContentVC.h
//  Shree Sweets
//
//  Created by Gaurav Verma on 29/01/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"
#import "Constants.h"
#import "AppDelegate.h"
#import "Helper.h"
#import <Parse/Parse.h>
#import "SSARefreshControl.h"
#import "ViewController.h"

@interface SSContentVC : UIViewController<SSARefreshControlDelegate>


@property (strong, nonatomic) ViewController *View_Controller;

@property (strong, nonatomic) NSArray *ProductArray;
@property (nonatomic, strong) SSARefreshControl *mRefreshControl;

@property (strong, nonatomic) IBOutlet UILabel *label;

//@property (strong, nonatomic)  NSMutableArray *mITemsTableArray;
@property (strong, nonatomic) IBOutlet UITableView *mITemsTableView;


@end
