//
//  BroadcastMatchDetailVC.m
//  IPundit
//
//  Created by Deepak Kumar on 03/03/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import "ListenMatchDetailVC.h"
#import "UIImage+animatedGIF.h"
#import "ListenMatchDetailCell.h"
#import "UIImageView+WebCache.h"
#import "DataManager.h"
#import "CurrentUser.h"
#import "ALToastView.h"
#import "BroadcasterTableCell.h"
#import <Social/Social.h>
#import "BroadCastTableViewCell.h"



@interface ListenMatchDetailVC (){
    BOOL ProfileCheckBool;
    BOOL playerCheckBool;
    BOOL matchStatusCheck;
    
    NSMutableDictionary *broadcasterInfo;
    NSMutableDictionary *postingData;
    NSMutableArray *referenceArray;
    NSMutableDictionary * dictData;

    int timeSec ;
    int timeMin ;
    
    int matchTimeSec ;
    int matchTimeMin ;
    
    NSTimer * matchTimer;
    NSTimer *timer;
    NSTimer *functionTimer;
    NSTimer *broadcastersTimer;
    NSTimer * listnersCount;

    
    UIAlertView * checkAlert;
    UIAlertView * broadcasterAlert;
    UIAlertView * followAlert;
    UIAlertView * stopListening;
    UIAlertView * switchBroadcasting;
    
    NSString * listenersUnmountParameter;
    NSString * sharingString;
    
    ALChatViewController *ChatViewObj;
    UINavigationController *ChatController;
    BOOL ChatViewCheckBool;
    
    
}

@end

@implementation ListenMatchDetailVC
@synthesize mTableView,channellist,MatchLiveFeedArray,currentUser,refreshControl;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.CurrentALUser = [ALChatManager getLoggedinUserInformation];

    
    matchStatusCheck = YES;
    self.backgroundImageView.image = DM.backgroundImage ;
    self.broadcasterViewImageView.image = DM.backgroundImage ;
    
    if (IS_IPHONE4) {
        self.view.frame = CGRectMake(0, 0, 320, 480);
        self.broadcastersView.frame = CGRectMake(0, 0, 320, 480);
        self.broadcasterViewImageView.frame = CGRectMake(0, 0, 320, 480);
        self.broadCastersTableView.frame = CGRectMake(10, 132, 300, 320);
        self.mTableView.frame = CGRectMake(0, 191, 320, 157);
        self.liveView.frame = CGRectMake(0, 360, 320, 120);
        self.mTeamTalkLabel.frame = CGRectMake(20, 205, 275, 44);
    }

    referenceArray = [[NSMutableArray alloc]init];
    
    
    
    NSString * iconString = [NSString stringWithFormat:@"%@league_mark/%@",KserviceBaseIconURL,DM.listenerPresentIcon];
    NSURL *iconUrl = [NSURL URLWithString:iconString];
    [self.leagueIconImageView sd_setImageWithURL:iconUrl placeholderImage:[UIImage imageNamed:@"LeaguesIconDummy"]];
    self.broadCastersTableView.tableFooterView = [UIView new];
    
    self.mOverlayView.hidden = YES;
    self.mProfileView.frame = CGRectMake(self.mProfileView.frame.origin.x,self.view.frame.size.height,self.mProfileView.frame.size.width,self.mProfileView.frame.size.height);
    
    NSIndexPath *tableSelection = [self.mTableView indexPathForSelectedRow];
    [self.mTableView deselectRowAtIndexPath:tableSelection animated:NO];
    self.mTableView.separatorColor = [UIColor clearColor];
    
    self.playNPauseImageView.image = [UIImage imageNamed:@"play"];
    
    [self mProfileImageVCCornerRadius];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"listning" withExtension:@"gif"];
    self.animatedImageView.image= [UIImage animatedImageWithAnimatedGIFURL:url];
    
    
    if ([self.punditsMessage isEqualToString:@"yes"]) {
        [self punditsListening];
    }
    else
    {
    if ([DM.channelType isEqualToString:@"team"]) {
        [self teamListening];
    }else{
        [self matchListening];
    }
    }
    refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.tintColor = [UIColor grayColor];
    [refreshControl addTarget:self action:@selector(refershControlAction) forControlEvents:UIControlEventValueChanged];
    [refreshControl setTintColor:[UIColor whiteColor]];
    [refreshControl tintColorDidChange];
    [self.broadCastersTableView addSubview:refreshControl];
    self.broadCastersTableView.alwaysBounceVertical = YES;
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(appDidEnterForeground) name:@"appDidEnterForeground" object:nil];
    
    stopListening = [[UIAlertView alloc] initWithTitle:@"Stop Listening !"
                                               message:@"Are you sure to stop Listening ?"
                                              delegate:self
                                     cancelButtonTitle:@"Yes"
                                     otherButtonTitles:@"No", nil];
    switchBroadcasting = [[UIAlertView alloc] initWithTitle:@"Switch Broadcaster !"
                                               message:@"Are you sure to Switch Broadcaster ?"
                                              delegate:self
                                     cancelButtonTitle:@"Yes"
                                     otherButtonTitles:@"No", nil];
    
    broadcasterAlert = [[UIAlertView alloc] initWithTitle:@"Sorry"
                                                  message:@"No Broadcaster's Available"
                                                 delegate:self
                                        cancelButtonTitle:@"Ok"
                                        otherButtonTitles:nil];
    followAlert = [[UIAlertView alloc] initWithTitle:@"Alert !!"
                                             message:@"You Con't follow your self"
                                            delegate:self
                                   cancelButtonTitle:@"Ok"
                                   otherButtonTitles:nil];
    checkAlert = [[UIAlertView alloc] initWithTitle:@"Sorry"
                                            message:@"Broadcaster Left"
                                           delegate:self
                                  cancelButtonTitle:@"Ok"
                                  otherButtonTitles:nil];
    

    /*
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Applozic" bundle:[NSBundle bundleForClass:ALChatViewController.class]];
    
    ChatViewObj = (ALChatViewController *)[storyboard instantiateViewControllerWithIdentifier: @"ALChatViewController"];
    ChatController = [[UINavigationController alloc] initWithRootViewController:ChatViewObj];
    ChatController.navigationBarHidden = YES;
    ChatController.view.frame = CGRectMake(0,80,self.view.frame.size.width,self.view.frame.size.height-140);
    [self.view addSubview:ChatController.view];
    ChatController.view.hidden = YES;

    */
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(CloseChatNotification:)
                                                 name:@"CloseListenChat" object:nil];
    
}








