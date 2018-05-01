//
//  ViewController.m
//  IPundit
//
//  Created by Deepak Kumar on 28/02/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import "ViewController.h"
#import "SCFacebook.h"
#import "CurrentUser.h"
#import "DataManager.h"
#import "Helper.h"
#import "getProfileCurrentUser.h"
#import <QuartzCore/QuartzCore.h>
#import "KIImagePager.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "PoadcastDetailVC.h"
#import "LatestPodcastsCell.h"


@interface ViewController ()<KIImagePagerDelegate, KIImagePagerDataSource>
{
    IBOutlet KIImagePager *_imagePager;    
    BOOL FacebookCheckBool;
    BOOL ProfileCheckBool;
    NSMutableDictionary * termsAndConditions ;
    
    NSTimer *listenersTimer ;
    NSMutableArray *ImagesArray;
    float mCurrentDataVersion;
    NSString *message;
    UIAlertView *ForfotPasswordAlert;
    NSMutableArray *mLatestPodcastArray;

    

}

@end

@implementation ViewController
@synthesize websuvimge1,websuvimge;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    mLatestPodcastArray = [[NSMutableArray alloc]init];

    
    [self.ScrollView layoutIfNeeded];
    self.ScrollView.contentSize = self.ContentView.bounds.size;
    
    [self.mScrollView layoutIfNeeded];
    self.mScrollView.contentSize = self.mContentView.bounds.size;
    
    
    ImagesArray = [[NSMutableArray alloc] init];
        _getProfileParameter =[[NSMutableDictionary alloc]init];
    self.splashScreenView.userInteractionEnabled = NO ;
    self.splashScreenImageView.userInteractionEnabled = NO ;
    self.listenersCountLabel.hidden = YES ;
    self.listenerCountImageView.hidden = YES ;
    self.broadcastersCountLabel.hidden = YES ;
    self.broadcasterCountImageView.hidden = YES ;
    /*
    if (IS_IPHONE4) {
        self.view.frame = CGRectMake(0, 0, 320, 480);
        self.punditLogo.frame = CGRectMake(23, 12, 98, 49);
        self.breakingNewsBackgroundView.frame = CGRectMake(0, 69, 320, 23);
        
        self.broadcastButtonView.frame = CGRectMake(27, 98, 266, 115);
        self.broadcastButton.frame = CGRectMake(0, 0, 266, 115);
        self.broadcastButtonImageView.frame = CGRectMake(0, 0, 266, 115);
        
        self.listenButtonView.frame = CGRectMake(27, 218, 266, 115);
        self.listenButton.frame = CGRectMake(0, 0, 266, 115);
        self.listnerButtonImageView.frame = CGRectMake(0, 0, 266, 115);
        
        self.aboutIpunditView.frame = CGRectMake(162, 335, 127, 65);
        self.loginView.frame = CGRectMake(162, 408, 127, 65);
        self.settingsView.frame = CGRectMake(27, 335, 127, 65);
        self.profileButtonView.frame = CGRectMake(27, 408, 127, 65);
        
        self.splashScreenView.frame = CGRectMake(0, 0, 320, 480);
        self.splashScreenImageView.frame = CGRectMake(0, 0, 320, 480);
    }
    */
    
    
    if (IS_IPHONE4) {
        self.ScrollView.frame = CGRectMake(0, 0, 320, 438);
        self.splashScreenView.frame = CGRectMake(0, 0, 320, 480);
        self.mScrollView.frame = CGRectMake(0, 0, 320, 480);
        self.mLoginView.frame = CGRectMake(0, 0, 320, 480);
            self.mTaskBarView.frame = CGRectMake(0, 438, 320, 42);
        
        
    }else{
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"App Preview" withExtension:@"gif"];
        
        self.splashScreenImageView.image= [UIImage animatedImageWithAnimatedGIFURL:url];
        
        NSURL *url1 = [[NSBundle mainBundle] URLForResource:@"giphy01" withExtension:@"gif"];
        
        self.broadcastButtonImageViewNew.image= [UIImage animatedImageWithAnimatedGIFURL:url1];
        
        NSURL *url2 = [[NSBundle mainBundle] URLForResource:@"listning" withExtension:@"gif"];
        
        self.listnerButtonImageViewNew.image= [UIImage animatedImageWithAnimatedGIFURL:url2];
         
    }
    self.broadcastButtonImageViewNew.hidden = TRUE;
    self.listnerButtonImageViewNew.hidden = TRUE;

    
    websuvimge.frame = CGRectMake(85, 3, 120,120);
    websuvimge.backgroundColor = [UIColor clearColor];
    [websuvimge.scrollView setScrollEnabled:NO];
 //   [self.broadcastButtonView addSubview:websuvimge];
    NSString*path = [[NSBundle mainBundle] pathForResource:@"live" ofType:@"svg"];
    if (path)
    {
        NSURL*fileurl = [NSURL fileURLWithPath:path];
        NSURLRequest*req = [NSURLRequest requestWithURL:fileurl];
        websuvimge.scalesPageToFit = false;
          [websuvimge setOpaque:NO];
        [websuvimge loadRequest:req];
    }
    
    
    websuvimge1.frame = CGRectMake(80, 3, 120,120);
    websuvimge1.backgroundColor = [UIColor clearColor];
    [websuvimge1.scrollView setScrollEnabled:NO];
  //  [self.broadcastButtonView addSubview:websuvimge];
    NSString*path1 = [[NSBundle mainBundle] pathForResource:@"go_115" ofType:@"svg"];
    if (path1)
    {
        NSURL*fileurl1 = [NSURL fileURLWithPath:path1];
        NSURLRequest*req1 = [NSURLRequest requestWithURL:fileurl1];
        websuvimge1.scalesPageToFit = false;
        [websuvimge1 setOpaque:NO];
        [websuvimge1 loadRequest:req1];
    }

    
    
    [self HomePageContent];
    [self getTandC];
    [self getBreakingNews];
    
    /*
    NSURL *url1 = [NSURL URLWithString:@"http://punditsports.com:81/pundit-ios/assets/img/ios_icons/21100500_10213824194909008_1136882959_n.jpg"];
    NSURL *url2 = [NSURL URLWithString:@"http://punditsports.com:81/pundit-ios/assets/img/ios_icons/Listening-ios.png"];

    
    NSString *strobj = [NSString stringWithFormat:@"https://raw.github.com/kimar/tapebooth/master/Screenshots/Screen1.png"];
    NSString *strobj2 = [NSString stringWithFormat:@"https://raw.github.com/kimar/tapebooth/master/Screenshots/Screen2.png"];
    
    UIImage *Image1 =[UIImage imageNamed:@"SliderImg1.jpg"];
    UIImage *Image2 =[UIImage imageNamed:@"SliderImg2.png"];

    ImagesArray = [[NSMutableArray alloc] initWithObjects:strobj,strobj2, nil];
   */
    
    
    self.mLoginView.frame = CGRectMake(self.mLoginView.frame.origin.x,self.view.frame.size.height,self.mLoginView.frame.size.width,self.mLoginView.frame.size.height);
    
    }




