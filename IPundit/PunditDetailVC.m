//
//  PunditDetailVC.m
//  IPundit
//
//  Created by Deepak  on 22/08/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import "PunditDetailVC.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Additions.h"
#import "Helper.h"

#define kfbPrefixStr @"https://www.facebook.com/"
#define ktwitterPrefixStr @"https://twitter.com/"

@interface PunditDetailVC (){
    UIAlertView * followAlert;
    NSMutableArray * refArray ;

}

@end

@implementation PunditDetailVC
@synthesize dictRefff;

- (void)viewDidLoad {
    [super viewDidLoad];

    self.CurrentALUser = [ALChatManager getLoggedinUserInformation];

    
    NSMutableDictionary * dictRef = [[NSMutableDictionary alloc]init];
    NSLog(@"%@",self.mDataArrayyy);
    if (self.mDataArrayyy) {
        dictRef = [self.mDataArrayyy objectAtIndex:self.mindex.row];
    }
    
    
    
    
    if ([dictRef valueForKey:@"channel_info"]){
        [self.mListenNowButton setImage:[UIImage imageNamed:@"New_Listen Live RED.png"] forState:UIControlStateNormal];
        self.mListenNowButton.enabled = YES ;
    }else{
        [self.mListenNowButton setImage:[UIImage imageNamed:@"New_Listen Live GREY.png"] forState:UIControlStateNormal];
        self.mListenNowButton.enabled = NO ;
    }
    
    NSLog(@"dictRefff     %@",self.dictRefff);
    
    if ([[self.dictRefff objectForKey:@"followCheck"]isEqualToString:@"FALSE"]) {
        [self.mFollowmwButton setTitle:@"FOLLOW ME" forState:UIControlStateNormal];

    }else{
        [self.mFollowmwButton setTitle:@"UNFOLLOW" forState:UIControlStateNormal];

    }
    
    
    if ([[self.dictRefff objectForKey:@"fb_id"] isEqualToString:@""]) {
         self.mFacebookButton.enabled = NO ;
    }
    else{
         self.mFacebookButton.enabled = YES ;
    }
    if ([[self.dictRefff objectForKey:@"twitter"] isEqualToString:@""]) {
        self.mTwitterButton.enabled = NO ;
    }
    else{
        self.mTwitterButton.enabled = YES ;
    }
    if ([[self.dictRefff objectForKey:@"youtube"] isEqualToString:@""]) {
        self.mYoutubeButton.enabled = NO ;
    }
    else{
        self.mYoutubeButton.enabled = YES ;
    }
    
    
    
    self.mFollowersLable.text =[NSString stringWithFormat:@"%@",[self.dictRefff objectForKey:@"followingCount"]];
    self.mFollowingLable.text =[NSString stringWithFormat:@"%@",[self.dictRefff objectForKey:@"followCount"]];
    
    
    
    
    NSString * string = [NSString stringWithFormat:@"%@%@",KServiceBaseProfileImageURL,[self.dictRefff objectForKey:@"avatar"]];
    NSURL *url = [NSURL URLWithString:string];
    [self.mProfileImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"No-following-min"]];
    
    self.nNameLabel.text = [NSString stringWithFormat:@"%@",[self.dictRefff objectForKey:@"first_name"]];
    self.mBioTextView.text = [NSString stringWithFormat:@"%@",[self.dictRefff objectForKey:@"user_bio"]];
    
    
    followAlert = [[UIAlertView alloc] initWithTitle:@"Alert !!"
                                             message:@"You Con't follow your self"
                                            delegate:self
                                   cancelButtonTitle:@"Ok"
                                   otherButtonTitles:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)BackButtonAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];

}
- (IBAction)FollowMeButtonAction:(id)sender{
    
    
    if ([[self.dictRefff objectForKey:@"id"]isEqualToString:[[Helper mCurrentUser]objectForKey:@"id"]]) {

        [followAlert show];
        
    }else{
        NSString *string = [NSString stringWithFormat:@"%@game/followlist/%@/%@",KServiceBaseURL,[[Helper mCurrentUser]objectForKey:@"id"],[self.dictRefff objectForKey:@"id"]];
        [Helper showLoaderVProgressHUD];
        [DM GetRequest:string parameter:nil onCompletion:^(id  _Nullable dict) {
            NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
            
            NSMutableDictionary *data = [[NSMutableDictionary alloc]init];
            data = [responseDict objectForKey:@"data"];
            self.mFollowingLable.text = [NSString stringWithFormat:@"%@",[data objectForKey:@"followingCount"]];
            self.mFollowersLable.text = [NSString stringWithFormat:@"%@",[data objectForKey:@"count"]];
            
            NSString *stringRef = [NSString stringWithFormat:@"%@",[data objectForKey:@"result"]];
            if ([stringRef isEqualToString:@"1"]) {
                [self.mFollowmwButton setTitle:@"UNFOLLOW" forState:UIControlStateNormal];
            }
            else{
                [self.mFollowmwButton setTitle:@"FOLLOW ME" forState:UIControlStateNormal];
            }
            [Helper hideLoaderSVProgressHUD];
            [DM getProfile];
        } onError:^(NSError * _Nullable Error) {
            NSLog(@"Following Functionality Error %@",Error);
            [Helper hideLoaderSVProgressHUD];
        }];
    }
    
}

