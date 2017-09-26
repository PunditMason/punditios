//
//  PSignUpVC.h
//  IPundit
//
//  Created by Gaurav Verma on 22/09/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "DataManager.h"
#import "Constants.h"
#import "CurrentUser.h"
#import "Helper.h"
#import "getProfileCurrentUser.h"
#import "ALChatManager.h"
#import <Applozic/Applozic.h>
#import "UIImage+animatedGIF.h"
@interface PSignUpVC : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *mNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *mEmailTextField;
@property (strong, nonatomic) IBOutlet UITextField *mPasswordTextField;
@property (strong, nonatomic) IBOutlet UITextField *mConfPasswordTextField;
@property (strong, nonatomic) IBOutlet UIImageView *SignupbackgroundImageView;

@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;
@property (weak, nonatomic) IBOutlet UIView *ContentView;

- (IBAction)CloseButtonAction:(id)sender;
- (IBAction)SignUpButtonAction:(id)sender;


@end
