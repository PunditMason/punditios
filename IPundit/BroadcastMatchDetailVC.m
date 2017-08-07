//
//  BroadcastMatchDetailVC.m
//  IPundit
//
//  Created by Deepak Kumar on 03/03/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import "BroadcastMatchDetailVC.h"
#import "UIImage+animatedGIF.h"
#import "BroadcastMatchDetailCell.h"
#import "UIImageView+WebCache.h"
#import "ALToastView.h"
#import "BroadCastTableViewCell.h"
#import <Social/Social.h>



@interface BroadcastMatchDetailVC (){
    int timeSec ;
    int timeMin ;
    
    int matchTimeSec ;
    int matchTimeMin ;
    
    
    NSTimer * timer;
    NSTimer * matchTimer;
    NSTimer * listnersCount;
    
    NSString * stationName ;
    NSString * teams;
    NSString * channelId;
    NSString * streamName ;
    
    NSMutableDictionary *followInfo ;
    NSMutableDictionary *dictData;
    
    NSMutableArray *referenceArray;

    NSTimer *functionTimer;
    BOOL matchStatusCheck;

    UIAlertView * stopBroadcastingAlert;
    
    
    NSString * sharingString;

}

@end

@implementation BroadcastMatchDetailVC
@synthesize mTableView,matchlist,MatchLiveFeedArray,currentUser;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    matchStatusCheck = YES ;
    
    self.backgroundImageView.image = DM.backgroundImage ;
    
    if (IS_IPHONE4) {
        self.view.frame = CGRectMake(0, 0, 320, 480);
        self.mTableView.frame = CGRectMake(0, 189, 320, 126);
        self.liveView.frame = CGRectMake(0, 314, 320, 166);
        self.mTeamTalkLabel.frame = CGRectMake(20, 205, 275, 44);
    }
    referenceArray = [[NSMutableArray alloc]init];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"equalizer1" withExtension:@"gif"];
    self.animatedImageView.image= [UIImage animatedImageWithAnimatedGIFURL:url];
    
    self.loggedInAsLabel.text =[NSString stringWithFormat:@"Logged in as %@",[[Helper mGetProfileCurrentUser]objectForKey:@"first_name"]];
    
    NSString * iconString = [NSString stringWithFormat:@"%@ios_league_mark/%@",KserviceBaseIconURL,[DM.broadCastPresentData objectForKey:@"icon"]];
    NSURL *iconUrl = [NSURL URLWithString:iconString];
    [self.leaqueIconImageView sd_setImageWithURL:iconUrl placeholderImage:[UIImage imageNamed:@"LeaguesIconDummy.png"]];
   
    
    if ([DM.channelType isEqualToString:@"team"]) {
    [self teamBroadcasting];
    }
    else{
    [self matchBroadcasting];
    }
    [self broadCastStart];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(appDidEnterForeground) name:@"appDidEnterForeground" object:nil];
    
}

-(void)appDidEnterForeground{
    [self BackNavigationFunction];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    NSIndexPath *tableSelection = [self.mTableView indexPathForSelectedRow];
    [self.mTableView deselectRowAtIndexPath:tableSelection animated:NO];
    self.mTableView.separatorColor = [UIColor clearColor];
    
    
}

