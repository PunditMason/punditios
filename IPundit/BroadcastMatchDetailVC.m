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
#import <IQKeyboardManager/IQKeyboardManager.h>



@interface BroadcastMatchDetailVC (){
  



}

@end

@implementation BroadcastMatchDetailVC
@synthesize mTableView,matchlist,MatchLiveFeedArray,currentUser,pickerView1,pickerView2;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.CurrentALUser = [ALChatManager getLoggedinUserInformation];

    
    matchStatusCheck = YES ;
    self.mEditScoreButton.hidden = YES ;
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
    myArray1 = @[@"0",@"1", @"2", @"3",@"4", @"5", @"6",@"7", @"8", @"9",@"10", @"11", @"12",@"13", @"14", @"15",@"16", @"17", @"18",@"19", @"20",];
    myArray2 = @[@"0",@"1", @"2", @"3",@"4", @"5", @"6",@"7", @"8", @"9",@"10", @"11", @"12",@"13", @"14", @"15",@"16", @"17", @"18",@"19", @"20",];
    
/*
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Applozic" bundle:[NSBundle bundleForClass:ALChatViewController.class]];

    ChatViewObj = (ALChatViewController *)[storyboard instantiateViewControllerWithIdentifier: @"ALChatViewController"];
    ChatController = [[UINavigationController alloc] initWithRootViewController:ChatViewObj];
    ChatController.navigationBarHidden = YES;
    ChatController.view.frame = CGRectMake(0,80,self.view.frame.size.width,self.view.frame.size.height-130);
    [self.view addSubview:ChatController.view];
    ChatController.view.hidden = YES;
 */
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(CloseChatNotification:)
                                                 name:@"CloseChat" object:nil];
    
}








- (void)CloseChatNotification:(NSNotification *)note {
    
 //   @
    

    
     NSLog(@"%@",note.name);

    if ([note.name isEqualToString:@"CloseChat"]) {
    
    NSLog(@"Received Notification - Someone seems to have CloseChat");
    [self ChatButtonPressed:self];
         }
}

-(void)appDidEnterForeground{
    [self BackNavigationFunction];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
     ChatController.view.frame = CGRectMake(0,80,self.view.frame.size.width,self.view.frame.size.height-130);
    
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [[IQKeyboardManager sharedManager]setKeyboardDistanceFromTextField:3];
    
    
    [self.pickerView1 reloadAllComponents];
    [self.pickerView2 reloadAllComponents];
    
    self.mOverlayView.hidden = YES;
    self.mScoreUpdateView.frame = CGRectMake(self.mScoreUpdateView.frame.origin.x,self.view.frame.size.height,self.mScoreUpdateView.frame.size.width,self.mScoreUpdateView.frame.size.height);
    
    
    NSIndexPath *tableSelection = [self.mTableView indexPathForSelectedRow];
    [self.mTableView deselectRowAtIndexPath:tableSelection animated:NO];
    self.mTableView.separatorColor = [UIColor clearColor];
    
    
}


- (IBAction)ScoreUpdateTap:(id)sender {
    self.mOverlayView.hidden = NO;
    
    
    [UIView animateWithDuration:0.5 animations:^{
        self.mScoreUpdateView.frame = CGRectMake(self.mScoreUpdateView.frame.origin.x,self.view.frame.size.height-self.mScoreUpdateView.frame.size.height,self.mScoreUpdateView.frame.size.width,self.mScoreUpdateView.frame.size.height);
        
    }];

}


- (IBAction)OverlaybackgroundTap:(id)sender {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        self.mOverlayView.hidden = YES;
    });
    
    [UIView animateWithDuration:0.5 animations:^{
        self.mScoreUpdateView.frame = CGRectMake(self.mScoreUpdateView.frame.origin.x,self.view.frame.size.height,self.mScoreUpdateView.frame.size.width,self.mScoreUpdateView.frame.size.height);
    }];
    
}

-(void)teamBroadcasting {
    
    self.mEditScoreButton.hidden = YES ;
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
    self.mTeamANameLable.text = [NSString stringWithFormat:@"%@",matchlist.team1_name];
    self.mTeamBNameLable.text = [NSString stringWithFormat:@"%@",matchlist.team2_name];
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
    
    [self GetMatchLiveFeed];
    functionTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target: self
                                                   selector: @selector(GetMatchLiveFeed) userInfo: nil repeats: YES];
    
    if ([matchlist.matchStatus isEqualToString:@"Played"]) {
        //[self GetMatchLiveFeed];
    }else if ([matchlist.matchStatus isEqualToString:@"Playing"]){
//        [self GetMatchLiveFeed];
//        functionTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target: self
//                                                       selector: @selector(GetMatchLiveFeed) userInfo: nil repeats: YES];
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
                                                   selector: @selector(ListnersCountMethood:) userInfo: nil repeats: YES];
    /*
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerTickk:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    */
}