-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    [self GetOtherLeagueStation];

     [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [[IQKeyboardManager sharedManager]setKeyboardDistanceFromTextField:50];
    
    self.breakingNewsLabel.text = DM.breakingNewsString;
    [DM marqueLabel:self.breakingNewsLabel];
        
        CurrentUser *currentUser = [[CurrentUser alloc] init];
        [currentUser setupUser:[Helper mCurrentUser]];
        if ([currentUser.mUsers_Id length] == 0) {
            self.LoginLable.text = @"Log in";
        }
        else{
           // self.mLoginView.frame = CGRectMake(self.mLoginView.frame.origin.x,self.view.frame.size.height,self.mLoginView.frame.size.width,self.mLoginView.frame.size.height);
            
            FacebookCheckBool = true;
            self.LoginLable.text = @"Log out";
        }
    
    listenersTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(ListenerCount) userInfo:nil repeats:YES];
}


-(void)ListenerCount{
    
    NSString * string = [NSString stringWithFormat:@"%@Game/count",KServiceBaseURL];
    
    [DM GetRequest:string parameter:nil onCompletion:^(id  _Nullable dict) {
        
     NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
        NSString * listnerCount = [NSString stringWithFormat:@"%@",[responseDict objectForKey:@"listeners_count"]];
        NSString * broadcasterCount = [NSString stringWithFormat:@"%@",[responseDict objectForKey:@"broadcaster_count"]];
        if ([listnerCount isEqualToString:@"0"]) {
            self.listenersCountLabel.hidden = YES ;
            self.listenerCountImageView.hidden = YES ;
        }else{
            self.listenersCountLabel.text = listnerCount;
            self.listenersCountLabel.hidden = NO ;
            self.listenerCountImageView.hidden = NO ;
        }
        if ([broadcasterCount isEqualToString:@"0"]) {
            self.broadcastersCountLabel.hidden = YES ;
            self.broadcasterCountImageView.hidden = YES ;
        }else{
            self.broadcastersCountLabel.text = broadcasterCount;
            self.broadcastersCountLabel.hidden = NO ;
            self.broadcasterCountImageView.hidden = NO ;
        }
    } onError:^(NSError * _Nullable Error) {
        
    }];
}



-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
}




#pragma mark ---------------------------------------------------------
#pragma mark LOGIN WITH FACEBOOK START
#pragma mark ---------------------------------------------------------
- (IBAction)SignUpButtonPressed:(id)sender{
    
     [self performSegueWithIdentifier:@"SignUpView" sender:self];
    
}

- (IBAction)ForgotButtonAction:(id)sender{
    
    ForfotPasswordAlert = [[UIAlertView alloc] initWithTitle:@"Forgot Password"
                                                    message:@"Please Enter Your Email"
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                           otherButtonTitles:@"Cancel", nil];
    ForfotPasswordAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
    ForfotPasswordAlert.tag = 10014;
    [ForfotPasswordAlert show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (ForfotPasswordAlert.tag == 10014) {
        if (buttonIndex == 0) {
            
            if ([[alertView textFieldAtIndex:0].text length ] == 0 ) {
                
                 [Helper ISAlertTypeWarning:@"Warning!" andMessage:@"Please enter a valid email."];
            }
            
            else{
                if ([alertView textFieldAtIndex:0].text != nil)
                {
                    NSString *emailString = [alertView textFieldAtIndex:0].text;
                    
                    NSString *emailReg = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
                    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailReg];
                    if (([emailTest evaluateWithObject:emailString] != YES) || [emailString isEqualToString:@""])
                    {
                        [Helper ISAlertTypeWarning:@"Warning!" andMessage:@"Please enter a valid email."];

                        
                    }else{
                        NSLog(@"%@", [alertView textFieldAtIndex:0].text);
                        
                        
                        NSMutableDictionary *Parameters = [NSMutableDictionary new];
                        [Parameters setObject:[alertView textFieldAtIndex:0].text forKey:@"email"];
                        [Helper showLoaderVProgressHUD];
                        NSString *string = [NSString stringWithFormat:@"%@app/forgotPassword/",KServiceBaseURL];
                        [DM PostRequest:string parameter:Parameters onCompletion:^(id  _Nullable dict) {
                            NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
                            NSLog(@"ResponseDict %@",responseDict);
                            
                            if ([[responseDict objectForKey:@"responsestatus"] integerValue] == 1) {
                                NSLog(@"%@",[responseDict objectForKey:@"message"]);
                                [Helper ISAlertTypeSuccess:@"Success" andMessage:[responseDict objectForKey:@"message"]];
                            }
                            else{
                                NSLog(@"%@",[responseDict objectForKey:@"message"]);
                                
                                [Helper ISAlertTypeError:@"Error!!" andMessage:[responseDict objectForKey:@"message"]];
                                
                            }
                            [Helper hideLoaderSVProgressHUD];
                            
                            
                        } onError:^(NSError * _Nullable Error) {
                            [Helper hideLoaderSVProgressHUD];
                            NSLog(@"%@",Error);
                            NSString *ErrorString = [NSString stringWithFormat:@"%@",Error];
                            [Helper ISAlertTypeError:ErrorString andMessage:kNOInternet];
                        }];
                        
                        
                        
                        
                        
                        
                    }
                }
            }
            
            
            
            
        }
        
    }
}


