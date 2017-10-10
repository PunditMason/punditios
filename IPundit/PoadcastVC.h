//
//  PoadcastVC.h
//  IPundit
//
//  Created by Gaurav Verma on 13/09/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PoadcastCell.h"
#import "Helper.h"
#import "DataManager.h"
@interface PoadcastVC : UIViewController

@property (strong, nonatomic) IBOutlet UITableView *mPoadcastTableView;

@property (strong, nonatomic) IBOutlet UILabel *mNoPoadcastAvilable;
@property (strong, nonatomic)NSString * selectedUser;

- (IBAction)BackButtonAction:(id)sender;
@end