- (void)CloseChatNotification:(NSNotification *)note {
    
    NSLog(@"%@",note.name);
    
    if ([note.name isEqualToString:@"CloseListenChat"]) {
        
        NSLog(@"Received Notification - Someone seems to have CloseListenChat");
        [self ChatButtonPressed:self];
    }
   }

-(void)appDidEnterForeground{
    [self BackButtonFunctionallity];

}

-(void)refershControlAction{
    
    [self broadcasterLive];
    
    if (DM.liveBroadcastersArray.count == 0) {
       [broadcasterAlert show];
    }
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    ChatController.view.frame = CGRectMake(0,80,self.view.frame.size.width,self.view.frame.size.height-130);

    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [[IQKeyboardManager sharedManager]setKeyboardDistanceFromTextField:3];
    
}


-(void)punditsListening{
    self.punditsMessage = nil ;
    //self.broadcastersView.hidden = YES ;
    
    if ([[self.channelDict valueForKey:@"channel_type"]isEqualToString:@"match"]) {
        channellist = [[ChannelListModel alloc]initWithDictionary:self.matchInfoDict error:nil];
        self.mTeamTalkLabel.hidden = YES ;
        if ([channellist.matchStatus isEqualToString:@"Fixture"]) {
            self.mTeamANameLabel.text = [NSString stringWithFormat:@"%@: -",channellist.team1_name];
            self.mTeamBNameLabel.text = [NSString stringWithFormat:@"%@: -",channellist.team2_name];
        }else{
            self.mTeamANameLabel.text = [NSString stringWithFormat:@"%@: %@",channellist.team1_name,channellist.team1_score];
            self.mTeamBNameLabel.text = [NSString stringWithFormat:@"%@: %@",channellist.team2_name,channellist.team2_score];
        }
        self.mTeamVsTeamLabel.text = [NSString stringWithFormat:@"%@ Vs %@",channellist.team1_name,channellist.team2_name];
        if ([channellist.matchStatus isEqualToString:@"Played"]) {
            self.matchStatus.text = @"FT";
            self.mMatchStatusLabel.hidden = YES;
        }
        else if ([channellist.matchStatus isEqualToString:@"Fixture"])
        {
            self.matchStatus.text = @"Fixture";
            self.mMatchStatusLabel.hidden = YES;
            
        }
        else
        {
            // self.matchStatus.text = [NSString stringWithFormat:@"%@:%@",channellist.matchLengthMin,channellist.matchLengthSec];
        }
        
        sharingString = [NSString stringWithFormat:@"I'm live on Pundit now, listening the game between %@ Vs %@, come join me",channellist.team1_name,channellist.team2_name];
        
    }
    else
    {
    
    self.mTeamTalkLabel.hidden = NO ;
    self.mMatchStatusLabel.hidden = YES ;
    self.mTeamVsTeamLabel.text = [self.matchInfoDict objectForKey:@"contestantName"];
    self.mTeamANameLabel.text = [self.matchInfoDict objectForKey:@"contestantClubName"];
    self.mTeamBNameLabel.text = [NSString stringWithFormat:@"Points - %@",[self.matchInfoDict objectForKey:@"points"]];
    self.matchStatus.text = [NSString stringWithFormat:@"Rank - %@",[self.matchInfoDict objectForKey:@"rank"]];
    
    sharingString = [NSString stringWithFormat:@"I'm live on Pundit now listening %@, come join me",[self.matchInfoDict objectForKey:@"contestantName"]];
    
    }
    DM.liveBroadcastersArray = [[NSMutableArray alloc]init];
    [DM.liveBroadcastersArray addObject:self.channelDict];
    postingData = [[NSMutableDictionary alloc]init];
    postingData = self.channelDict ;
    [self post];

}