-(IBAction)keyborddown:(id)sender{
    
    [self.view endEditing:YES];
}

-(void)Keydow{
    [self.view endEditing:YES];
}


- (IBAction)textFieldDoneEditing:(id)sender {
    [sender resignFirstResponder];
}



-(IBAction)CloseLoginViewButtonPressed:(id)sender{
    [self CloseLoginView];
}


- (IBAction)LoginButtonPressed:(id)sender{
   
    
    [self Keydow];
    [self TextfieldVelidations];
    
    if (message) {
        //[DM.mAppObj.mBaseNavigation.view makeToast:message];
        
        [Helper ISAlertTypeWarning:@"Warning!" andMessage:message];
        
        
    }
    else{
        if (DM.mInternetStatus == false) {
            NSLog(@"No Internet Connection.");
            [Helper ISAlertTypeError:@"Internet Connection!!" andMessage:kNOInternet];
            
            // [DM.mAppObj.mBaseNavigation.view makeToast:kNOInternet];
            return;
        }
        else{
            
            [self LoginWithPFUser:self.mEmailTextField.text :self.mPasswordTextField.text];
            
        }
        
        
        
    }
    
    message = nil;
    
}


static void extracted(ViewController *object) {
    [object getProfile];
}

-(void)LoginWithPFUser:(NSString *)mEmail:(NSString *) mPassword{
    [Helper showLoaderVProgressHUD];

    if (mPassword.length <=0 && mEmail.length<=0) {
        [Helper ISAlertTypeError:@"Login Failed!" andMessage:@"Please enter a valid email or password for login."];

    }
    else {
       
        
        NSMutableDictionary *Parameters = [NSMutableDictionary new];
        [Parameters setObject:mEmail forKey:@"email"];
        [Parameters setObject:mPassword forKey:@"password"];
        
        
        NSString * deviceToken ;
        deviceToken = @"";
        if (DM.deviceTokenForPushNotification == nil || [DM.deviceTokenForPushNotification isKindOfClass:[NSNull class]]) {
            deviceToken = @"No deviceToken";
        }
        else{
            deviceToken = DM.deviceTokenForPushNotification ;
            
        }

         [Parameters setObject:deviceToken forKey:@"deviceToken"];
         [Parameters setObject:@"IOS" forKey:@"deviceType"];
        

        [Helper showLoaderVProgressHUD];
        
        NSString *string = [NSString stringWithFormat:@"%@app/login_User/",KServiceBaseURL];
        [DM PostRequest:string parameter:Parameters onCompletion:^(id  _Nullable dict) {
            NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
            NSLog(@"ResponseDict %@",responseDict);
            
            if ([[responseDict objectForKey:@"responsestatus"] integerValue] == 1) {
                NSLog(@"%@",[responseDict objectForKey:@"message"]);
                
                NSError *errorJson=nil;
                NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:&errorJson];
                
                
                CurrentUser *currentUser = [[CurrentUser alloc] init];
                
                [currentUser setupCurrentUser:[[responseDict valueForKey:@"user"] objectAtIndex:0]];
                [Helper hideLoaderSVProgressHUD];
                extracted(self);
                [Helper ISAlertTypeSuccess:@"Success" andMessage:@"You have successfully logged in"];
                FacebookCheckBool = true;
                self.LoginLable.text = @"Log Out";
                [self RegisterUseronApplogic:[[responseDict valueForKey:@"user"] objectAtIndex:0]];
                ProfileCheckBool = false ;
                [self getProfile];
                [self CloseLoginView];
            }
            else{
                NSLog(@"%@",[responseDict objectForKey:@"message"]);
                [Helper hideLoaderSVProgressHUD];
                [Helper ISAlertTypeError:@"Error!!" andMessage:[responseDict objectForKey:@"message"]];
                
            }
            
            
            
            [Helper hideLoaderSVProgressHUD];
            
            
        } onError:^(NSError * _Nullable Error) {
            [Helper hideLoaderSVProgressHUD];
            NSLog(@"%@",Error);
            NSString *ErrorString = [NSString stringWithFormat:@"%@",Error];
            [Helper ISAlertTypeError:ErrorString andMessage:kNOInternet];
        }];
        
        
        
        
    }
}

