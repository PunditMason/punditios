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
#import "LineupCell.h"



@interface ListenMatchDetailVC (){
    
    NSMutableArray *mPlayers1Array;
    NSMutableArray *mPlayers2Array;
    NSMutableArray *mGoals1Array;
    NSMutableArray *mGoals2Array;
    NSMutableArray *msubstitution1Array;
    NSMutableArray *msubstitution2Array;
    NSMutableArray *mFinalGoalsArray;
    NSMutableArray *mFinalsubstitutionArray;
    NSArray *mFinalOverviewArray;
}

@end

@implementation ListenMatchDetailVC
@synthesize mTableView,mLineupTableView,channellist,MatchLiveFeedArray,currentUser,refreshControl;


- (void)viewDidLoad {
    [super viewDidLoad];
    [self CallRefresh];
}

-(void)CallRefresh{
    
    mFinalsubstitutionArray = [[NSMutableArray alloc]init];
    mFinalGoalsArray =[[NSMutableArray alloc]init];
    mPlayers1Array =[[NSMutableArray alloc]init];
    mPlayers2Array =[[NSMutableArray alloc]init];
    mGoals1Array =[[NSMutableArray alloc]init];
    mGoals2Array =[[NSMutableArray alloc]init];
    msubstitution1Array =[[NSMutableArray alloc]init];
    msubstitution2Array =[[NSMutableArray alloc]init];
    
    self.mMatchStatusLabel.text = @"-";
    
    if ([self.ViewName isEqualToString:@"PunditDetail"]) {
    }
    else{
        if (self.mrliveBroadcastersArray.count > 0) {
            self.broadcastersView.hidden = NO ;
            
        }
        else{
            [self GetMatchLiveFeed];
            self.broadcastersView.hidden = YES ;
            self.mProfileShowHideButtonn.enabled = false;
            self.mSitchBroadcasterButton.enabled = false;
            self.mShareButtonButton.enabled = false;
            self.mRefreshListener.enabled = false;
            
        }
    }
    
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
                                                  message:@"No Matches Available"
                                                 delegate:self
                                        cancelButtonTitle:@"Ok"
                                        otherButtonTitles:nil];
    followAlert = [[UIAlertView alloc] initWithTitle:@"Bit Much?!!"
                                             message:@"Following yourself!?"
                                            delegate:self
                                   cancelButtonTitle:@"Shame"
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
    
    
    // bufferTime  = 1.0;
    
    self.breakingNewsLabel.text = DM.LequebreakingNewsString ;
    [DM marqueLabel:self.breakingNewsLabel];
    
    [self.mOverviewButton setImage:[UIImage imageNamed:@"OverviewButtonSelected"] forState:UIControlStateNormal];
    self.mTableView.hidden = false;
    self.mLineupTableView.hidden = true;
    [self.mLineupButton setImage:[UIImage imageNamed:@"LineupButton"] forState:UIControlStateNormal];
    
    self.mTableView.delegate = self;
    self.mTableView.dataSource = self;
    self.mLineupTableView.delegate = self;
    self.mLineupTableView.dataSource = self;
    
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
    
    
    NSIndexPath *tableSelection = [self.mTableView indexPathForSelectedRow];
    [self.mTableView deselectRowAtIndexPath:tableSelection animated:NO];
    self.mTableView.separatorColor = [UIColor clearColor];
    
    NSIndexPath *LineupTableSelection = [self.mLineupTableView indexPathForSelectedRow];
    [self.mLineupTableView deselectRowAtIndexPath:tableSelection animated:NO];
    self.mLineupTableView.separatorColor = [UIColor clearColor];
    
    
}


