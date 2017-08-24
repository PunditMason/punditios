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


@interface ViewController (){
    
    BOOL FacebookCheckBool;
    BOOL ProfileCheckBool;
    NSMutableDictionary * termsAndConditions ;
    
    NSTimer *listenersTimer ;
    NSMutableArray *ImagesArray;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //ImagesArray = [[NSMutableArray alloc] init];
        _getProfileParameter =[[NSMutableDictionary alloc]init];
    self.splashScreenView.userInteractionEnabled = NO ;
    self.splashScreenImageView.userInteractionEnabled = NO ;
    self.listenersCountLabel.hidden = YES ;
    self.listenerCountImageView.hidden = YES ;
    self.broadcastersCountLabel.hidden = YES ;
    self.broadcasterCountImageView.hidden = YES ;
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
    [self HomePageContent];
    [self getTandC];
    [self getBreakingNews];
    
    
    NSURL *url1 = [NSURL URLWithString:@"http://punditsports.com:81/pundit-ios/assets/img/ios_icons/21100500_10213824194909008_1136882959_n.jpg"];
    NSURL *url2 = [NSURL URLWithString:@"http://punditsports.com:81/pundit-ios/assets/img/ios_icons/Listening-ios.png"];

    
    NSString *strobj = [NSString stringWithFormat:@"https://raw.github.com/kimar/tapebooth/master/Screenshots/Screen1.png"];
    NSString *strobj2 = [NSString stringWithFormat:@"https://raw.github.com/kimar/tapebooth/master/Screenshots/Screen2.png"];
    
    UIImage *Image1 =[UIImage imageNamed:@"SliderImg1.jpg"];
    UIImage *Image2 =[UIImage imageNamed:@"SliderImg2.png"];

    ImagesArray = [[NSMutableArray alloc] initWithObjects:Image1,Image2, nil];
   
    
    }

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    self.breakingNewsLabel.text = DM.breakingNewsString;
    [DM marqueLabel:self.breakingNewsLabel];
    if ([SCFacebook isSessionValid]) {
        
        CurrentUser *currentUser = [[CurrentUser alloc] init];
        [currentUser setupUser:[Helper mCurrentUser]];
        if ([currentUser.mUsers_Id length] == 0) {
            self.LoginLable.text = @"Log in";
        }
        else{
            FacebookCheckBool = true;
            self.LoginLable.text = @"Log out";
        }
    }
    else {
        self.LoginLable.text = @"Log in";
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
        
        self.LoginLable.text = @"Log in";
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kCurrentUser];
        [self logout];
        [Helper ISAlertTypeSuccess:@"Success" andMessage:@"You have successfully logged out"];
        FacebookCheckBool = false;
    }
    
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstTime"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self loginWithFacebook];

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
            [_getProfileParameter setObject:DM.deviceTokenForPushNotification forKey:@"deviceToken"];

           // NSString *path=[NSString stringWithFormat:@"%@app/login",KServiceBaseURL ];
            NSString *path=[NSString stringWithFormat:@"%@app/loginusertoken",KServiceBaseURL ];

            //http://punditsports.com:81/pundit-ios/v1/App/loginusertoken

            [DM PostRequest:path parameter:_getProfileParameter onCompletion:^(id  _Nullable dict) {
                [Helper hideLoaderSVProgressHUD];
                NSError *errorJson=nil;
               
                NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:&errorJson];
                
            
                CurrentUser *currentUser = [[CurrentUser alloc] init];
                
                [currentUser setupCurrentUser:[[responseDict valueForKey:@"user"] objectAtIndex:0]];
                [Helper hideLoaderSVProgressHUD];
                [self getProfile];
                [Helper ISAlertTypeSuccess:@"Success" andMessage:@"You have successfully logged in"];
                FacebookCheckBool = true;
                self.LoginLable.text = @"Log Out";
                
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
    NSString * string = [NSString stringWithFormat:@"%@get_image",kServiceBaseHomePageURL];
    
    [DM GetRequest:string parameter:nil onCompletion:^(id  _Nullable dict) {
        NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
        NSMutableDictionary *mHomePageDict = [[NSMutableDictionary alloc]init];
        mHomePageDict = [responseDict objectForKey:@"ios"];
        
        CATransition *transition = [CATransition animation];
        transition.duration = 1.0f;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionFade;
        
        [self.backgroundImageView.layer addAnimation:transition forKey:nil];
        
        NSString * backgroundImageString = [NSString stringWithFormat:@"%@ios_icons/%@",KserviceBaseIconURL,[mHomePageDict objectForKey:@"background"]];
        NSURL *backgroundImageUrl = [NSURL URLWithString:backgroundImageString];
        [self.backgroundImageView sd_setImageWithURL:backgroundImageUrl completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            DM.backgroundImage = image ;
            self.splashScreenImageView.hidden = YES;
            self.splashScreenView.hidden = YES;
        }];
        NSString * string = [NSString stringWithFormat:@"%@ios_icons/%@",KserviceBaseIconURL,[mHomePageDict objectForKey:@"broadcaster"]];
        
        NSURL *url = [NSURL URLWithString:string];
        [self.broadcastButtonImageView sd_setImageWithURL:url];
        NSString * listnerString = [NSString stringWithFormat:@"%@ios_icons/%@",KserviceBaseIconURL,[mHomePageDict objectForKey:@"listeners"]];
        NSURL *listnerUrl = [NSURL URLWithString:listnerString];

//        [ImagesArray addObject:url];
//        [ImagesArray addObject:listnerUrl];
//        [_imagePager reloadData];
        
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
    
    _imagePager.pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    _imagePager.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    _imagePager.slideshowTimeInterval = 0.5f;
    _imagePager.slideshowShouldCallScrollToDelegate = YES;
    
}

#pragma mark - KIImagePager DataSource
- (NSArray *) arrayWithImages:(KIImagePager*)pager
{
    
    NSLog(@"Image Array count %lu",(unsigned long)ImagesArray.count);
    return ImagesArray;
}

- (UIViewContentMode) contentModeForImage:(NSUInteger)image inPager:(KIImagePager *)pager
{
    return UIViewContentModeScaleAspectFill;
}

- (NSString *) captionForImageAtIndex:(NSUInteger)index inPager:(KIImagePager* )pager
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
}


#pragma mark =====================================================
#pragma mark ===============KLIMAGEPAGER END ===================
#pragma mark =====================================================

@end