-(void)RegisterUseronApplogic :(NSMutableDictionary*)User{
    ALUser *user = [ALUser new];
    user.userId = [User valueForKey:@"fb_id"];
    user.password = APPLICATION_ID;
    user.email = [User valueForKey:@"email"];
    user.displayName = [User valueForKey:@"first_name"];
    NSString * string = [NSString stringWithFormat:@"%@%@",KServiceBaseProfileImageURL,[User valueForKey:@"avatar"]];

    [user setAuthenticationTypeId:(short)CLIENT];
    
    [ALUserDefaultsHandler setUserId:user.userId];
    [ALUserDefaultsHandler setPassword:user.password];
    [ALUserDefaultsHandler setEmailId:user.email];
    [ALUserDefaultsHandler setDisplayName:user.displayName];
    [ALUserDefaultsHandler setProfileImageLink:user.imageLink];
    [ALUserDefaultsHandler setUserAuthenticationTypeId:(short)CLIENT];
    ALChatManager *manager = [[ALChatManager alloc] initWithApplicationKey:APPLICATION_ID]; // SET APPLICATION ID
    [manager registerUserWithCompletion:user withHandler:^(ALRegistrationResponse *rResponse, NSError *error) {
        if (rResponse) {
            NSLog(@"%@",rResponse);
        }
        else{
            NSLog(@"%@",error);
            //[ALUtilityClass showAlertMessage:@"ERROR!!" andTitle:@"Oops!!!"];
        }
        
    }];
}



- (IBAction)DashbordLoginButtonPressed:(id)sender{
    
    self.mEmailTextField.text  = @"";
    self.mPasswordTextField.text = @"";
    
    CurrentUser *currentUser = [[CurrentUser alloc] init];
    [currentUser setupUser:[Helper mCurrentUser]];
    if ([currentUser.mUsers_Id length] == 0) {
        [UIView animateWithDuration:0.5 animations:^{
            self.mLoginView.frame = CGRectMake(self.mLoginView.frame.origin.x,self.view.frame.size.height-self.mLoginView.frame.size.height,self.mLoginView.frame.size.width,self.mLoginView.frame.size.height);
            
        }];
        
        
    }
    else{
        FacebookCheckBool = true;
        [self LogoutFunction];
    }
    
 
}


-(void)CloseLoginView{
    [UIView animateWithDuration:0.5 animations:^{
        self.mLoginView.frame = CGRectMake(self.mLoginView.frame.origin.x,self.view.frame.size.height,self.mLoginView.frame.size.width,self.mLoginView.frame.size.height);
    }];
}

- (IBAction)LoginwithFacebookButtonPressed:(id)sender{
    
    
    
    if (FacebookCheckBool == false) {
        
        if (DM.mInternetStatus == false) {
            NSLog(@"No Internet Connection.");
            [Helper ISAlertTypeError:@"Internet Connection!!" andMessage:kNOInternet];
            
            return;
        }
        else{
            if ([SCFacebook isSessionValid]) {
                [self getUserInfo];
    
            }
            else {
                if (![[NSUserDefaults standardUserDefaults] boolForKey:@"firstTime"])
                {
                    
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[termsAndConditions objectForKey:@"title"]
                                                                 message:[termsAndConditions objectForKey:@"content"]
                                                                 delegate:self
                                                                 cancelButtonTitle:@"Accept"
                                                                 otherButtonTitles:@"Decline", nil];
                    
                    NSArray *subViewArray = alert.subviews;
                    for(int x = 0; x < [subViewArray count]; x++){
                        
                        //If the current subview is a UILabel...
                        if([[[subViewArray objectAtIndex:x] class] isSubclassOfClass:[UILabel class]]) {
                            UILabel *label = [subViewArray objectAtIndex:x];
                            label.textAlignment = NSTextAlignmentJustified;
                        }
                    }
                [alert show];
                }
                else{
                [self loginWithFacebook];
                }
            }
        }

    }
    else{
        
        [self LogoutFunction];
        [Helper ISAlertTypeSuccess:@"Success" andMessage:@"You have successfully logged out"];
    }
}

-(void)LogoutFunction{
    
    self.LoginLable.text = @"Log in";
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kCurrentUser];
    [self logout];
    FacebookCheckBool = false;
    [self LogoutAPiCall];
}


-(void)LogoutAPiCall{
    
    CurrentUser *currentUser = [[CurrentUser alloc] init];
    [currentUser setupUser:[Helper mCurrentUser]];
    NSLog(@"user id %@",currentUser.mUsers_Id);
    
    
    NSMutableDictionary *Parameters = [NSMutableDictionary new];
    [Parameters setObject:currentUser.mUsers_Id forKey:@"user_id"];
    NSString *string = [NSString stringWithFormat:@"%@app/logout/",KServiceBaseURL];
    [DM PostRequest:string parameter:Parameters onCompletion:^(id  _Nullable dict) {
        NSDictionary* responseDict = [NSJSONSerialization  JSONObjectWithData:dict options:kNilOptions error:nil];
        NSLog(@"ResponseDict %@",responseDict);
       
    } onError:^(NSError * _Nullable Error) {
        NSLog(@"%@",Error);
        NSString *ErrorString = [NSString stringWithFormat:@"%@",Error];
    }];
}




- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    if (ForfotPasswordAlert.tag == 10014) {
        
    }else{
        if (buttonIndex == 0) {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstTime"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [self loginWithFacebook];
            
        }
    }
    
    
}


- (void)loginWithFacebook
{
    [SCFacebook loginCallBack:^(BOOL success, id result) {
        if (success) {
            NSLog(@"Success");
            
            [self getUserInfo];
            
        }else{
            NSLog(@"Result %@",[result description]);
        }
    }];
    
}