-(void)teamBroadcasting {
    
    
    self.teamAScoreLabel.hidden = YES ;
    self.teamBscoreLabel.hidden = YES ;
    self.timeCount1.hidden = YES ;
    self.matchStatusLabel.hidden = YES ;


    self.mTeamTalkLabel.hidden = NO ;
    self.teamVsTeamLabel.text  = [NSString stringWithFormat:@"%@",[self.teamBroadCastDict objectForKey:@"contestantName"]];
    self.teamVsTeamLabel2.text = [NSString stringWithFormat:@"%@",[self.teamBroadCastDict objectForKey:@"contestantName"]];
    self.teamANameLabel.text   = [NSString stringWithFormat:@"%@",[self.teamBroadCastDict objectForKey:@"contestantClubName"]];
    self.teamBNameLabel.text   = [NSString stringWithFormat:@"Points - %@",[self.teamBroadCastDict objectForKey:@"points"]];
    self.matchTimeLabel.text = [NSString stringWithFormat:@"Rank - %@",[self.teamBroadCastDict objectForKey:@"rank"]];
    
    sharingString = [NSString stringWithFormat:@"I'm live on Pundit now discussing %@, come join me",[self.teamBroadCastDict objectForKey:@"contestantName"]];
}
-(void)matchBroadcasting {
    
    self.mTeamTalkLabel.hidden = YES ;
    NSString * iconString = [NSString stringWithFormat:@"%@ios_league_mark/%@",KserviceBaseIconURL,[DM.broadCastPresentData objectForKey:@"icon"]];
    NSURL *iconUrl = [NSURL URLWithString:iconString];
    [self.leaqueIconImageView sd_setImageWithURL:iconUrl placeholderImage:[UIImage imageNamed:@"LeaguesIconDummy.png"]];
    teams = [NSString stringWithFormat:@"%@ Vs %@",matchlist.team1_name,matchlist.team2_name];
    self.teamVsTeamLabel.text = teams ;
    self.teamVsTeamLabel2.text =teams ;
   
    
    self.teamANameLabel.text = [NSString stringWithFormat:@"%@",matchlist.team1_name];
    self.teamBNameLabel.text = [NSString stringWithFormat:@"%@",matchlist.team2_name];
    if ([matchlist.matchStatus isEqualToString:@"Fixture"]) {
        self.teamAScoreLabel.text =[NSString stringWithFormat:@": -"];
        self.teamBscoreLabel.text =[NSString stringWithFormat:@": -"];
        self.timeCount1.text = [NSString stringWithFormat:@"- : -"];
    }else{
        self.teamAScoreLabel.text =[NSString stringWithFormat:@": %@",matchlist.team1_score];
        self.teamBscoreLabel.text =[NSString stringWithFormat:@": %@",matchlist.team2_score];
        self.timeCount1.text = [NSString stringWithFormat:@"%@:%@",matchlist.team1_score,matchlist.team2_score];
    }
    if ([matchlist.matchStatus isEqualToString:@"Played"]) {
        self.matchStatusLabel.hidden = YES ;
        self.matchTimeLabel.text = @"FT";
    }
    else if ([matchlist.matchStatus isEqualToString:@"Fixture"])
    {
        self.matchTimeLabel.text = @"Fixture";
        self.matchStatusLabel.hidden = YES ;

    }
    else
    {
        //self.matchTimeLabel.text = [NSString stringWithFormat:@"%@:%@",matchlist.matchLengthMin,matchlist.matchLengthSec];
    }
    
    if ([matchlist.matchStatus isEqualToString:@"Played"]) {
        [self GetMatchLiveFeed];
    }else if ([matchlist.matchStatus isEqualToString:@"Playing"]){
        [self GetMatchLiveFeed];
        functionTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target: self
                                                       selector: @selector(GetMatchLiveFeed) userInfo: nil repeats: YES];
    }else if ([matchlist.matchStatus isEqualToString:@"Fixture"]){
        self.mTeamTalkLabel.hidden = NO ;
        self.mTeamTalkLabel.text = [NSString stringWithFormat:@"No feeds available"];
    }
    
    sharingString = [NSString stringWithFormat:@"I'm live on Pundit now, discussing the game between %@, come join me",teams];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 25;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return referenceArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"BroadCastTableViewCell";
    BroadCastTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;{
    
    NSLog(@"Selected View index=%ld",(long)indexPath.row);
    [mTableView deselectRowAtIndexPath:indexPath animated:NO];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)BackButtonAction:(id)sender {

    
    stopBroadcastingAlert = [[UIAlertView alloc]
                                             initWithTitle:@"Stop Broadcasting !"
                                                       message:@"Are you sure to stop Broadcasting ?"
                                                      delegate:self
                                             cancelButtonTitle:@"Yes"
                                             otherButtonTitles:@"No", nil];
    [stopBroadcastingAlert show];
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (alertView == stopBroadcastingAlert) {
        if (buttonIndex == 0) {
            [self BackNavigationFunction];
        }
    }
}





-(void)BackNavigationFunction{
    [Helper showLoaderVProgressHUD];
    
    NSString * apiString = [NSString stringWithFormat:@"%@Broadcast/unmount/%@",KServiceBaseURL,channelId];
    [DM GetRequest:apiString parameter:nil onCompletion:^(id  _Nullable dict) {
        [functionTimer invalidate];
        [listnersCount invalidate];
        [matchTimer invalidate];
        [timer invalidate];
        [self closeTest];
        [self.navigationController popViewControllerAnimated:YES];
        
        [Helper hideLoaderSVProgressHUD];
    } onError:^(NSError * _Nullable Error) {
        
        NSLog(@"%@",Error);
        
        [self BackButtonAction:nil];
    }];
}



#pragma Mark ================================================================
#pragma Mark Timer
#pragma Mark ================================================================