-(void)punditsListening{
    self.punditsMessage = nil ;
    self.broadcastersView.hidden = YES ;
    
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
        self.mTeamANameLabel.text = @"-";
        self.mTeamBNameLabel.text = @"-";
        /*
        self.mTeamANameLabel.text = [NSString stringWithFormat:@"%@: %@",channellist.team1_name,channellist.team1_score];
        self.mTeamBNameLabel.text = [NSString stringWithFormat:@"%@: %@",channellist.team2_name,channellist.team2_score];
         */
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
    
    sharingString = [NSString stringWithFormat:@"I'm live on Pundit now, listening to %@ Vs %@, come join me",channellist.team1_name,channellist.team2_name];
    
}
-(void)teamListening{
    self.mTeamTalkLabel.hidden = NO ;
    self.mMatchStatusLabel.hidden = YES ;
    self.mTeamVsTeamLabel.text = [self.teamListenDetails objectForKey:@"contestantName"];
    
    self.mTeamANameLabel.text = [self.teamListenDetails objectForKey:@"contestantClubName"];
    self.mTeamBNameLabel.text = [NSString stringWithFormat:@"Points - %@",[self.teamListenDetails objectForKey:@"points"]];
    self.matchStatus.text = [NSString stringWithFormat:@"Rank - %@",[self.teamListenDetails objectForKey:@"rank"]];

    
    sharingString = [NSString stringWithFormat:@"I'm listening on PUNDIT now %@, come join me",[self.teamListenDetails objectForKey:@"contestantName"]];

}