-(void)matchListening{
    
    self.mTeamTalkLabel.hidden = YES ;
        if ([channellist.matchStatus isEqualToString:@"Fixture"]) {
        self.mTeamANameLabel.text = [NSString stringWithFormat:@"%@: -",channellist.team1_name];
        self.mTeamBNameLabel.text = [NSString stringWithFormat:@"%@: -",channellist.team2_name];
    }else{
        self.mTeamANameLabel.text = [NSString stringWithFormat:@"%@: %@",channellist.team1_name,channellist.team1_score];
        self.mTeamBNameLabel.text = [NSString stringWithFormat:@"%@: %@",channellist.team2_name,channellist.team2_score];
    }
    self.mTeamVsTeamLabel.text = [NSString stringWithFormat:@"%@ Vs %@",channellist.team1_name,channellist.team2_name];
    if ([channellist.matchStatus isEqualToString:@"Played"]) {
        self.matchStatus.text = @"FT";
        self.mMatchStatusLabel.hidden = YES;
    }
    else if ([channellist.matchStatus isEqualToString:@"Fixture"])
    {
        self.matchStatus.text = @"Fixture";
        self.mMatchStatusLabel.hidden = YES;

    }
    else
    {
       // self.matchStatus.text = [NSString stringWithFormat:@"%@:%@",channellist.matchLengthMin,channellist.matchLengthSec];
    }
    
    sharingString = [NSString stringWithFormat:@"I'm live on Pundit now, listening the game between %@ Vs %@, come join me",channellist.team1_name,channellist.team2_name];
    
}
-(void)teamListening{
    self.mTeamTalkLabel.hidden = NO ;
    self.mMatchStatusLabel.hidden = YES ;
    self.mTeamVsTeamLabel.text = [self.teamListenDetails objectForKey:@"contestantName"];
    self.mTeamANameLabel.text = [self.teamListenDetails objectForKey:@"contestantClubName"];
    self.mTeamBNameLabel.text = [NSString stringWithFormat:@"Points - %@",[self.teamListenDetails objectForKey:@"points"]];
    self.matchStatus.text = [NSString stringWithFormat:@"Rank - %@",[self.teamListenDetails objectForKey:@"rank"]];
    
    sharingString = [NSString stringWithFormat:@"I'm live on Pundit now listening %@, come join me",[self.teamListenDetails objectForKey:@"contestantName"]];

}


#pragma Mark ================================================================
#pragma Mark Tabel View Initialization START
#pragma Mark ================================================================


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.mTableView) {
      return 25;
    }else{
    return 50;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == mTableView) {
        return referenceArray.count;
    }else{

        return DM.liveBroadcastersArray.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == mTableView) {
        static NSString *CellIdentifier = @"BroadCastTableViewCell";
        BroadCastTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        // Configure the cell...
        if (cell == nil) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"BroadCastTableViewCell" owner:self options:0][0];
        }
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        dict = [referenceArray objectAtIndex:indexPath.row];
        if (dict[@"type"]) {
            if ([[dict objectForKey:@"type"]isEqualToString:@"G"]) {
                NSString *string =[NSString stringWithFormat:@"%@:%@",[dict objectForKey:@"scorerName"],[dict objectForKey:@"timeMin"]];
                cell.textlbl.text = string;
                cell.image.image = [UIImage imageNamed:@"g"];
            }
            
            else if ([[dict objectForKey:@"type"]isEqualToString:@"OG"]){
                NSString *string =[NSString stringWithFormat:@"%@:%@",[dict objectForKey:@"scorerName"],[dict objectForKey:@"timeMin"]];
                cell.textlbl.text = string;
                cell.image.image = [UIImage imageNamed:@"og"];
            }
            
            else if ([[dict objectForKey:@"type"]isEqualToString:@"PG"]){
                NSString *string =[NSString stringWithFormat:@"%@:%@",[dict objectForKey:@"scorerName"],[dict objectForKey:@"timeMin"]];
                cell.textlbl.text = string;
                cell.image.image = [UIImage imageNamed:@"pg"];
            }
            
            else if ([[dict objectForKey:@"type"]isEqualToString:@"RC"]){
                NSString *string =[NSString stringWithFormat:@"%@:%@",[dict objectForKey:@"playerName"],[dict objectForKey:@"timeMin"]];
                cell.textlbl.text = string;
                cell.image.image = [UIImage imageNamed:@"redCard"];
            }
            
            else if ([[dict objectForKey:@"type"]isEqualToString:@"Y2C"]){
                NSString *string =[NSString stringWithFormat:@"%@:%@",[dict objectForKey:@"playerName"],[dict objectForKey:@"timeMin"]];
                cell.textlbl.text = string;
                cell.image.image = [UIImage imageNamed:@"Y2Card"];
            }
            else if ([[dict objectForKey:@"type"]isEqualToString:@"PM"]||[[dict objectForKey:@"type"]isEqualToString:@"PS"]){
                NSString *string =[NSString stringWithFormat:@"%@:%@",[dict objectForKey:@"playerName"],[dict objectForKey:@"timeMin"]];
                cell.textlbl.text = string;
                cell.image.image = [UIImage imageNamed:@"PM"];
            }
            else
            {
                NSString *string =[NSString stringWithFormat:@"%@:%@",[dict objectForKey:@"playerName"],[dict objectForKey:@"timeMin"]];
                cell.textlbl.text = string;
                cell.image.image = [UIImage imageNamed:@"yellowCard"];
            }
            
        }else{
            NSString *string1 =[NSString stringWithFormat:@"%@:%@:%@",[dict objectForKey:@"playerOffName"],[dict objectForKey:@"playerOnName"],[dict objectForKey:@"timeMin"]];
            cell.textlbl.text = string1;
            cell.image.image = [UIImage imageNamed:@"sub"];
        }
        UIView *bgColorView = [[UIView alloc] init];
        [bgColorView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3]];
        [cell setSelectedBackgroundView:bgColorView];
        
        
        
    return cell;
    }
    else{
       BroadcasterTableCell * cell = [tableView dequeueReusableCellWithIdentifier:@"broadcaster"];
       if (cell == nil) {
           cell = [[BroadcasterTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"broadcaster"];
       }
       cell.mNameLabel.text = [[DM.liveBroadcastersArray objectAtIndex:indexPath.row]objectForKey:@"broadcaster_name"];
       cell.mTimeLabel.text = [[DM.liveBroadcastersArray objectAtIndex:indexPath.row]objectForKey:@"start_time"];
        UIView *bgColorView = [[UIView alloc] init];
        [bgColorView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3]];
        [cell setSelectedBackgroundView:bgColorView];
        
       return cell;
   }
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
    {
    
    if (tableView == _broadCastersTableView) {
        postingData = [[NSMutableDictionary alloc]init];
        postingData = [DM.liveBroadcastersArray objectAtIndex:indexPath.row];
        
        NSNumber *mChannelKey = [NSNumber numberWithInteger:[[postingData valueForKey:@"chatChannelid"] integerValue]];
        NSLog(@"%@",mChannelKey);
        NSLog(@"%@",self.CurrentALUser.userId);
        ALChannelService * channelService = [[ALChannelService alloc] init];
        [channelService addMemberToChannel:self.CurrentALUser.userId andChannelKey:mChannelKey orClientChannelKey:nil withCompletion:^(NSError *error, ALAPIResponse *response) {
            NSLog(@"%@",response);
            
        }];
        
        [self post];
        
    }else{
    
    NSLog(@"Selected View index=%ld",(long)indexPath.row);
    [mTableView deselectRowAtIndexPath:indexPath animated:NO];
    }
}