-(void)StartTimer
{
    listnersCount = [NSTimer scheduledTimerWithTimeInterval:1.0 target: self
                                                   selector: @selector(ListnersCountMethod) userInfo: nil repeats: YES];
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
    self.kickOffTimeLabel.text = timeNow;
    self.timeCount2.text = timeNow ;
}


-(void)ListnersCountMethod{
    
    NSString *path = [NSString stringWithFormat:@"%@Game/ChannelListener_count/%@",KServiceBaseURL,channelId];
    [DM GetRequest:path parameter:nil onCompletion:^(id  _Nullable dict) {
        
    NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
    NSLog(@"%@",responseDict);
    
    self.mListenersCount.text = [NSString stringWithFormat:@"%@",[responseDict objectForKey:@"count"]];
        
    } onError:^(NSError * _Nullable Error) {
        
    }];
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
    self.matchTimeLabel.text = timeNow;
}




- (void)GetMatchLiveFeed{
    
    NSString *path=[NSString stringWithFormat:@"%@Game/getMatchLiveFeedsdata/%@",KServiceBaseURL,matchlist.match_id];
    
    [DM GetRequest:path parameter:nil onCompletion:^(id dict) {
        NSError *errorJson=nil;
        NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:&errorJson];
       
        dictData = [[NSMutableDictionary alloc]init];
        dictData = [responseDict objectForKey:@"matchinfo"];

        self.teamAScoreLabel.text = [NSString stringWithFormat:@": %@",[dictData objectForKey:@"team1_score"]];
        self.teamBscoreLabel.text = [NSString stringWithFormat:@": %@",[dictData objectForKey:@"team2_score"]];
        self.timeCount1.text = [NSString stringWithFormat:@"%@:%@",[dictData objectForKey:@"team1_score"],[dictData objectForKey:@"team2_score"]];
        if (matchStatusCheck == YES) {
            [self MatchDataPost];
        }
        
        referenceArray = [responseDict objectForKey:@"feeds"];
        NSLog(@"%@",referenceArray);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.mTableView reloadData];
            if (referenceArray.count > 5) {
                [mTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:referenceArray.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            }
            
        });
        
    } onError:^(NSError *Error) {
       
        NSLog(@"%@",Error);
        NSString *ErrorString = [NSString stringWithFormat:@"%@",Error];
        [Helper ISAlertTypeError:ErrorString andMessage:kNOInternet];
        
    }];
    
}