- (void)getUserInfo
{
    [Helper showLoaderVProgressHUD];
    
    
    [SCFacebook getUserFields:@"id,name,email,picture.width(400).height(400)" callBack:^(BOOL success, id result) {
        if (success) {
            
            NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: [[[result objectForKey:@"picture"] objectForKey:@"data"] objectForKey:@"url"]]];
            UIImage *imageRef = [UIImage imageWithData: imageData];
            
            [_getProfileParameter setObject:[result objectForKey:@"name"] forKey:@"name"];
           
            if ([result objectForKey:@"email"]) {
                NSString * string = [NSString stringWithFormat:@"%@",[result objectForKey:@"email"]];
                if (string.length > 0 && ![string isEqual:[NSNull null]]) {
                     [_getProfileParameter setObject:[result objectForKey:@"email"] forKey:@"email"];
                }else{
                NSString *stringMail = [NSString stringWithFormat:@""];
                    [_getProfileParameter setObject:stringMail forKey:@"email"] ;
                }
            }
            else{
                NSString *stringMail = [NSString stringWithFormat:@""];
                [_getProfileParameter setObject:stringMail forKey:@"email"] ;
            }
            
            [_getProfileParameter setObject:[Helper base64EncodedStringFromImage:imageRef] forKey:@"cover_photo"];
            [_getProfileParameter setObject:[result objectForKey:@"id"] forKey:@"facebookId"];
            
            
            NSString * deviceToken ;
            deviceToken = @"";
            if (DM.deviceTokenForPushNotification == nil || [DM.deviceTokenForPushNotification isKindOfClass:[NSNull class]]) {
                deviceToken = @"No deviceToken";
            }
            else{
                deviceToken = DM.deviceTokenForPushNotification ;
                
            }
            
            
            [_getProfileParameter setObject:deviceToken forKey:@"deviceToken"];
            [_getProfileParameter setObject:@"IOS" forKey:@"deviceType"];
            
            
            

           // NSString *path=[NSString stringWithFormat:@"%@app/login",KServiceBaseURL ];
            NSString *path=[NSString stringWithFormat:@"%@app/loginusertoken",KServiceBaseURL ];

            //http://punditsports.com:81/pundit-ios/v1/App/loginusertoken
            [self RegisterUseronApplogic:_getProfileParameter :[[[result objectForKey:@"picture"] objectForKey:@"data"] objectForKey:@"url"]];

            [DM PostRequest:path parameter:_getProfileParameter onCompletion:^(id  _Nullable dict) {
                [Helper hideLoaderSVProgressHUD];
                NSError *errorJson=nil;
               
                NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:&errorJson];
                
            
                CurrentUser *currentUser = [[CurrentUser alloc] init];
                
                [currentUser setupCurrentUser:[[responseDict valueForKey:@"user"] objectAtIndex:0]];
                [Helper hideLoaderSVProgressHUD];
                ProfileCheckBool = false ;
                [self getProfile];
                [Helper ISAlertTypeSuccess:@"Success" andMessage:@"You have successfully logged in"];
                FacebookCheckBool = true;
                self.LoginLable.text = @"Log Out";
                [self CloseLoginView];

                
            } onError:^(NSError * _Nullable Error) {
                [Helper hideLoaderSVProgressHUD];
                NSString *ErrorString = [NSString stringWithFormat:@"%@",Error];
                [Helper ISAlertTypeError:@"Error!!" andMessage:ErrorString];
            }];
            
        }else{
            [Helper hideLoaderSVProgressHUD];
            NSString *ErrorString = [NSString stringWithFormat:@"%@",[result description]];
            [Helper ISAlertTypeError:@"Error!!" andMessage:ErrorString];
        }
    }];
}

- (void)logout
{
    [SCFacebook logoutCallBack:^(BOOL success, id result) {
        if (success) {
            //NSLog(@"Result %@",[result description]);
        }
    }];
}


-(void)RegisterUseronApplogic :(NSMutableDictionary*)User :(NSString*)UserImageUrl{
    ALUser *user = [ALUser new];
    user.userId = [User valueForKey:@"facebookId"];
    user.password = APPLICATION_ID;
    user.email = [User valueForKey:@"email"];
    user.displayName = [User valueForKey:@"name"];
    user.imageLink = UserImageUrl;
    [user setAuthenticationTypeId:(short)CLIENT];
    
    [ALUserDefaultsHandler setUserId:user.userId];
    [ALUserDefaultsHandler setPassword:user.password];
    [ALUserDefaultsHandler setEmailId:user.email];
    [ALUserDefaultsHandler setDisplayName:user.displayName];
    [ALUserDefaultsHandler setProfileImageLink:user.imageLink];
    [ALUserDefaultsHandler setUserAuthenticationTypeId:(short)CLIENT];
    ALChatManager *manager = [[ALChatManager alloc] initWithApplicationKey:APPLICATION_ID]; // SET APPLICATION ID
    [manager registerUserWithCompletion:user withHandler:^(ALRegistrationResponse *rResponse, NSError *error) {
        if (rResponse) {
            NSLog(@"%@",rResponse);
        }
        else{
            NSLog(@"%@",error);
            //[ALUtilityClass showAlertMessage:@"ERROR!!" andTitle:@"Oops!!!"];
        }
        
    }];
}


#pragma mark ---------------------------------------------------------
#pragma mark LOGIN WITH FACEBOOK END
#pragma mark ---------------------------------------------------------



- (IBAction)BrodcastButtonPressed:(id)sender{
    CurrentUser *currentUser = [[CurrentUser alloc] init];
    [currentUser setupUser:[Helper mCurrentUser]];
    if ([currentUser.mUsers_Id length] == 0) {
        [Helper ISAlertTypeError:@"Log in!!" andMessage:@"Please Login your Account"];
        return;
    }
    else{
        DM.appFlowRef = [NSString stringWithFormat:@"Broadcast"];
        [self performSegueWithIdentifier:@"Broadcast" sender:self];
        NSLog(@"user id %@",currentUser.mUsers_Id);
    }
}

