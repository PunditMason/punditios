//
//  ViewController.h
//  IPundit
//
//  Created by Deepak Kumar on 28/02/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"
#import "BaseVC.h"
#import "WebServicesHelper.h"
#import "UIImageView+WebCache.h"
#import "MarqueeLabel.h"
#import "Constants.h"
#import <Foundation/Foundation.h>
#import "ALChatManager.h"
#import <Applozic/Applozic.h>
#import "UIImage+animatedGIF.h"






@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *punditLogo;
@property (strong, nonatomic) IBOutlet UIImageView *AnimatedImage;


@property (nonatomic,strong)IBOutlet UILabel *LoginLable;
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (strong, nonatomic) IBOutlet UIImageView *LoginbackgroundImageView;
@property (weak, nonatomic) IBOutlet UIButton *broadcastButton;
@property (weak, nonatomic) IBOutlet UIButton *listenButton;
@property (weak, nonatomic) IBOutlet UIView *broadcastButtonView;
@property (weak, nonatomic) IBOutlet UIView *listenButtonView;
@property (weak, nonatomic) IBOutlet UIImageView *broadcastButtonImageView;
@property (weak, nonatomic) IBOutlet UIImageView *listnerButtonImageView;

@property (weak, nonatomic) IBOutlet UIImageView *broadcastButtonImageViewNew;
@property (weak, nonatomic) IBOutlet UIImageView *listnerButtonImageViewNew;


@property (weak, nonatomic) IBOutlet UIView *breakingNewsBackgroundView;
@property (weak, nonatomic) IBOutlet MarqueeLabel *breakingNewsLabel;
@property (weak, nonatomic) IBOutlet UIView *settingsView;
@property (weak, nonatomic) IBOutlet UIButton *settingsButton;
@property (weak, nonatomic) IBOutlet UIImageView *settingsImageView;
@property (weak, nonatomic) IBOutlet UIImageView *settingsIcon;
@property (weak, nonatomic) IBOutlet UIView *aboutIpunditView;
@property (weak, nonatomic) IBOutlet UIImageView *aboutIpunditImageView;
@property (weak, nonatomic) IBOutlet UIImageView *AboutIpunditIconView;
@property (weak, nonatomic) IBOutlet UIView *loginView;
@property (weak, nonatomic) IBOutlet UIImageView *loginImageView;
@property (weak, nonatomic) IBOutlet UIImageView *loginIconView;
@property (weak, nonatomic) IBOutlet UIView *profileButtonView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *profileIconView;
@property (weak, nonatomic) IBOutlet UIButton *aboutPunditButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *profileButton;
@property (weak, nonatomic) IBOutlet UIImageView *splashScreenImageView;
@property (weak, nonatomic) IBOutlet UIView *splashScreenView;

@property (strong, nonatomic) IBOutlet UILabel *broadcastersCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *listenersCountLabel;
@property (strong, nonatomic) IBOutlet UIImageView *listenerCountImageView;
@property (strong, nonatomic) IBOutlet UIImageView *broadcasterCountImageView;
@property (strong, nonatomic)NSMutableDictionary *getProfileParameter;

@property (nonatomic,weak) IBOutlet UIView *mOverlayView;
@property (nonatomic,weak) IBOutlet UIView *mLoginView;

@property (strong, nonatomic) IBOutlet UITextField *mEmailTextField;
@property (strong, nonatomic) IBOutlet UITextField *mPasswordTextField;

@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;
@property (weak, nonatomic) IBOutlet UIView *ContentView;

@property (weak, nonatomic) IBOutlet UIScrollView *mScrollView;
@property (weak, nonatomic) IBOutlet UIView *mContentView;

-(IBAction)CloseLoginViewButtonPressed:(id)sender;

-(IBAction)keyborddown:(id)sender;
- (IBAction)LoginButtonPressed:(id)sender;
- (IBAction)SignUpButtonPressed:(id)sender;
- (IBAction)DashbordLoginButtonPressed:(id)sender;
- (IBAction)ForgotButtonAction:(id)sender;
- (IBAction)LoginwithFacebookButtonPressed:(id)sender;
- (IBAction)BrodcastButtonPressed:(id)sender;
- (IBAction)ListenButtonPressed:(id)sender;
- (IBAction)AboutButtonPressed:(id)sender;
- (IBAction)SettingsButtonPressed:(id)sender;
- (IBAction)ProfileButtonPressed:(id)sender;



@end

