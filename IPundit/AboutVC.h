//
//  AboutVC.h
//  IPundit
//
//  Created by Deepak Kumar on 28/02/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"
#import "PrivacyPolicyVC.h"

@interface AboutVC : UIViewController
- (IBAction)BackButtonAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;

@property NSString *aboutUsString;
@property (strong, nonatomic) IBOutlet UITextView *mTextView;
@property (strong, nonatomic) IBOutlet UILabel *aboutUsTitle;
@property (strong, nonatomic) IBOutlet UIButton *privacyButton;

@end