- (IBAction)ListenButtonPressed:(id)sender{
    CurrentUser *currentUser = [[CurrentUser alloc] init];
    [currentUser setupUser:[Helper mCurrentUser]];
    if ([currentUser.mUsers_Id length] == 0) {
        [Helper ISAlertTypeError:@"Log in!!" andMessage:@"Please Login your Account"];
        return;
    }
    else{
        DM.appFlowRef = [NSString stringWithFormat:@"Listen"];
        [self performSegueWithIdentifier:@"Listen" sender:self];
    }
}

- (IBAction)AboutButtonPressed:(id)sender{
    [self performSegueWithIdentifier:@"About" sender:self];
}

- (IBAction)SettingsButtonPressed:(id)sender{
    CurrentUser *currentUser = [[CurrentUser alloc] init];
    [currentUser setupUser:[Helper mCurrentUser]];
    if ([currentUser.mUsers_Id length] == 0) {
        NSLog(@"Not Login");
        [Helper ISAlertTypeError:@"Log in!!" andMessage:@"Please Login your Account"];
        return;
    }
    else{
        [self performSegueWithIdentifier:@"Settings" sender:self];
         //[Helper ISAlertTypeError:@"Coming Soon" andMessage:@"Under Construction"];
    }
}
- (IBAction)ProfileButtonPressed:(id)sender{
    CurrentUser *currentUser = [[CurrentUser alloc] init];
    [currentUser setupUser:[Helper mCurrentUser]];
    if ([currentUser.mUsers_Id length] == 0) {
        [Helper ISAlertTypeError:@"Log in!!" andMessage:@"Please Login your Account"];
        return;
    }
    else{
        [Helper showLoaderVProgressHUD];
        ProfileCheckBool = true ;
        [self getProfile];
    }
    
}

- (void)HomePageContent
{
   // get_image
    // get_image_updated
    
    
    NSString * string = [NSString stringWithFormat:@"%@get_image_updated",kServiceBaseHomePageURL];
    
    [DM GetRequest:string parameter:nil onCompletion:^(id  _Nullable dict) {
        NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
        NSMutableDictionary *mHomePageDict = [[NSMutableDictionary alloc]init];
        mHomePageDict = [responseDict objectForKey:@"ios"];
        NSLog(@"%@",responseDict);

        [self checkDataVersion:[[responseDict objectForKey:@"ios"] valueForKey:@"appVersion"]];
        
        CATransition *transition = [CATransition animation];
        transition.duration = 1.0f;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionFade;
        
        [self.backgroundImageView.layer addAnimation:transition forKey:nil];
        
        
        
        NSString * backgroundImageString = [NSString stringWithFormat:@"%@ios_icons/%@",KserviceBaseIconURL,[mHomePageDict objectForKey:@"background"]];
        NSURL *backgroundImageUrl = [NSURL URLWithString:backgroundImageString];
        [self.backgroundImageView sd_setImageWithURL:backgroundImageUrl completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            DM.backgroundImage = image ;
            self.LoginbackgroundImageView.image = DM.backgroundImage ;
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                self.splashScreenImageView.hidden = YES;
                self.splashScreenView.hidden = YES;
                
            });
            
        }];
        
        
        
        
        NSString * LivebackgroundImageString = [NSString stringWithFormat:@"%@ios_icons/%@",KserviceBaseIconURL,[mHomePageDict objectForKey:@"livematch_background"]];
        NSURL *LivebackgroundImageUrl = [NSURL URLWithString:LivebackgroundImageString];
        UIImageView *imgobj = [[UIImageView alloc] init];
        [imgobj sd_setImageWithURL:LivebackgroundImageUrl completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            DM.LivebackgroundImage = image ;
            
        }];
        
        
        
        
        NSString * string = [NSString stringWithFormat:@"%@ios_icons/%@",KserviceBaseIconURL,[mHomePageDict objectForKey:@"broadcaster"]];
        
        NSURL *url = [NSURL URLWithString:string];
        [self.broadcastButtonImageView sd_setImageWithURL:url];
        NSString * listnerString = [NSString stringWithFormat:@"%@ios_icons/%@",KserviceBaseIconURL,[mHomePageDict objectForKey:@"listeners"]];
        NSURL *listnerUrl = [NSURL URLWithString:listnerString];

       // [ImagesArray addObject:url];
       // [ImagesArray addObject:listnerUrl];
        
        if([[responseDict objectForKey:@"banner_images"]  isEqual: @"null"]){
        }
        else{
            [ImagesArray addObjectsFromArray:[responseDict objectForKey:@"banner_images"]];

        }
        
        [_imagePager reloadData];
        
        [self.listnerButtonImageView sd_setImageWithURL:listnerUrl];
        NSString * settingString = [NSString stringWithFormat:@"%@ios_icons/%@",KserviceBaseIconURL,[mHomePageDict objectForKey:@"setting"]];
        NSString * settingIconString = [NSString stringWithFormat:@"%@ios_icons/%@",KserviceBaseIconURL,[mHomePageDict objectForKey:@"settingicon"]];
        NSURL *settingsUrl = [NSURL URLWithString:settingString];
        NSURL *settingIconUrl =[NSURL URLWithString:settingIconString];
        [self.settingsIcon sd_setImageWithURL:settingIconUrl ];
        [self.settingsImageView addSubview:self.settingsIcon];
        [self.settingsImageView sd_setImageWithURL:settingsUrl placeholderImage:[UIImage imageNamed:@"noimage"]];
        [self.settingsButton addSubview:self.settingsImageView];
        
        NSString * aboutIpunditString = [NSString stringWithFormat:@"%@ios_icons/%@",KserviceBaseIconURL,[mHomePageDict objectForKey:@"about"]];
        NSString * aboutIpunditIconString = [NSString stringWithFormat:@"%@ios_icons/%@",KserviceBaseIconURL,[mHomePageDict objectForKey:@"abouticon"]];
        NSURL *aboutIpunditUrl = [NSURL URLWithString:aboutIpunditString];
        NSURL *aboutIpunditIconUrl =[NSURL URLWithString:aboutIpunditIconString];
        [self.AboutIpunditIconView sd_setImageWithURL:aboutIpunditIconUrl];
        [self.aboutIpunditImageView addSubview:self.AboutIpunditIconView];
        [self.aboutIpunditImageView sd_setImageWithURL:aboutIpunditUrl placeholderImage:[UIImage imageNamed:@"noimage"]];
        [self.aboutPunditButton addSubview:self.aboutIpunditImageView];
        
        NSString * profileString = [NSString stringWithFormat:@"%@ios_icons/%@",KserviceBaseIconURL,[mHomePageDict objectForKey:@"profile"]];
        NSString * profileIconString = [NSString stringWithFormat:@"%@ios_icons/%@",KserviceBaseIconURL,[mHomePageDict objectForKey:@"profileicon"]];
        NSURL *profileUrl = [NSURL URLWithString:profileString];
        NSURL *profileIconUrl =[NSURL URLWithString:profileIconString];
        [self.profileIconView sd_setImageWithURL:profileIconUrl];
        [self.profileImageView addSubview:self.profileIconView];
        [self.profileImageView sd_setImageWithURL:profileUrl placeholderImage:[UIImage imageNamed:@"noimage"]];
        [self.profileButton addSubview:self.profileImageView];
        
        NSString * loginString = [NSString stringWithFormat:@"%@ios_icons/%@",KserviceBaseIconURL,[mHomePageDict objectForKey:@"login"]];
        NSString * loginIconString = [NSString stringWithFormat:@"%@ios_icons/%@",KserviceBaseIconURL,[mHomePageDict objectForKey:@"loginicon"]];
        NSURL *loginUrl = [NSURL URLWithString:loginString];
        NSURL *loginIconUrl =[NSURL URLWithString:loginIconString];
        [self.loginIconView sd_setImageWithURL:loginIconUrl];
        [self.loginImageView addSubview:self.loginIconView];
        [self.loginImageView sd_setImageWithURL:loginUrl placeholderImage:[UIImage imageNamed:@"noimage"]];
        [self.loginButton addSubview:self.loginImageView];
        
    } onError:^(NSError * _Nullable Error) {
        NSLog(@"%@",Error);
    }];
    
}