- (void)timerTickk:(NSTimer *)timer {
    timeSec++;
    if (timeSec == 60)
    {
        timeSec = 0;
        timeMin++;
    }
    NSString* timeNow = [NSString stringWithFormat:@"%02d:%02d", timeMin, timeSec];
    NSLog(@"Broadcast Timer ===========================%@===================================",timeNow);

    self.kickOffTimeLabel.text = timeNow;
    
    self.timeCount2.text = timeNow ;
}


-(void)ListnersCountMethood:(NSTimer *)timer{
    
    NSString *path = [NSString stringWithFormat:@"%@Game/ChannelListener_count/%@",KServiceBaseURL,channelId];
    [DM GetRequest:path parameter:nil onCompletion:^(id  _Nullable dict) {
        
    NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
   // NSLog(@"%@",responseDict);
    
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
       
        dictData = [[NSDictionary alloc]init];

        
        dictData = [Helper formatJSONDict:[responseDict objectForKey:@"matchinfo"]];

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
           // return;
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
        matchStatusCheck = YES ;
    }
}


- (IBAction)facebookButtonTap:(id)sender {

   [self ShareOnFacebook];
    
}

-(void)ShareFacebook{
    //base64EncodedString
  
    NSString *string = [NSString stringWithFormat:@"%@%@",KServiceBaseShareUrl,NewStreamName];
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
    

    NSString *string = [NSString stringWithFormat:@"%@%@",KServiceBaseShareUrl,NewStreamName];
    
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
        NSString *string = [NSString stringWithFormat:@"%@%@",KServiceBaseShareUrl,NewStreamName];
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
    R5Connection* connection = [[R5Connection alloc] initWithConfig:[DM getConfig:kStreemManagerHostIP bufferTime:nil]];
 
    
    [DM setupPublisher:connection];
    [DM.currentView attachStream:DM.publishStream];
    NSString *string   = [NSString stringWithFormat:@"%@",streamName];
   // @Verma [DM.publishStream publish:string type:R5RecordTypeLive];
      [DM.publishStream publish:string type:R5RecordTypeRecord];
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    timeSec = 0;
    timeMin = 0;
    
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        self.kickOffTimeLabel.timerType = MZTimerLabelTypeStopWatch;
        [self.kickOffTimeLabel start];
        
        self.timeCount2.timerType = MZTimerLabelTypeStopWatch;
        [self.timeCount2 start];
        [self StartTimer];
    }];
        [self postNoification];
   //[self StartRecording:streamName];
    [Helper hideLoaderSVProgressHUD];
}

-(void) viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    if(DM.currentView != nil){
        [DM.currentView setFrame:[self view].frame];
    }
}

-(void)broadCastStart {
    
    NSString *  apiString = [NSString stringWithFormat:@"%@app/mount",KServiceBaseURL];
    //NSString *  apiString = [NSString stringWithFormat:@"%@app/mountest",KServiceBaseURL];
    NSString *  name;
    NSString *  matchId ;
    if ([DM.channelType isEqualToString:@"match"]) {
        stationName = [NSString stringWithFormat:@"broadcast-%@-%@-%@",[[Helper mCurrentUser]objectForKey:@"id"],matchlist.match_id,[Helper timeStamp]];
        name = [NSString stringWithFormat:@"%@-%@",teams,[[Helper mGetProfileCurrentUser]objectForKey:@"first_name"]];
        matchId = [NSString stringWithFormat:@"%@",matchlist.match_id];
        notificationString = [NSString stringWithFormat:@"%@ is now the live pundit on %@ , Listen now",[[Helper mGetProfileCurrentUser]objectForKey:@"first_name"],teams];
        //Lets say “Guarav Verma is now the live pundit on Watford vs Brighton, Listen now”
    }else{
        stationName = [NSString stringWithFormat:@"broadcast-%@-%@-%@",[[Helper mCurrentUser]objectForKey:@"id"],[self.teamBroadCastDict objectForKey:@"contestantId"],[Helper timeStamp]];
        name = [NSString stringWithFormat:@"%@-%@",[self.teamBroadCastDict objectForKey:@"contestantName"],[[Helper mGetProfileCurrentUser]objectForKey:@"first_name"]];
        matchId = [NSString stringWithFormat:@"%@",[self.teamBroadCastDict objectForKey:@"contestantId"]];
        notificationString = [NSString stringWithFormat:@"%@ is now the live pundit on %@ , Listen now",[[Helper mGetProfileCurrentUser]objectForKey:@"first_name"],[self.teamBroadCastDict objectForKey:@"contestantName"]];
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
    [parameters setValue:self.ChatChannelid forKey:@"ChatChannelId"];


    [DM PostRequest:apiString parameter:parameters onCompletion:^(id  _Nullable dict) {
        
        NSError *errorJson=nil;
        NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:&errorJson];
        allowScoreEdit = [NSString stringWithFormat:@"%@",[[responseDict objectForKey:@"data"]valueForKey:@"allow_score"]];
    
        
        if ([DM.channelType isEqualToString:@"team"]) {
            self.mEditScoreButton.hidden = YES ;
        }
        
        else{
            if ([allowScoreEdit isEqualToString:@"Yes"]) {
                self.mEditScoreButton.hidden = NO ;
            }else{
                self.mEditScoreButton.hidden = YES ;
            }
        }
        
        
        channelId = [NSString stringWithFormat:@"%@",[responseDict objectForKey:@"channelid"]];
        streamName = [NSString stringWithFormat:@"%@",[[responseDict objectForKey:@"data"]objectForKey:@"streamName"]];
        
       
        NSString *newString = [NSString stringWithFormat:@"%@-%@",[[responseDict objectForKey:@"data"]objectForKey:@"broadcaster_name"],[Helper base64EncodedString:[[responseDict objectForKey:@"data"]objectForKey:@"broadcaster_id"]]];
        
        NewStreamName = [newString stringByReplacingOccurrencesOfString:@" " withString:@""];
        [self StartRecording:streamName];

       // [self startBroadCasting];

        
    } onError:^(NSError * _Nullable Error) {
        NSLog(@"%@",Error);
    }];
}