-(void)post{
    [self stop];
    [functionTimer invalidate];
    [listnersCount invalidate];

    [broadcastersTimer invalidate];
    self.loggedInAsLabel.text = [NSString stringWithFormat:@"BroadCasting this Game:%@",[postingData objectForKey:@"broadcaster_name"]];
    [self getBroadCastersDetails];
    [UIView animateWithDuration:1.0 animations:^{
        self.broadcastersView.hidden = YES ;
    }];
    broadcastersTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target: self
                                                       selector: @selector(broadcasterCheck) userInfo: nil repeats: YES];
    if ([DM.channelType isEqualToString:@"team"]) {
        [self start];
    }else{
        [self start];
        
        //manoj changes
        [self GetMatchLiveFeed];
        functionTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target: self
                                                       selector: @selector(GetMatchLiveFeed) userInfo: nil repeats: YES];
        if ([channellist.matchStatus isEqualToString:@"Played"]) {
           // [self GetMatchLiveFeed];
        }else if ([channellist.matchStatus isEqualToString:@"Playing"]){
//            [self GetMatchLiveFeed];
//            functionTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target: self
//                                                           selector: @selector(GetMatchLiveFeed) userInfo: nil repeats: YES];
        }else if ([channellist.matchStatus isEqualToString:@"Fixture"]){
            self.mTeamTalkLabel.hidden = NO ;
            self.mTeamTalkLabel.text = [NSString stringWithFormat:@"No feeds available"];
        }
    }

}




#pragma Mark ================================================================
#pragma Mark Tabel View Initialization END
#pragma Mark ================================================================

#pragma Mark ================================================================
#pragma Mark Profile OverLay Show/Hide START
#pragma Mark ================================================================

- (IBAction)ShowHideProfileNameButtonAction:(id)sender{
    [self HiddenChatView];

    if (ProfileCheckBool == false) {
        
        [self.mProfileShowHideButton setImage:[UIImage imageNamed:@"dots.png"] forState:UIControlStateNormal];

        
        self.mOverlayView.hidden = NO;
        [UIView animateWithDuration:0.5 animations:^{
            self.mProfileView.frame = CGRectMake(self.mProfileView.frame.origin.x,self.view.frame.size.height-self.mProfileView.frame.size.height,self.mProfileView.frame.size.width,self.mProfileView.frame.size.height);
            
        }];
        ProfileCheckBool = true;
    }
    else{
        [self OverlaybackgroundTap:self];
    }
    
}


- (IBAction)OverlaybackgroundTap:(id)sender {
    
    [self.mProfileShowHideButton setImage:[UIImage imageNamed:@"dot.png"] forState:UIControlStateNormal];

    ProfileCheckBool = false;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        self.mOverlayView.hidden = YES;
    });
    
    [UIView animateWithDuration:0.5 animations:^{
        self.mProfileView.frame = CGRectMake(self.mProfileView.frame.origin.x,self.view.frame.size.height,self.mProfileView.frame.size.width,self.mProfileView.frame.size.height);
    }];
    
}


-(void)mProfileImageVCCornerRadius{
    CALayer *imageLayera = self.mProfileImageView.layer;
    [imageLayera setCornerRadius:self.mProfileImageView.frame.size.width/2];
    [imageLayera setBorderColor:[[UIColor lightTextColor]CGColor]];
    [imageLayera setBorderWidth:0.5];
    [imageLayera setMasksToBounds:YES];
}


#pragma Mark ================================================================
#pragma Mark Profile OverLay Show/Hide END
#pragma Mark ================================================================


#pragma Mark ================================================================
#pragma Mark BroadCasters View Initialization START
#pragma Mark ================================================================