-(void)getBreakingNews{
    
    NSString * string = [NSString stringWithFormat:@"%@news",kServiceBaseHomePageURL];
    
    [DM GetRequest:string parameter:nil onCompletion:^(id  _Nullable dict) {
        NSMutableArray *breakingNews = [[NSMutableArray alloc]init];
        NSMutableArray *breakingNewsText = [[NSMutableArray alloc]init];
        NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
        breakingNews = [responseDict objectForKey:@"data"];
       for (int i = 0; i < breakingNews.count; i++) {
          [breakingNewsText addObject:[[breakingNews objectAtIndex:i]objectForKey:@"title"]];
       }
        DM.breakingNewsString = [breakingNewsText componentsJoinedByString:@" || "];
        self.breakingNewsLabel.text = DM.breakingNewsString;
        [DM marqueLabel:self.breakingNewsLabel];
    
    } onError:^(NSError * _Nullable Error) {
        NSLog(@"VC Breaking News Error");
    }];
}

-(void)getProfile{
    NSMutableDictionary *parametersGetProfile = [[NSMutableDictionary alloc]init];
    [parametersGetProfile setValue:[[Helper mCurrentUser]objectForKey:@"id"] forKey:@"userid"];
    NSString *path = [NSString stringWithFormat:@"%@App/get_profile",KServiceBaseURL];
    [DM PostRequest:path parameter:parametersGetProfile onCompletion:^(id  _Nullable dict) {
        NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
        if ([responseDict objectForKey:@"tags"] != [NSNull null]  ) {
        NSString *tags = [[responseDict objectForKey:@"tags"]objectForKey:@"tags"];
        DM.tags = [tags componentsSeparatedByString:@","];
        DM.tagsString = tags ;
        }        
        getProfileCurrentUser *currentUser = [[getProfileCurrentUser alloc] init];
        [currentUser setupCurrentUser:[responseDict objectForKey:@"message"]];
        if (ProfileCheckBool == true) {
            [self performSegueWithIdentifier:@"Profile" sender:self];
            [Helper hideLoaderSVProgressHUD];
        }
    } onError:^(NSError * _Nullable Error) {
        NSLog(@"%@",Error);
        [Helper hideLoaderSVProgressHUD];
    }];
    
}