-(void)StartRecording:(NSString *)stream{
    NSString * path = [NSString stringWithFormat:@"http://54.76.147.237:5080/streammanager/api/2.0/event/live/%@?action=broadcast",stream];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:path]];
    [request setHTTPMethod:@"GET"];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData* data, NSURLResponse* response, NSError *error) {
        NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self startBroadCasting];

        }];
        
        NSLog(@"Request reply: %@", requestReply);

        
    }] resume];
    
}





-(void)ScoreEditable{
    
}

-(void)postNoification{
    
  //  NSString *string = [NSString stringWithFormat:@"%@ is Broadcasting",[[Helper mCurrentUser]objectForKey:@"first_name"]];
    NSMutableDictionary * parameters = [[NSMutableDictionary alloc]init];
    [parameters setValue:[[Helper mCurrentUser]objectForKey:@"id"] forKey:@"id"];
    [parameters setValue:notificationString forKey:@"msg"];

    [DM PostRequest:KServiceBasePushNotificationUrl parameter:parameters onCompletion:^(id  _Nullable dict) {
        
        NSError *errorJson=nil;
        NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:&errorJson];
      //  NSLog(@"%@",responseDict);
    
    } onError:^(NSError * _Nullable Error) {
        NSLog(@"%@",Error);
    }];

    
    
}
- (IBAction)ShareButtonPressed:(id)sender{
    [self HiddenChatView];

     NSString *string = [NSString stringWithFormat:@"%@%@",KServiceBaseShareUrl,NewStreamName];
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
//    [manager launchChatForUserWithDisplayName:self.CurrentALUser.userId withGroupId:[NSNumber numberWithInteger:[self.ChatChannelid intValue]] andwithDisplayName:self.CurrentALUser.displayName andFromViewController:self];
//   
//    return;

    if (!([self.ChatChannelid intValue] == 0)) {
        if (ChatViewCheckBool == FALSE) {
            
            NSNumber *numberobj = [NSNumber numberWithInteger:[self.ChatChannelid intValue]];
            
            NSLog(@"%@",numberobj);

            
            
            ALChannelService * channelService  =  [ALChannelService new];
            [channelService getChannelInformation:numberobj orClientChannelKey:nil withCompletion:^(ALChannel *alChannel) {
                //Channel information
                
                
                //NSLog(@" alChannel ###%@ ", alChannel.name);
                UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Applozic"
                                            
                                                                     bundle:[NSBundle bundleForClass:ALChatViewController.class]];
               
                chatView = (ALChatViewController *) [storyboard instantiateViewControllerWithIdentifier:@"ALChatViewController"];
                
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
            
        }
        else{
            
            [self HiddenChatView];
        }
    }
    else{
        
       UIAlertView *alertobj  =[[UIAlertView alloc]
         initWithTitle:@"Error !!"
         message:@"Unable TO Chat"
         delegate:self
         cancelButtonTitle:@"OK"
         otherButtonTitles:nil, nil];
      //  [alertobj show];
        
        
    }
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

 [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (IBAction)LiveButtonAction:(id)sender {
}

-(void)HiddenChatView{
    ChatController.view.hidden = YES;
    ChatViewCheckBool = false;
    [self keyborddown];
}


-(void)keyborddown{
    
    [self.view endEditing:YES];
}




- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    // Handle the selection
    if (pickerView == pickerView1)
    {
       // self.mTeamAScoreLable = myArray1[row];
    }
    else if (pickerView == pickerView2)
    {
       // self.mTeamBScoreLable = myArray2[row];
    }
}

// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView == pickerView1)
    {
        // First Picker
        return myArray1.count;
    }
    else if (pickerView == pickerView2)
    {
        // Second Picker
        return myArray2.count;
    }
    
    // A third picker passed in somehow
    return 0;
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (pickerView == pickerView1)
    {
        // First Picker
        return 1;
    }
    else if (pickerView == pickerView2)
    {
        // Second Picker
        return 1;
    }
    
    // A third picker passed in somehow
    return 0;
}

// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title;
    
    if (pickerView == pickerView1)
    {
        // First Picker
        self.mTeamAScoreLable.text = myArray1[row];
        title = myArray1[row];
    }
    else if (pickerView == pickerView2)
    {
        // Second Picker
        self.mTeamBScoreLable.text = myArray2[row];
        title = myArray1[row];

    }
    
    return title;
}

// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if (pickerView == pickerView1)
    {
        // First Picker
        return 160;
    }
    else if (pickerView == pickerView2)
    {
        // Second Picker
        return 160;
    }
    
    // A third picker passed in somehow
    return 0;
}

-(void)ScorePost{
    //Parameters => match_id,team1_id,team2_id,team1_score,team2_score
    
    NSString *path = [NSString stringWithFormat:@"%@app/updateScore",KServiceBaseURL];
    NSMutableDictionary * parameters = [[NSMutableDictionary alloc]init];
    [parameters setValue:matchlist.match_id forKey:@"match_id"];
    [parameters setValue:matchlist.team1_id forKey:@"team1_id"];
    [parameters setValue:matchlist.team2_id forKey:@"team2_id"];
    [parameters setValue:self.mTeamAScoreLable.text forKey:@"team1_score"];
    [parameters setValue:self.mTeamBScoreLable.text forKey:@"team2_score"];
    self.mEditScoreButton.enabled = NO;
    
    [DM PostRequest:path parameter:parameters onCompletion:^(id  _Nullable dict)
    {
        
        NSError *errorJson=nil;
        NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:&errorJson];
        NSMutableDictionary * dictRef = [[NSMutableDictionary alloc]init];
        dictRef = [responseDict valueForKey:@"Result"];
        //NSLog(@"%@",responseDict); 
        self.teamAScoreLabel.text =[NSString stringWithFormat:@": %@",[dictRef valueForKey:@"team1_score"]];
        self.teamBscoreLabel.text =[NSString stringWithFormat:@": %@",[dictRef valueForKey:@"team2_score"]];
        self.timeCount1.text = [NSString stringWithFormat:@"%@:%@",[dictRef valueForKey:@"team1_score"],[dictRef valueForKey:@"team2_score"]];
        self.mEditScoreButton.enabled = YES;

    } onError:^(NSError * _Nullable Error) {
        
        [Helper ISAlertTypeError:@"Error Uploading Score" andMessage:[Error localizedDescription]];
        self.mEditScoreButton.enabled = YES;

    }];
}

- (IBAction)ScoreDoneButtonPressed:(id)sender {
    [self ScorePost];
    [self OverlaybackgroundTap:self];
    

}


/*
 ALChannelService * channelService  =  [ALChannelService new];
 [channelService getChannelInformation:[NSNumber numberWithInteger:[self.ChatChannelid intValue]] orClientChannelKey:nil withCompletion:^(ALChannel *alChannel) {
 //Channel information
 
 
 NSLog(@" alChannel ###%@ ", alChannel.name);
 UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Applozic"
 
 bundle:[NSBundle bundleForClass:ALChatViewController.class]];
 
 ALChatViewController *chatView = (ALChatViewController *) [storyboard instantiateViewControllerWithIdentifier:@"ALChatViewController"];
 
 chatView.channelKey = [NSNumber numberWithInteger:[self.ChatChannelid intValue]];
 chatView.text = @"";
 chatView.contactIds = self.CurrentALUser.userId;
 chatView.individualLaunch = YES;
 chatView.displayName = self.CurrentALUser.displayName;
 chatView.chatViewDelegate = self;
 
 
 chatView = (ALChatViewController *)[storyboard instantiateViewControllerWithIdentifier: @"ALChatViewController"];
 ChatController = [[UINavigationController alloc] initWithRootViewController:chatView];
 ChatController.navigationBarHidden = YES;
 ChatController.view.frame = CGRectMake(0,80,self.view.frame.size.width,self.view.frame.size.height-130);
 [self.view addSubview:ChatController.view];
 ChatController.view.hidden = NO;
 }];


*/
@end