- (IBAction)FollowButtonPressed:(id)sender {
    
    
    
    if ([[broadcasterInfo objectForKey:@"id"]isEqualToString:[[Helper mCurrentUser]objectForKey:@"id"]]) {
        
        
        [followAlert show];

    }else{
    NSString *string = [NSString stringWithFormat:@"%@game/followlist/%@/%@",KServiceBaseURL,[[Helper mCurrentUser]objectForKey:@"id"],[broadcasterInfo objectForKey:@"id"]];
    [DM GetRequest:string parameter:nil onCompletion:^(id  _Nullable dict) {
        NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
        
        NSMutableDictionary *data = [[NSMutableDictionary alloc]init];
        data = [responseDict objectForKey:@"data"];
        self.mFollowersLabel.text = [NSString stringWithFormat:@"%@",[data objectForKey:@"count"]];
        self.mFollowingLabel.text = [NSString stringWithFormat:@"%@",[data objectForKey:@"followingCount"]];
        NSString *stringRef = [NSString stringWithFormat:@"%@",[data objectForKey:@"result"]];
        if ([stringRef isEqualToString:@"1"]) {
        [self.mFollowButton setImage:[UIImage imageNamed:@"unfollow.png"] forState:UIControlStateNormal];
        }
        else{
        [self.mFollowButton setImage:[UIImage imageNamed:@"follow.png"] forState:UIControlStateNormal];
         }
        [DM getProfile];
    } onError:^(NSError * _Nullable Error) {
        NSLog(@"Following Functionality Error %@",Error);
    }];
    }
}


-(IBAction)FacebookButtonPressed:(id)sender {
    
    if (DM.mInternetStatus == false) {
        UIAlertView *alrt = [[UIAlertView alloc] initWithTitle:@"Network Error:" message:@"Sorry, your device is not connected to internet." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alrt show];
        alrt = nil;
        return;
    }
    
    NSString *path;
    NSString * reference = [NSString stringWithFormat:@"%@",[broadcasterInfo objectForKey:@"facebook"]];
    if (reference.length > 0) {
        path = [NSString stringWithFormat:@"fb://profile/%@",[broadcasterInfo objectForKey:@"facebook"]];
    }else{
        path = [NSString stringWithFormat:@"fb://profile/%@",[broadcasterInfo objectForKey:@"fb_id"]];
    }
    
    NSURL *desiredurl = [NSURL URLWithString:path];
    NSString *openStr = [desiredurl absoluteString];
    if([[UIApplication sharedApplication] canOpenURL:desiredurl]) {
        [self openSocialUrl:openStr];
    }
    else {
         [Helper ISAlertTypeError:@"Sorry" andMessage:@"Page not found"];
    }
    
}

- (void)openSocialUrl:(NSString *) linkStr {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:linkStr]];
}

#pragma Mark ================================================================
#pragma Mark BroadCasters View Initialization START
#pragma Mark ================================================================

-(void)getBroadCastersDetails{
    
    NSString * path = [NSString stringWithFormat:@"%@Game/follow_check/%@/%@/%@",KServiceBaseURL,[postingData objectForKey:@"broadcaster_id"],[[Helper mCurrentUser]objectForKey:@"id"],[postingData objectForKey:@"id"]];
    
    [DM GetRequest:path parameter:nil onCompletion:^(id  _Nullable dict) {
        
        NSError *errorJson=nil;
        NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:&errorJson];
        
        listenersUnmountParameter = [NSString stringWithFormat:@"%@",[responseDict objectForKey:@"listener_id"]];
        
        broadcasterInfo = [[NSMutableDictionary alloc]init];
        broadcasterInfo =  [responseDict objectForKey:@"info"];
        [self BroadCasterDataPost];
        
    } onError:^(NSError * _Nullable Error) {
        NSLog(@"Error %@",Error);
    }];
    
}

-(void)BroadCasterDataPost {
    
    NSString *tags = [broadcasterInfo objectForKey:@"tags"];
    
    self.mTagsLabel.text = tags;
    NSString *userBio = [NSString stringWithFormat:@"%@",[broadcasterInfo objectForKey:@"user_bio"]];
    self.mUserBioTextView.text = userBio ;
    NSLog(@"%@",broadcasterInfo);
    self.mFollowersLabel.text = [NSString stringWithFormat:@"%@",[broadcasterInfo objectForKey:@"following_count"]];
    self.mFollowingLabel.text = [NSString stringWithFormat:@"%@",[broadcasterInfo objectForKey:@"follower_count"]];
    
    self.userNameLabel.text = [broadcasterInfo objectForKey:@"first_name"] ;
    NSString * string = [NSString stringWithFormat:@"%@%@",KServiceBaseProfileImageURL,[broadcasterInfo objectForKey:@"avatar"]];
    NSURL *url = [NSURL URLWithString:string];
    
    [self.mProfileImageView sd_setImageWithURL:url completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        UIImage *img1 = [UIImage blur:image withRadius:10.0f];
        self.mProfileBlurImageView.image = img1;
    }];
    
    NSString *stringComp = [NSString stringWithFormat:@"%@",[broadcasterInfo objectForKey:@"follow"]];
    if ([stringComp isEqualToString:@"0"]) {
        [self.mFollowButton setImage:[UIImage imageNamed:@"follow.png"] forState:UIControlStateNormal];
        
    }else{
        [self.mFollowButton setImage:[UIImage imageNamed:@"unfollow.png"] forState:UIControlStateNormal];
    }
    
}

#pragma Mark ================================================================
#pragma Mark BroadCasters View Initialization END
#pragma Mark ================================================================

#pragma Mark ================================================================
#pragma Mark Social Sharing START
#pragma Mark ================================================================