-(void)getTandC{
    termsAndConditions = [[NSMutableDictionary alloc]init];
    NSString *stringPath = [NSString stringWithFormat:@"%@Game/get_term_condition",KServiceBaseURL];

    [DM GetRequest:stringPath parameter:nil onCompletion:^(id  _Nullable dict) {
        NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
        termsAndConditions = [responseDict objectForKey:@"data"];
    } onError:^(NSError * _Nullable Error) {
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



#pragma mark =====================================================
#pragma mark ===============KLIMAGEPAGER START ===================
#pragma mark =====================================================

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    _imagePager.pageControl.currentPageIndicatorTintColor = [UIColor lightGrayColor];
    _imagePager.pageControl.pageIndicatorTintColor = [UIColor blackColor];
    _imagePager.slideshowTimeInterval = 5.5f;
    _imagePager.slideshowShouldCallScrollToDelegate = YES;
}

#pragma mark - KIImagePager DataSource
- (NSArray *) arrayWithImages:(KIImagePager*)pager
{
   // NSLog(@"%@",ImagesArray);
    
    return [ImagesArray valueForKey:@"image"];
}

- (UIViewContentMode) contentModeForImage:(NSUInteger)image inPager:(KIImagePager *)pager
{
    return UIViewContentModeScaleAspectFill;
}

- (NSString *) captionForImageAtIndex:(NSInteger)index inPager:(KIImagePager *)pager
{
    return 0;
}

#pragma mark - KIImagePager Delegate
- (void) imagePager:(KIImagePager *)imagePager didScrollToIndex:(NSUInteger)index
{
    NSLog(@"%s %lu", __PRETTY_FUNCTION__, (unsigned long)index);
}

- (void) imagePager:(KIImagePager *)imagePager didSelectImageAtIndex:(NSUInteger)index
{
    NSLog(@"%s %lu", __PRETTY_FUNCTION__, (unsigned long)index);
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[ImagesArray objectAtIndex:index]valueForKey:@"url"]]];

}


#pragma mark =====================================================
#pragma mark ===============KLIMAGEPAGER END ===================
#pragma mark =====================================================




#pragma mark =====================================================
#pragma mark ===============CHECK DATA VERSION ===================
#pragma mark =====================================================

-(void)checkDataVersion:(NSString *)AppVersion {
    if (USERDEFAULTS(kDataVersion)) {
        mCurrentDataVersion = [AppVersion floatValue];
        float previousVal = [USERDEFAULTS(kDataVersion) floatValue];
        if (mCurrentDataVersion > previousVal) {
            [self LogoutFunction];
            [USER_DEFAULTS setObject:[NSNumber numberWithFloat:mCurrentDataVersion] forKey:kDataVersion];
            [USER_DEFAULTS synchronize];
        }
    }
    else {
        [USER_DEFAULTS setObject:[NSNumber numberWithFloat:1.0f] forKey:kDataVersion];
        [USER_DEFAULTS synchronize];
        [self LogoutFunction];
    }

}

#pragma mark =====================================================
#pragma mark ===============CHECK DATA VERSION ===================
#pragma mark =====================================================




-(void)TextfieldVelidations{
    
    
    if ([self.mEmailTextField.text length ] == 0  || [self.mPasswordTextField.text length] == 0 ) {
        message = @"Please enter a valid email or password for login.";
    }
    
    else{
        if (self.mEmailTextField.text != nil)
        {
            NSString *emailString = self.mEmailTextField.text;
            
            NSString *emailReg = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
            NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailReg];
            if (([emailTest evaluateWithObject:emailString] != YES) || [emailString isEqualToString:@""])
            {
                message = @" Enter Valid Email";
                
                self.mEmailTextField.text = nil;
            }
        }
    }
    
}





- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    if(mLatestPodcastArray.count > 6){
        return 6;
    }
    else
    {
        return mLatestPodcastArray.count;
    }
    
    return mLatestPodcastArray.count;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LatestPodcastsCell *cell = [self.mCollectionView dequeueReusableCellWithReuseIdentifier:@"latestpodcastscell" forIndexPath:indexPath];
    self.mCollectionView.allowsMultipleSelection = NO;
    
    NSDictionary *dct = [mLatestPodcastArray objectAtIndex:indexPath.row];
    cell.mPodcastNameLable.text = [dct valueForKey:@"name"];
    cell.mUserNameLable.text = [dct valueForKey:@"broadcaster_name"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[dct valueForKey:@"league_icon"]]];
    [cell.mImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"noimage"]];
    
    NSURL *url1 = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[dct valueForKey:@"team1_icone"]]];
    [cell.mTeam1ImageView sd_setImageWithURL:url1 placeholderImage:[UIImage imageNamed:@""]];
    NSURL *url2 = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[dct valueForKey:@"team2_icone"]]];
    [cell.mTeam2ImageView sd_setImageWithURL:url2 placeholderImage:[UIImage imageNamed:@""]];
    
    
    
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *index_path = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    NSDictionary *dct = [mLatestPodcastArray objectAtIndex:indexPath.row];
    
    PoadcastDetailVC *destinationVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PoadcastDetailview"];
    
    destinationVC.ChannelArray = [dct valueForKey:@"stream"];
    destinationVC.LIString =[dct valueForKey:@"league_icon"];
    
    [self.navigationController pushViewController:destinationVC animated:YES];
    
}

-(void)GetOtherLeagueStation {
    
    NSString *string = [NSString stringWithFormat:@"%@game/getChannelList/",KServiceBaseURL];
    [DM GetRequest:string parameter:nil onCompletion:^(id  _Nullable dict) {
        NSDictionary* responseDict = [NSJSONSerialization  JSONObjectWithData:dict options:kNilOptions error:nil];
        NSLog(@"ResponseDict %@",responseDict);
        
        [mLatestPodcastArray removeAllObjects];
        [mLatestPodcastArray addObjectsFromArray:[responseDict valueForKey:@"channel"]];
        [self.mCollectionView reloadData];
        
    } onError:^(NSError * _Nullable Error) {
        NSLog(@"%@",Error);
        NSString *ErrorString = [NSString stringWithFormat:@"%@",Error];
        [Helper ISAlertTypeError:@"Error!!" andMessage:ErrorString];
    }];
}



@end
