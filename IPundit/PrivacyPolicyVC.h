//
//  PrivacyPolicyVC.h
//  IPundit
//
//  Created by Deepak  on 17/06/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"

@interface PrivacyPolicyVC : UIViewController


@property (strong, nonatomic) IBOutlet UIImageView *mBackgroudImageView;
@property NSString * privacyPolicyString;
@property (strong, nonatomic) IBOutlet UITextView *mPrivacyPolicyTextView;
- (IBAction)backButtonAction:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *pricavyTitle;

@end