#pragma Mark ================================================================
#pragma Mark Tabel View Initialization START
#pragma Mark ================================================================


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.mTableView) {
      return 25;
    }
    if (tableView == mLineupTableView) {
        return 50;
    }
    else{
    return 50;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == mLineupTableView) {
        if (mPlayers1Array.count > mPlayers2Array.count) {
            
            return mPlayers1Array.count;
        }
        else{
            return  mPlayers2Array.count;
        }
    }
    else if (tableView == _broadCastersTableView) {
        
        return DM.liveBroadcastersArray.count;

    }
    
    else {
        return mFinalOverviewArray.count;
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
        dict = [mFinalOverviewArray objectAtIndex:indexPath.row];
        
        NSLog(@"%@",dict);
        
        
        if ([[dict objectForKey:@"Type"]isEqualToString:@"Goals"]) {
            NSString *string =[NSString stringWithFormat:@"%@",[dict objectForKey:@"goal"]];
            cell.textlbl.text = string;
            cell.image.image = [UIImage imageNamed:@"g"];
        }
        else{
            NSString *string1 =[NSString stringWithFormat:@"%@:%@:%@",[dict objectForKey:@"name"],[[dict objectForKey:@"substitution"]objectForKey:@"replacedBy"],[[dict objectForKey:@"substitution"]objectForKey:@"minute"]];
            cell.textlbl.text = string1;
            cell.image.image = [UIImage imageNamed:@"sub"];
        }
        
        
        /*
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
         
         */
        UIView *bgColorView = [[UIView alloc] init];
        [bgColorView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3]];
        [cell setSelectedBackgroundView:bgColorView];
        
        
        
    return cell;
    }
    else if (tableView == mLineupTableView) {
        
        static NSString *CellIdentifier = @"lineupCell";
        LineupCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        // Configure the cell...
        if (cell == nil) {
            cell = [[LineupCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            
        }
        
        UIView *bgColorView = [[UIView alloc] init];
        [bgColorView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3]];
        
        [cell setSelectedBackgroundView:bgColorView];
        
        NSMutableDictionary *Player_1_Dict = [[NSMutableDictionary alloc]init];
        
        
        if (!([mPlayers1Array count] <= indexPath.row)){
            Player_1_Dict = [mPlayers1Array objectAtIndex:indexPath.row];
            
#pragma Mark ================================================================
#pragma Mark Player 1
#pragma Mark ================================================================
            
            cell.mPlayer1shirtImage.hidden = false;
            
            if ([Player_1_Dict objectForKey:@"shirtNo"]){
                cell.mPlayer1shirtNo.text = [NSString stringWithFormat:@"%@",[Player_1_Dict objectForKey:@"shirtNo"]];
                
            }
            else{
                cell.mPlayer1shirtNo.text = @"";
                
            }
            
            cell.mPlayer1name.text = [NSString stringWithFormat:@"%@",[Player_1_Dict objectForKey:@"name"]];
            
            if ([Player_1_Dict objectForKey:@"Type"]) {
                cell.mPlayer1substitutionImage.hidden = false;
                
                cell.mPlayer1replacedBy.text = [NSString stringWithFormat:@"%@ %@",[[Player_1_Dict objectForKey:@"substitution"]objectForKey:@"replacedBy"],[[Player_1_Dict objectForKey:@"substitution"]objectForKey:@"minute"]];
            }
            
            else{
                cell.mPlayer1substitutionImage.hidden = true;
                cell.mPlayer1replacedBy.text = @"";
                
            }
            cell.mPlayer1minute.text = @"";
        }
        else{
            cell.mPlayer1shirtNo.text = @"";
            cell.mPlayer1name.text = @"";
            cell.mPlayer1substitutionImage.hidden = true;
            cell.mPlayer1shirtImage.hidden = true;
            cell.mPlayer1replacedBy.text = @"";
            cell.mPlayer1minute.text = @"";
            
            
        }
        
        NSMutableDictionary *Player_2_Dict = [[NSMutableDictionary alloc]init];
        
        NSLog(@"%@",mPlayers2Array.count);
        NSLog(@"%@",indexPath.row);
        
        if (!(mPlayers2Array.count <= indexPath.row) ){
            Player_2_Dict = [mPlayers2Array objectAtIndex:indexPath.row];
#pragma Mark ================================================================
#pragma Mark Player 2
#pragma Mark ================================================================
            cell.mPlayer2shirtImage.hidden = false;
            
            if ([Player_2_Dict objectForKey:@"shirtNo"]){
                cell.mPlayer2shirtNo.text = [NSString stringWithFormat:@"%@",[Player_2_Dict objectForKey:@"shirtNo"]];
                
            }
            else{
                cell.mPlayer2shirtNo.text = @"";
                
            }
            
            cell.mPlayer2name.text = [NSString stringWithFormat:@"%@",[Player_2_Dict objectForKey:@"name"]];
            
            if ([Player_2_Dict objectForKey:@"Type"]) {
                cell.mPlayer2substitutionImage.hidden = false;
                
                cell.mPlayer2replacedBy.text = [NSString stringWithFormat:@"%@ %@",[[Player_2_Dict objectForKey:@"substitution"]objectForKey:@"replacedBy"],[[Player_2_Dict objectForKey:@"substitution"]objectForKey:@"minute"]];
            }
            
            else{
                cell.mPlayer2substitutionImage.hidden = true;
                cell.mPlayer2replacedBy.text = @"";
                
                
            }
            cell.mPlayer2minute.text = @"";
        }
        else{
            cell.mPlayer2shirtNo.text = @"";
            cell.mPlayer2name.text = @"";
            cell.mPlayer2substitutionImage.hidden = true;
            cell.mPlayer2shirtImage.hidden = true;
            cell.mPlayer2replacedBy.text = @"";
            cell.mPlayer2minute.text = @"";
            
        }
        
        

        
        
        
        
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
        
        NSNumber *mChannelKey = [NSNumber numberWithInteger:[self.ChatChannelid integerValue]];
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
        [self StartListing];
    }else{
        [self StartListing];
        
        //manoj changes
     //   [self GetMatchLiveFeed];
        functionTimer = [NSTimer scheduledTimerWithTimeInterval:10.0 target: self
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
        
        //NSString *NewStreamName = [NSString stringWithFormat:@"%@-%@",[[postingData objectForKey:@"data"]objectForKey:@"broadcaster_name"],[Helper base64EncodedString:[[postingData objectForKey:@"data"]objectForKey:@"broadcaster_id"]]];
        NSString *NewStreamName = [NSString stringWithFormat:@"%@-%@",[postingData objectForKey:@"broadcaster_name"],[Helper base64EncodedString:[postingData objectForKey:@"broadcaster_id"]]];

        
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
        
        
      //  NSString *NewStreamName = [NSString stringWithFormat:@"%@-%@",[[postingData objectForKey:@"data"]objectForKey:@"broadcaster_name"],[Helper base64EncodedString:[[postingData objectForKey:@"data"]objectForKey:@"broadcaster_id"]]];
        NSString *NewStreamName = [NSString stringWithFormat:@"%@-%@",[postingData objectForKey:@"broadcaster_name"],[Helper base64EncodedString:[postingData objectForKey:@"broadcaster_id"]]];

        
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
    
    
    NSLog(@"ListenTimer===========================%@===================================",timeNow);
    
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

- (void)start:(NSString *)ServerIP {
    [Helper showLoaderVProgressHUD];
    
    R5Connection *connection;
    if ([_mLowSignalModeSwitch isOn]) {
     connection  = [[R5Connection new] initWithConfig:[DM getConfig:ServerIP bufferTime:@"Yes"]];
    }else{
     connection  = [[R5Connection new] initWithConfig:[DM getConfig:ServerIP bufferTime:nil]];
    }
    
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
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        self.mKickOFTimeLabel.timerType = MZTimerLabelTypeStopWatch;
        [self.mKickOFTimeLabel start];
    }];
    
   // [self StartTimer];
    
    
    
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
//    [self stop];
//    [[NSNotificationCenter defaultCenter] removeObserver:self];

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
    NSString *URlStr = [NSString stringWithFormat:@"https://www.footballwebpages.co.uk/match.json?match=%@",channellist.match_id];
    NSLog(@"My Service Request  = %@", URlStr);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URlStr]cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:120.0];
    [request setHTTPMethod:@"GET"];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData* data, NSURLResponse* response, NSError *error) {
                                                    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                                                    if(httpResponse.statusCode == 200){
                                                        NSString *responsestrobj = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
                                                        NSLog(@"The Response is  = %@", responsestrobj);
                                                        NSError *errorJson;
                                                        
                                                        NSDictionary *responseDict =[NSJSONSerialization JSONObjectWithData:[responsestrobj dataUsingEncoding:NSUTF8StringEncoding]
                                                                                                                    options:NSJSONReadingMutableContainers
                                                                                                                      error:&errorJson];
                                                        
                                                        //  NSLog(@"The Response is  = %@", responseDict);
                                                        
                                                        
                                                        
                                                        if ([responseDict objectForKey:@"match"]) {
                                                            
                                                            
                                                            
                                                            
                                                            if ([[responseDict objectForKey:@"match"]objectForKey:@"teams"]) {
                                                                
                                                                
                                                                if ([[[[responseDict objectForKey:@"match"]objectForKey:@"teams"] objectAtIndex:0]objectForKey:@"players"]) {
                                                                    
                                                                    [mPlayers1Array removeAllObjects];
                                                                    
                                                                    [mPlayers1Array addObjectsFromArray:[[[[responseDict objectForKey:@"match"]objectForKey:@"teams"] objectAtIndex:0]objectForKey:@"players"]];
                                                                    
                                                                }
                                                                if ([[[[responseDict objectForKey:@"match"]objectForKey:@"teams"] objectAtIndex:1]objectForKey:@"players"]) {
                                                                    
                                                                    [mPlayers2Array removeAllObjects];
                                                                    
                                                                    [mPlayers2Array addObjectsFromArray:[[[[responseDict objectForKey:@"match"]objectForKey:@"teams"] objectAtIndex:1]objectForKey:@"players"]];
                                                                }
                                                                
                                                                if ([[[[responseDict objectForKey:@"match"]objectForKey:@"teams"] objectAtIndex:0]objectForKey:@"goals"]) {
                                                                    [mGoals1Array removeAllObjects];
                                                                    
                                                                    [mGoals1Array addObjectsFromArray:[[[[responseDict objectForKey:@"match"]objectForKey:@"teams"] objectAtIndex:0]objectForKey:@"goals"]];
                                                                }
                                                                
                                                                if ([[[[responseDict objectForKey:@"match"]objectForKey:@"teams"] objectAtIndex:1]objectForKey:@"goals"]) {
                                                                    [mGoals2Array removeAllObjects];
                                                                    
                                                                    [mGoals2Array addObjectsFromArray:[[[[responseDict objectForKey:@"match"]objectForKey:@"teams"] objectAtIndex:1]objectForKey:@"goals"]];
                                                                }
                                                                
                                                                
                                                                [msubstitution1Array removeAllObjects];
                                                                [msubstitution2Array removeAllObjects];
                                                                
                                                                for (NSDictionary *dct in mPlayers1Array ) {
                                                                    
                                                                    if ([dct valueForKey:@"substitution"]) {
                                                                        
                                                                        [msubstitution1Array addObject:dct];
                                                                        
                                                                    }
                                                                    
                                                                }
                                                                for (NSDictionary *dct in mPlayers2Array ) {
                                                                    
                                                                    if ([dct valueForKey:@"substitution"]) {
                                                                        [msubstitution2Array addObject:dct];
                                                                        
                                                                    }
                                                                    
                                                                }
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                NSMutableSet *set = [NSMutableSet setWithArray:mGoals1Array];
                                                                [set addObjectsFromArray:mGoals2Array];
                                                                
                                                                NSArray *teamArray = [set allObjects];
                                                                
                                                                [mFinalGoalsArray removeAllObjects];
                                                                
                                                                for (NSMutableDictionary *dct in teamArray ) {
                                                                    [dct
                                                                     setObject:@"Goals" forKey:@"Type"];
                                                                    [mFinalGoalsArray addObject:dct];
                                                                }
                                                                
                                                                
                                                                
                                                                NSMutableSet *set1 = [NSMutableSet setWithArray:msubstitution1Array];
                                                                [set1 addObjectsFromArray:msubstitution2Array];
                                                                
                                                                NSArray *teamArray1 = [set1 allObjects];
                                                                
                                                                [mFinalsubstitutionArray removeAllObjects];
                                                                
                                                                for (NSMutableDictionary *dct in teamArray1 ) {
                                                                    [dct
                                                                     setObject:@"Substitute" forKey:@"Type"];
                                                                    [mFinalsubstitutionArray addObject:dct];
                                                                }
                                                                
                                                                
                                                                
                                                                //    NSLog(@"The mFinalsubstitutionArray is  = %@", mFinalsubstitutionArray);
                                                                
                                                                
                                                                
                                                                NSMutableSet *set2 = [NSMutableSet setWithArray:mFinalGoalsArray];
                                                                [set2 addObjectsFromArray:mFinalsubstitutionArray];
                                                                NSArray *OverviewArray = [set2 allObjects];
                                                                
                                                                NSSortDescriptor *sortDescriptor;
                                                                sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"Type"
                                                                                                             ascending:YES];
                                                                mFinalOverviewArray = [OverviewArray sortedArrayUsingDescriptors:@[sortDescriptor]];
                                                                
                                                                
                                                                
                                                                //    NSLog(@"The mFinalOverviewArray is  = %@", mFinalOverviewArray);
                                                                
                                                                
                                                                
                                                                //   NSLog(@"The mPlayers1Array is  = %@", mPlayers1Array);
                                                                //   NSLog(@"The mPlayers2Array is  = %@", mPlayers2Array);
                                                                
                                                                //    NSLog(@"The mGoals1Array is  = %@", mGoals1Array);
                                                                //   NSLog(@"The mGoals2Array is  = %@", mGoals2Array);
                                                                
                                                                //   NSLog(@"The mGoals1Array is  = %@", msubstitution1Array);
                                                                //   NSLog(@"The mGoals2Array is  = %@", msubstitution2Array);
                                                                
                                                            }
                                                            
                                                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                                                
                               
                                                                NSString *string = [NSString stringWithFormat:@"%@",[[responseDict objectForKey:@"match"]objectForKey:@"status"]];
                                                                if (([string containsString:@"First Half"] != 0)||([string containsString:@"Second Half"] != 0)) {
                                                                    
                                                                    self.mMatchStatusLabel.text = [NSString stringWithFormat:@"Playing"];
                                                                }else if ([string isEqualToString:@"Full Time"]){
                                                                    self.mMatchStatusLabel.text = [NSString stringWithFormat:@"FT"];
                                                                }else if([string containsString:@"Kick off"] != 0){
                                                                    self.mMatchStatusLabel.text = [NSString stringWithFormat:@"Fixture"];
                                                                }else{
                                                                    self.mMatchStatusLabel.text = @"-";
                                                                }
                                                                
                                                                
                                                                if ([[responseDict objectForKey:@"match"]objectForKey:@"teams"]) {                                                                                                                                                                                                            self.mTeamANameLabel.text = [NSString stringWithFormat:@"%@: %@",[[[[responseDict objectForKey:@"match"]objectForKey:@"teams"] objectAtIndex:0]objectForKey:@"name"],[[[[responseDict objectForKey:@"match"]objectForKey:@"teams"] objectAtIndex:0]objectForKey:@"score"]];
                                                                    
                                                                }
                                                                if ([[responseDict objectForKey:@"match"]objectForKey:@"teams"]) {                                                                                                                                                                                                            self.mTeamBNameLabel.text = [NSString stringWithFormat:@"%@: %@",[[[[responseDict objectForKey:@"match"]objectForKey:@"teams"] objectAtIndex:1]objectForKey:@"name"],[[[[responseDict objectForKey:@"match"]objectForKey:@"teams"] objectAtIndex:1]objectForKey:@"score"]];
                                                                }
                                                                
                                                                
                                                                
                                                                [self.mTableView reloadData];
                                                                [self.mLineupTableView reloadData];
                                                            }];
                                                            
                                                        }
                                                        
                                                    }
                                                    else{
                                                        NSLog(@"The Response is  = %@", error.localizedDescription);
                                                        
                                                    }
                                                    
                                                    
                                                    
                                                    
                                                    
                                                    
                                                }];
    [dataTask resume];
    
    
    
}
- (void)GetMatchLiveFeedOld{
    
    
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
       // [checkAlert show];
        [self.mKickOFTimeLabel pause];
        [DM.stream stop];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Pundit"
                                                        message:@"Broadcaster Left"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
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
            [self stop];
            [[NSNotificationCenter defaultCenter] removeObserver:self];
            
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
    
    //NSString *NewStreamName = [NSString stringWithFormat:@"%@-%@",[[postingData objectForKey:@"data"]objectForKey:@"broadcaster_name"],[Helper base64EncodedString:[[postingData objectForKey:@"data"]objectForKey:@"broadcaster_id"]]];
    
    NSString *NewStreamName = [NSString stringWithFormat:@"%@-%@",[postingData objectForKey:@"broadcaster_name"],[Helper base64EncodedString:[postingData objectForKey:@"broadcaster_id"]]];
    
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
    
    if (!([self.ChatChannelid intValue] == 0)) {
            ALChatManager *manager = [[ALChatManager alloc] initWithApplicationKey:APPLICATION_ID]; // SET APPLICATION ID
            [manager launchGroupWithClientId:self.ChatChannelid withMetaData:nil andWithUser:[ALUserDefaultsHandler getUserId] andFromViewController:self];

        
    }
        
        return;

//    ALChatManager *manager = [[ALChatManager alloc] initWithApplicationKey:APPLICATION_ID]; // SET APPLICATION ID
//    [manager launchChatForUserWithDisplayName:self.CurrentALUser.userId withGroupId:[NSNumber numberWithInteger:[[postingData valueForKey:@"chatChannelid"] integerValue]] andwithDisplayName:self.CurrentALUser.displayName andFromViewController:self];
//
//    return;

   

    if (!([self.ChatChannelid integerValue] == 0)) {
        
        if (ChatViewCheckBool == FALSE) {
           // NSNumber *numberobj = [NSNumber numberWithInteger:[[postingData valueForKey:@"chatChannelid"] integerValue]];
             NSNumber *numberobj = [NSNumber numberWithInteger:[self.ChatChannelid integerValue]];
            
            
            
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
    ChatViewCheckBool = false;
    ChatController.view.hidden = YES;
    [self keyborddown];
}


-(void)keyborddown{
    
    [self.view endEditing:YES];
}

-(void)ListnersStartTimer
{
    listnersCount = [NSTimer scheduledTimerWithTimeInterval:1.0 target: self
                                                   selector: @selector(ListnersCountMethood) userInfo: nil repeats: YES];
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerTick:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}

-(void)ListnersCountMethood{
    
    NSString *path = [NSString stringWithFormat:@"%@Game/ChannelListener_count/%@",KServiceBaseURL,[postingData objectForKey:@"id"]];
    [DM GetRequest:path parameter:nil onCompletion:^(id  _Nullable dict) {
        
        NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
        NSLog(@"%@",responseDict);
        
        self.mListenersCountLabel.text = [NSString stringWithFormat:@"%@",[responseDict objectForKey:@"count"]];
        
    } onError:^(NSError * _Nullable Error) {
        
    }];
}

- (IBAction)LowSignalModeAction:(id)sender {
    
    UISwitch *mySwitch = (UISwitch *)sender;
    if ([mySwitch isOn]) {
        NSLog(@"its on!");
    } else {
        NSLog(@"its off!");
    }

    if (_broadcastersView.hidden == YES) {
        [Helper showLoaderVProgressHUD];
        [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(ButtonPressed) userInfo:nil repeats:NO];
        [self stop];
    }
}

-(void)ButtonPressed{
       [self StartListing];
       [Helper hideLoaderSVProgressHUD];
}

- (IBAction)RefreshListenerButtonTap:(id)sender{
   // [Helper showLoaderVProgressHUD];
    [self RefreshListening];
}


#pragma Mark ================================================================
#pragma Mark RefreshListening
#pragma Mark ================================================================

-(void)RefreshListening{
    NSString * path = [NSString stringWithFormat:@"%@Game/refreshListening/%@/%@",KServiceBaseURL,[postingData objectForKey:@"broadcaster_id"],[postingData objectForKey:@"id"]];
    NSLog(@"path %@",path);

    [DM GetRequest:path parameter:nil onCompletion:^(id  _Nullable dict) {
        
        NSError *errorJson=nil;
        NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:&errorJson];
        NSLog(@"responseDict %@",responseDict);
        postingData = [[NSMutableDictionary alloc]init];
        postingData = [responseDict objectForKey:@"channel"];
        [self post];
        [Helper hideLoaderSVProgressHUD];
    } onError:^(NSError * _Nullable Error) {
        NSLog(@"Error %@",Error);
    }];
    
}


-(void)StartListing{
    
    
    NSString * Newpath = [NSString stringWithFormat:@"http://54.76.147.237:5080/streammanager/api/2.0/admin/nodegroup?accessToken=pest8Mmyriad"];
    
    NSMutableURLRequest *Newrequest = [[NSMutableURLRequest alloc] init];
    [Newrequest setURL:[NSURL URLWithString:Newpath]];
    [Newrequest setHTTPMethod:@"GET"];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:Newrequest completionHandler:^(NSData* data, NSURLResponse* response, NSError *error) {
        
        NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
        
        NSError *errorJson;
        
        
        NSArray *NewresponseDict =[NSJSONSerialization JSONObjectWithData:[requestReply dataUsingEncoding:NSUTF8StringEncoding]
                                                                  options:NSJSONReadingMutableContainers
                                                                    error:&errorJson];
        
        NSMutableDictionary *Newdict = NewresponseDict[0];
        
        NSString *GroupID =  [Newdict objectForKey:@"name"];
        NSLog(@": %@", GroupID);
        
        
        
        NSString * path = [NSString stringWithFormat:@"http://54.76.147.237:5080/streammanager/api/2.0/admin/nodegroup/%@/node/edge?accessToken=pest8Mmyriad",GroupID];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:path]];
        [request setHTTPMethod:@"GET"];
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        [[session dataTaskWithRequest:request completionHandler:^(NSData* data, NSURLResponse* response, NSError *error) {
            
            NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
            
            NSError *errorJson;
            
            NSArray *responseDict =[NSJSONSerialization JSONObjectWithData:[requestReply dataUsingEncoding:NSUTF8StringEncoding]
                                                                   options:NSJSONReadingMutableContainers
                                                                     error:&errorJson];
            
            NSMutableDictionary *dict = responseDict[0];
            
            NSString *ServerIP =  [dict objectForKey:@"address"];
            NSLog(@": %@", ServerIP);
            
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self start:ServerIP];
                
            }];
            
            NSLog(@"Request reply: %@", requestReply);
            
            
        }] resume];
        
        
        
        
        
    }] resume];
    
    
    
    
    
    
    
}

- (IBAction)OverviewButtonTap:(id)sender{
    
    self.mTableView.hidden = false;
    self.mLineupTableView.hidden = true;
    [self.mOverviewButton setImage:[UIImage imageNamed:@"OverviewButtonSelected"] forState:UIControlStateNormal];
    [self.mLineupButton setImage:[UIImage imageNamed:@"LineupButton"] forState:UIControlStateNormal];
    
    [self.mTableView reloadData];
    
    
}
- (IBAction)LineupButtonTap:(id)sender{
    
    self.mTableView.hidden = true;
    self.mLineupTableView.hidden = false;
    [self.mOverviewButton setImage:[UIImage imageNamed:@"OverviewButton"] forState:UIControlStateNormal];
    [self.mLineupButton setImage:[UIImage imageNamed:@"LineupButtonSelected"] forState:UIControlStateNormal];
    
    [self.mLineupTableView reloadData];
    
    
    
}

@end