- (IBAction)FacebookShareButtonPressed:(id)sender {
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewController *tweet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        NSString *NewStreamName = [NSString stringWithFormat:@"%@-%@",[[postingData objectForKey:@"data"]objectForKey:@"broadcaster_name"],[Helper base64EncodedString:[[postingData objectForKey:@"data"]objectForKey:@"broadcaster_id"]]];
        
        NewStreamName = [NSString stringWithFormat:@"%@%@",KServiceBaseShareUrl,NewStreamName]
        ;
        NSString *string = [NewStreamName stringByReplacingOccurrencesOfString:@" " withString:@""];

        
        NSURL * urlString = [NSURL URLWithString:string];
        NSString * stringContent = [NSString stringWithFormat:@"%@",sharingString];
        [tweet setInitialText:stringContent];
        [tweet addURL:urlString];
        [tweet setCompletionHandler:^(SLComposeViewControllerResult result)
         {
             if (result == SLComposeViewControllerResultCancelled)
             {
                 NSLog(@"The user cancelled.");
                 [Helper ISAlertTypeError:@"UnSuccessfully" andMessage:@"The user cancelled."];
                 
             }
             else if (result == SLComposeViewControllerResultDone)
             {
                 NSLog(@"The user posted to Facebook");
                 [Helper ISAlertTypeSuccess:@"Success" andMessage:@"Posted Successfully"];
                 
             }
         }];
        [self presentViewController:tweet animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Pundit"
                                                        message:@"A Facebook account must be set up on your device."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }

}


- (IBAction)TwitterShareButtonPressed:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        
        NSString *NewStreamName = [NSString stringWithFormat:@"%@-%@",[[postingData objectForKey:@"data"]objectForKey:@"broadcaster_name"],[Helper base64EncodedString:[[postingData objectForKey:@"data"]objectForKey:@"broadcaster_id"]]];
        
        
        NewStreamName = [NSString stringWithFormat:@"%@%@",KServiceBaseShareUrl,NewStreamName]
        ;
        NSString *string = [NewStreamName stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        
        
        
 
        NSString * stringContent = [NSString stringWithFormat:@"%@",sharingString];
        [tweet setInitialText:stringContent];
        [tweet addURL:[NSURL URLWithString:string]];
        [tweet setCompletionHandler:^(SLComposeViewControllerResult result)
         {
             if (result == SLComposeViewControllerResultCancelled)
             {
                 NSLog(@"The user cancelled.");
                 [Helper ISAlertTypeError:@"UnSuccessfully" andMessage:@"The user cancelled."];
             }
             else if (result == SLComposeViewControllerResultDone)
             {
                 NSLog(@"The user sent the tweet");
                 [Helper ISAlertTypeSuccess:@"Success" andMessage:@"Twitted Successfully"];
             }
         }];
        [self presentViewController:tweet animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Pundit"
                                                        message:@"A Twitter account must be set up on your device."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
    
}

#pragma Mark ================================================================
#pragma Mark Social Sharing END
#pragma Mark ================================================================

#pragma Mark ================================================================
#pragma Mark Player Initialization START
#pragma Mark ================================================================

-(void) StartTimer
{
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerTick:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}

- (void)timerTick:(NSTimer *)timer {
    timeSec++;
    if (timeSec == 60)
    {
        timeSec = 0;
        timeMin++;
    }
    NSString* timeNow = [NSString stringWithFormat:@"%02d:%02d", timeMin, timeSec];
    self.mKickOFTimeLabel.text = timeNow;
}

/*
#pragma Mark Switch Broadcaster
 */
- (IBAction)SitchBroadcasterTap:(id)sender {
    [self HiddenChatView];
    [switchBroadcasting show];
}
-(void)switchBroadcasterFunctionallity{
    [self stop];
    [self UnMount];
    [self invalidate];
    [listnersCount invalidate];
    [UIView animateWithDuration:1.0 animations:^{
        self.broadcastersView.hidden = NO ;
    }];
}

- (void)start {
    [Helper showLoaderVProgressHUD];
    R5Connection *connection = [[R5Connection new] initWithConfig:[DM getConfig]];
    DM.refView = self.view;
    DM.stream = [[R5Stream new] initWithConnection:connection];
    [DM.currentView attachStream:DM.stream];
    [DM.stream play:[postingData objectForKey:@"streamName"]];
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    timeSec = 0;
    timeMin = 0;
    self.playNPauseImageView.image = [UIImage imageNamed:@"stop"];
    self.playNPuseButton.enabled = YES ;
    playerCheckBool = true ;
    [self StartTimer];
    [self ListnersStartTimer];
    [Helper hideLoaderSVProgressHUD];
}

- (void)stop {
    [Helper showLoaderVProgressHUD];
    [DM.stream stop];
    [timer invalidate];
    [listnersCount invalidate];
    playerCheckBool = false ;
    self.playNPauseImageView.image = [UIImage imageNamed:@"play"];
    self.playNPuseButton.enabled = NO ;

    [Helper hideLoaderSVProgressHUD];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self stop];
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}



- (IBAction)goToLiveButtonTap:(id)sender {
    
    
}

#pragma Mark ================================================================
#pragma Mark Player Initialization END
#pragma Mark ================================================================


#pragma Mark ================================================================
#pragma Mark Get_Match_LiveFeeds START
#pragma Mark ================================================================


- (void)GetMatchLiveFeed{
    
    NSString *path=[NSString stringWithFormat:@"%@Game/getMatchLiveFeedsdata/%@",KServiceBaseURL,channellist.match_id];
    [DM GetRequest:path parameter:nil onCompletion:^(id dict) {
        NSError *errorJson=nil;
        NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:&errorJson];
        dictData = [[NSMutableDictionary alloc]init];
        NSLog(@"%@",[responseDict objectForKey:@"matchinfo"]);
        dictData = [[Helper formatJSONDict:[responseDict objectForKey:@"matchinfo"]]mutableCopy];
        
    
        self.mTeamANameLabel.text = [NSString stringWithFormat:@"%@:  %@",channellist.team1_name,[dictData objectForKey:@"team1_score"]];
        self.mTeamBNameLabel.text = [NSString stringWithFormat:@"%@:  %@",channellist.team2_name,[dictData objectForKey:@"team2_score"]];
       
        referenceArray = [responseDict objectForKey:@"feeds"];
        NSLog(@"%@",referenceArray);
        if (matchStatusCheck == YES) {
            [self MatchDataPost];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.mTableView reloadData];
            if (referenceArray.count > 5) {
                [mTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:referenceArray.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            }
        });
        
    } onError:^(NSError *Error) {
        
        NSLog(@"%@",Error);
       
    }];
}