-(void)MatchDataPost{
    if ([matchlist.matchStatus isEqualToString:@"Playing"]) {
        NSString * stringMin;
        NSString * stringSec;
      
        if ([[dictData objectForKey:@"st_lengthMin"] isEqual:[NSNull null]]) {
            
            self.matchStatusLabel .hidden = YES ;
            return;
        }
        if ([[dictData objectForKey:@"st_lengthMin"]isEqualToString:@"0"]) {

            stringMin= [NSString stringWithFormat:@"%@",[dictData objectForKey:@"ft_lengthMin"]];
            stringSec = [NSString stringWithFormat:@"%@",[dictData objectForKey:@"ft_lengthSec"]];
            self.matchStatusLabel.text =[NSString stringWithFormat:@"1st Half"];
            
        }
        else{
            
            stringMin= [NSString stringWithFormat:@"%@",[dictData objectForKey:@"st_lengthMin"]];
            stringSec = [NSString stringWithFormat:@"%@",[dictData objectForKey:@"st_lengthSec"]];
            
            self.matchStatusLabel.text =[NSString stringWithFormat:@"2nd Half"];
            
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


- (IBAction)facebookButtonTap:(id)sender {

   [self ShareOnFacebook];
    
}

-(void)ShareFacebook{
  
    NSString *string = [NSString stringWithFormat:@"%@%@",KServiceBaseShareUrl,streamName];
//
//    FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
//    content.contentURL = [NSURL
//                          URLWithString:string];
//    content.contentDescription = [NSString stringWithFormat:@"%@",sharingString];

    //[FBSDKShareDialog showFromViewController:self
     //                            withContent:content
      //                              delegate:nil];
    
//    FBSDKShareDialog *shareDialog = [[FBSDKShareDialog alloc] init];
//    shareDialog.mode = FBSDKShareDialogModeNative;
//    if(shareDialog.canShow) {
//        shareDialog.mode = FBSDKShareDialogModeFeedBrowser;
//    }
//    shareDialog.shareContent = content;
//    shareDialog.delegate = self;
//    [shareDialog show];
    
}

-(void)ShareOnFacebook{
    

    NSString *string = [NSString stringWithFormat:@"%@%@",KServiceBaseShareUrl,streamName];
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewController *tweet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        NSString * stringContent = [NSString stringWithFormat:@"%@",sharingString];
        
      
       
        bool  yes =  [tweet setInitialText:stringContent];
        NSLog(@"%d",yes);
       
        [tweet addURL:[NSURL URLWithString:string]];
        
        [tweet setInitialText:stringContent];
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
        UIAlertView *alert = [[UIAlertView alloc]    initWithTitle:@"Pundit"
            message:@"A Facebook account must be set up on your device."
            delegate:self
            cancelButtonTitle:@"OK"
            otherButtonTitles:nil];
        [alert show];
    }
}


- (IBAction)twitterButtonTap:(id)sender {
  
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        NSString *string = [NSString stringWithFormat:@"%@%@",KServiceBaseShareUrl,streamName];
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

-(void) closeTest{
    
    NSLog(@"closing view");
    
    if( DM.publishStream != nil ){
        [DM.publishStream stop];
    }
    
    if( DM.subscribeStream != nil ){
        [DM.subscribeStream stop];
    }
    
}

-(void)startBroadCasting{
    [Helper showLoaderVProgressHUD];
    DM.refView = self.view ;
    R5Connection* connection = [[R5Connection alloc] initWithConfig:[DM getConfig]];
    [DM setupPublisher:connection];
    [DM.currentView attachStream:DM.publishStream];
    NSString *string   = [NSString stringWithFormat:@"%@",streamName];
    [DM.publishStream publish:string type:R5RecordTypeLive];
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    timeSec = 0;
    timeMin = 0;
    [self StartTimer];
    [Helper hideLoaderSVProgressHUD];
}

-(void) viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    if(DM.currentView != nil){
        [DM.currentView setFrame:[self view].frame];
    }
}

-(void)broadCastStart {
    
    //NSString *  apiString = [NSString stringWithFormat:@"%@app/mount",KServiceBaseURL];
    NSString *  apiString = [NSString stringWithFormat:@"%@app/mountest",KServiceBaseURL];
    NSString *  name;
    NSString *  matchId ;
    if ([DM.channelType isEqualToString:@"match"]) {
        stationName = [NSString stringWithFormat:@"broadcast-%@-%@-%@",[[Helper mCurrentUser]objectForKey:@"id"],matchlist.match_id,[Helper timeStamp]];
        name = [NSString stringWithFormat:@"%@-%@",teams,[[Helper mGetProfileCurrentUser]objectForKey:@"first_name"]];
        matchId = [NSString stringWithFormat:@"%@",matchlist.match_id];
    }else{
        stationName = [NSString stringWithFormat:@"broadcast-%@-%@-%@",[[Helper mCurrentUser]objectForKey:@"id"],[self.teamBroadCastDict objectForKey:@"contestantId"],[Helper timeStamp]];
        name = [NSString stringWithFormat:@"%@-%@",[self.teamBroadCastDict objectForKey:@"contestantName"],[[Helper mGetProfileCurrentUser]objectForKey:@"first_name"]];
        matchId = [NSString stringWithFormat:@"%@",[self.teamBroadCastDict objectForKey:@"contestantId"]];
    }
    
    NSMutableDictionary * parameters = [[NSMutableDictionary alloc]init];
    [parameters setValue:name forKey:@"name"];
    [parameters setValue:matchId forKey:@"match_id"];
    [parameters setValue:[[Helper mCurrentUser]objectForKey:@"id"] forKey:@"broadcaster_id"];
    [parameters setValue:stationName forKey:@"station"];
    [parameters setValue:@"live" forKey:@"appName"];
    [parameters setValue:DM.channelType forKey:@"channel_type"];
    [parameters setValue:[[Helper mGetProfileCurrentUser]objectForKey:@"first_name"] forKey:@"broadcaster_name"];
    [parameters setValue:DM.sportsIdForTrophyVC forKey:@"sport_id"];
    [parameters setValue:DM.leaqueIdForTrophyVC forKey:@"league_id"];

    [DM PostRequest:apiString parameter:parameters onCompletion:^(id  _Nullable dict) {
        
        NSError *errorJson=nil;
        NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:&errorJson];
        channelId = [NSString stringWithFormat:@"%@",[responseDict objectForKey:@"channelid"]];
        streamName = [NSString stringWithFormat:@"%@",[[responseDict objectForKey:@"data"]objectForKey:@"streamName"]];
        
        [self startBroadCasting];
    } onError:^(NSError * _Nullable Error) {
        NSLog(@"%@",Error);
    }];
}


@end