- (IBAction)ListenLiveButtonAction:(id)sender{
    [self ListenNow];
}

- (IBAction)FacebookButtonAction:(id)sender{
    
   if (DM.mInternetStatus == false) {
        UIAlertView *alrt = [[UIAlertView alloc] initWithTitle:@"Network Error:" message:@"Sorry, your device is not connected to internet." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alrt show];
        alrt = nil;
        return;
    }

     [self openSocialUrl:[NSString stringWithFormat:@"%@%@",kfbPrefixStr,[self.dictRefff objectForKey:@"fb_id"]]];
    
    /*
    NSString *strobj = [NSString stringWithFormat:@"fb://profile/%@",[self.dictRefff objectForKey:@"fb_id"]];
   // NSURL *desiredurl = [NSURL URLWithString:@"fb://profile/1159582604108550"];
    NSURL *desiredurl = [NSURL URLWithString:strobj];

    NSString *openStr = [desiredurl absoluteString];
    if([[UIApplication sharedApplication] canOpenURL:desiredurl]) {
        [self openSocialUrl:openStr];
    }
    else {
        NSArray *mTempArr = [openStr componentsSeparatedByString:@"/"];
        if ([mTempArr count]){
            NSString *postFixStr = [mTempArr lastObject];
            [self openSocialUrl:[NSString stringWithFormat:@"%@%@", kfbPrefixStr, postFixStr]];
        }
    }
     */
    
}

- (IBAction)TwitterButtonAction:(id)sender{
    /*
    if (DM.mInternetStatus == false) {
        UIAlertView *alrt = [[UIAlertView alloc] initWithTitle:@"Network Error:" message:@"Sorry, your device is not connected to internet." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alrt show];
        alrt = nil;
        return;
    }
    
    NSURL *desiredurl = [NSURL URLWithString:@"twitter://user?screen_name=vermz814"];
    NSString *openStr = [desiredurl absoluteString];
    if([[UIApplication sharedApplication] canOpenURL:desiredurl]) {
        [self openSocialUrl:openStr];
    }
    else {
        NSArray *mTempArr = [openStr componentsSeparatedByString:@"="];
        if ([mTempArr count]){
            NSString *postFixStr = [mTempArr lastObject];
            [self openSocialUrl:[NSString stringWithFormat:@"%@%@", ktwitterPrefixStr, postFixStr]];
        }
    }
    
    
    */
    
    [self openSocialUrl:[NSString stringWithFormat:@"https://%@",[self.dictRefff objectForKey:@"twitter"]]];
    
}


- (void)openSocialUrl:(NSString *) linkStr {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:linkStr]];
}

- (IBAction)YoutubeButtonAction:(id)sender{
    
    [self openSocialUrl:[NSString stringWithFormat:@"https://%@",[self.dictRefff objectForKey:@"youtube"]]];
    
}



-(void)ListenNow{
    NSMutableDictionary * dictRef = [[NSMutableDictionary alloc]init];
    dictRef = [_mDataArrayyy objectAtIndex:0];
    ListenMatchDetailVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ListenMatchDetailVC"];
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    dict = [[dictRef valueForKey:@"channel_info"]objectAtIndex:0];
    vc.punditsMessage = @"yes" ;
    vc.channelDict = [dict valueForKey:@"channel"];
    
    
    NSNumber *mChannelKey = [NSNumber numberWithInteger:[[[dict valueForKey:@"channel"] valueForKey:@"chatChannelid"]integerValue]];
    NSLog(@"%@",mChannelKey);
    NSLog(@"%@",self.CurrentALUser.userId);
    ALChannelService * channelService = [[ALChannelService alloc] init];
    [channelService addMemberToChannel:self.CurrentALUser.userId andChannelKey:mChannelKey orClientChannelKey:nil withCompletion:^(NSError *error, ALAPIResponse *response) {
        NSLog(@"%@",response);
        
    }];
    
    
    
    if ([[[dict valueForKey:@"channel"] valueForKey:@"channel_type"]isEqualToString:@"match"]) {
        vc.matchInfoDict = [dict valueForKey:@"match_info"];
    }else{
        vc.matchInfoDict = [dict valueForKey:@"team_info"];
    }
    
    NSLog(@"%@",dict);
    DM.listenerPresentIcon = [NSString stringWithFormat:@"%@",[[dict valueForKey:@"channel"]valueForKey:@"mark_image"]];
    [self.navigationController pushViewController:vc animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