-(void)MatchDataPost{
    if ([channellist.matchStatus isEqualToString:@"Playing"]) {
        NSString * stringMin;
        NSString * stringSec;
        if ([[dictData objectForKey:@"st_lengthMin"] isEqual:[NSNull null]]) {
            self.mMatchStatusLabel .hidden = YES ;
            return;
        }
        if (![[dictData objectForKey:@"st_lengthMin"]isEqualToString:@"0"]) {
            stringMin= [NSString stringWithFormat:@"%@",[dictData objectForKey:@"st_lengthMin"]];
            stringSec = [NSString stringWithFormat:@"%@",[dictData objectForKey:@"st_lengthSec"]];
            self.mMatchStatusLabel.text =[NSString stringWithFormat:@"2nd Half"];
        }
        else{
            stringMin= [NSString stringWithFormat:@"%@",[dictData objectForKey:@"ft_lengthMin"]];
            stringSec = [NSString stringWithFormat:@"%@",[dictData objectForKey:@"ft_lengthSec"]];
            self.mMatchStatusLabel.text =[NSString stringWithFormat:@"1st Half"];
        }
        
        if ([stringMin isEqualToString:@"(null)"]||[stringMin isEqualToString:@"(null)"])
        {
            matchTimeMin = 0 ;
            matchTimeSec = 0 ;
        }else{
            matchTimeMin = [stringMin intValue];
            matchTimeSec = [stringSec intValue];
        }
        [self MatchStartTimer];
        matchStatusCheck = NO ;
    }
}

#pragma Mark ================================================================
#pragma Mark Get_Match_LiveFeeds END
#pragma Mark ================================================================


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)BackButtonAction:(id)sender {
    if (_broadcastersView.hidden == NO) {
        [self BackButtonFunctionallity];
    }else{
    [stopListening show];
    }
}


-(void)BackButtonFunctionallity {
    [self UnMount];
    [self invalidate];
    [listnersCount invalidate];
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)mPlaynPauseButton:(id)sender {
    if (playerCheckBool == true) {    
        [self stop];
    }else{
        [Helper showLoaderVProgressHUD];
        self.playNPuseButton.enabled = NO ;
        [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(ButtonPressed) userInfo:nil repeats:NO];
    }
}
-(void)ButtonPressed{
    [self start];
    [Helper hideLoaderSVProgressHUD];
}


-(void)broadcasterCheck{
    
    [self broadcasterLive];
    NSMutableArray * refArray = [[NSMutableArray alloc]init];
    NSMutableArray * checkArray = [[NSMutableArray alloc]init];
    [refArray addObjectsFromArray:DM.liveBroadcastersArray];
    for (NSDictionary *MatchObj in refArray) {
        [checkArray addObject:[MatchObj objectForKey:@"streamName"]];
    }
    NSString * checkString = [NSString stringWithFormat:@"%@",[postingData objectForKey:@"streamName"]];
    if (![checkArray containsObject:checkString]) {
        [broadcastersTimer invalidate];
        [listnersCount invalidate];
        [timer invalidate];
        [checkAlert show];
    }
}

-(void)broadcasterLive{
    NSString * path ;
    if ([DM.channelType isEqualToString:@"team"]) {
      path = [NSString stringWithFormat:@"%@Game/broadcaster_detail/%@",KServiceBaseURL,[postingData objectForKey:@"match_id"]];
    }else{
        path = [NSString stringWithFormat:@"%@Game/broadcaster_detail/%@",KServiceBaseURL,channellist.match_id];
    }
    
    [DM GetRequest:path parameter:nil onCompletion:^(id  _Nullable dict) {
        NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
        NSLog(@"%@",responseDict);
        DM.liveBroadcastersArray = [[NSMutableArray alloc]init];
        DM.liveBroadcastersArray = [responseDict objectForKey:@"channel"];
        [self.broadCastersTableView reloadData];
        [refreshControl endRefreshing];
        
    } onError:^(NSError * _Nullable Error) {
    }];
}


- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {

    if (alertView == broadcasterAlert)
    {
        [self UnMount];
        [self invalidate];

    }
    else if(alertView == checkAlert)
    {
        if (DM.liveBroadcastersArray.count == 0) {
            [self UnMount];
            [self invalidate];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else{
            [self UnMount];
            [self invalidate];
            [self switchBroadcasterFunctionallity];
        }
    }
    else if (alertView == stopListening)
    {
        if (buttonIndex == 0) {
        [self BackButtonFunctionallity];
        }
    }else if (alertView == switchBroadcasting)
    {
        if (buttonIndex == 0) {
        [self switchBroadcasterFunctionallity];
        }
    }
}

-(void)MatchStartTimer
{
    matchTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(MatchTimerTick:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:matchTimer forMode:NSDefaultRunLoopMode];
}

- (void)MatchTimerTick:(NSTimer *)timer {
    matchTimeSec++;
    if (matchTimeSec == 60)
    {
        matchTimeSec = 0;
        matchTimeMin++;
    }
    NSString* timeNow = [NSString stringWithFormat:@"%02d:%02d", matchTimeMin, matchTimeSec];
    self.matchStatus.text = timeNow;
}

-(void)UnMount{
    [Helper showLoaderVProgressHUD];
    NSString * path = [NSString stringWithFormat:@"%@Game/listeners_unmount/%@",KServiceBaseURL,listenersUnmountParameter];
    [DM GetRequest:path parameter:nil onCompletion:^(id  _Nullable dict) {
        [Helper hideLoaderSVProgressHUD];
    } onError:^(NSError * _Nullable Error) {
        [Helper hideLoaderSVProgressHUD];
    }];
}

-(void)invalidate{
    [functionTimer invalidate];
    [matchTimer invalidate];
    [timer invalidate];
    [broadcastersTimer invalidate];
    [listnersCount invalidate];

}

- (IBAction)ShareButtonPressed:(id)sender{
    [self HiddenChatView];
    
    NSString *NewStreamName = [NSString stringWithFormat:@"%@-%@",[[postingData objectForKey:@"data"]objectForKey:@"broadcaster_name"],[Helper base64EncodedString:[[postingData objectForKey:@"data"]objectForKey:@"broadcaster_id"]]];
    
    NewStreamName = [NSString stringWithFormat:@"%@%@",KServiceBaseShareUrl,NewStreamName]
    ;
    NSString *string = [NewStreamName stringByReplacingOccurrencesOfString:@" " withString:@""];

    
    [self shareText:sharingString andImage:nil andUrl:[NSURL URLWithString:string]];
}

- (void)shareText:(NSString *)text andImage:(UIImage *)image andUrl:(NSURL *)url
{
    NSMutableArray *sharingItems = [NSMutableArray new];
    if (text) {
        [sharingItems addObject:text];
    }
    if (image) {
        [sharingItems addObject:image];
    }
    if (url) {
        [sharingItems addObject:url];
    }
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:sharingItems applicationActivities:nil];
    [self presentViewController:activityController animated:YES completion:nil];
}

- (IBAction)ChatButtonPressed:(id)sender{
    


//    ALChatManager *manager = [[ALChatManager alloc] initWithApplicationKey:APPLICATION_ID]; // SET APPLICATION ID
//    [manager launchChatForUserWithDisplayName:self.CurrentALUser.userId withGroupId:[NSNumber numberWithInteger:[[postingData valueForKey:@"chatChannelid"] integerValue]] andwithDisplayName:self.CurrentALUser.displayName andFromViewController:self];
//
//    return;

   

    if (!([[postingData valueForKey:@"chatChannelid"] integerValue] == 0)) {
        
        if (ChatViewCheckBool == FALSE) {
            NSNumber *numberobj = [NSNumber numberWithInteger:[[postingData valueForKey:@"chatChannelid"] integerValue]];
            
            ALChannelService * channelService  =  [ALChannelService new];
            [channelService getChannelInformation:numberobj orClientChannelKey:nil withCompletion:^(ALChannel *alChannel) {
                //Channel information
                
                
                NSLog(@" alChannel ###%@ ", alChannel.name);
                UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Applozic"
                                            
                                                                     bundle:[NSBundle bundleForClass:ALChatViewController.class]];
                
                ALChatViewController *chatView = (ALChatViewController *) [storyboard instantiateViewControllerWithIdentifier:@"ALChatViewController"];
                
                chatView.channelKey = numberobj;
                chatView.text = @"";
                chatView.contactIds = self.CurrentALUser.userId;
                chatView.individualLaunch = YES;
                chatView.displayName = self.CurrentALUser.displayName;
                chatView.chatViewDelegate = self;
                
                
                ChatController = [[UINavigationController alloc] initWithRootViewController:chatView];
                ChatController.navigationBarHidden = YES;
                //ChatController.view.frame = CGRectMake(0,80,self.view.frame.size.width,self.view.frame.size.height-130);
                
                ChatController.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y,self.view.frame.size.width,self.view.frame.size.height);
                
                [self.view addSubview:ChatController.view];
                
                ChatController.view.hidden = NO;
            }];
            ChatController.view.hidden = NO;
            ChatViewCheckBool = true;
            
        }else{
            
            [self HiddenChatView];
        }
        
    }
    else{
        
        UIAlertView *alertobj  =[[UIAlertView alloc]
                                 initWithTitle:@"Error !!"
                                 message:@"Unable TO Chat with this USER"
                                 delegate:self
                                 cancelButtonTitle:@"OK"
                                 otherButtonTitles:nil, nil];
        [alertobj show];
        
        
    }
    
    
}



-(void)HiddenChatView{
    ChatController.view.hidden = YES;
    ChatViewCheckBool = false;
    [self keyborddown];
}


-(void)keyborddown{
    
    [self.view endEditing:YES];
}

-(void)ListnersStartTimer
{
    listnersCount = [NSTimer scheduledTimerWithTimeInterval:1.0 target: self
                                                   selector: @selector(ListnersCountMethod) userInfo: nil repeats: YES];
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerTick:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}

-(void)ListnersCountMethod{
    
    NSString *path = [NSString stringWithFormat:@"%@Game/ChannelListener_count/%@",KServiceBaseURL,[postingData objectForKey:@"id"]];
    [DM GetRequest:path parameter:nil onCompletion:^(id  _Nullable dict) {
        
        NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
        NSLog(@"%@",responseDict);
        
        self.mListenersCountLabel.text = [NSString stringWithFormat:@"%@",[responseDict objectForKey:@"count"]];
        
    } onError:^(NSError * _Nullable Error) {
        
    }];
}

@end
