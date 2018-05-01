//
//  BroadcastMatchVC.m
//  IPundit
//
//  Created by Deepak Kumar on 03/03/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//




#import "ListenMatchVC.h"
#import "ListenMatchCell.h"
#import "ListenMatchDetailVC.h"
#import "Constants.h"
#import "Helper.h"
#import "ChannelListModel.h"
#import "UIImageView+WebCache.h"
#import "VideoHighlightsVC.h"
#import "OtherStationVC.h"

@interface ListenMatchVC ()<UIGestureRecognizerDelegate>{
    
    NSArray *TitalArray;
    NSMutableArray * mDataArray_Ref ;
    NSMutableDictionary *mMatches_Dict;
    NSData *tempDate;

    NSDate *todayDate;
    NSDate *minDate;
    NSDate *maxDate;
    
    NSDate *dateSelected;
    UIDatePicker *datePicker;
    NSString *broadcaster_team_count ;
    NSString *ChatChannelId;
    NSString *ChannelNameObj;



}

@end

@implementation ListenMatchVC

@synthesize mMatchArray,mMatchTableView,channellistmodel,leaquesmodel;



- (void)viewDidLoad {
    [super viewDidLoad];
    self.CurrentALUser = [ALChatManager getLoggedinUserInformation];

    
    self.backgroundImageView.image = DM.backgroundImage ;
    if(IS_IPHONE4){
        
        self.view.frame = CGRectMake(0, 0, 320, 480);
        self.mMatchTableView.frame = CGRectMake(8, 117, 294, 195);
        self.matchView.frame = CGRectMake(5, 86, 310, 320);
        self.teamTable.frame = CGRectMake(16, 415, 288, 40);
        self.breakingNewsView.frame = CGRectMake(0, 462, 320, 18);
        self.mNoBroadCastersAvilable.frame = CGRectMake(18, 162, 275, 44);
    
    }
    channellistmodel = [[ChannelListModel alloc] init];
    
    self.broadcasterCountImageView.hidden = YES ;
    self.broadcasterCountLabel.hidden = YES ;
    self.mNoBroadCastersAvilable.hidden = NO;
    self.calendarMa = [JTCalendarManager new];
    self.calendarMa.delegate = self;
    [self createMinAndMaxDate];
    
    NSString * iconString = [NSString stringWithFormat:@"%@league_mark/%@",KserviceBaseIconURL,[DM.listenerPresentData objectForKey:@"icon"]];
    NSURL *iconUrl = [NSURL URLWithString:[DM.listenerPresentData objectForKey:@"icon"]];
    [self.mLeaqueIcon sd_setImageWithURL:iconUrl placeholderImage:[UIImage imageNamed:@"LeaguesIconDummy"]];
    NSString * string = [NSString stringWithFormat:@"%@",[DM.listenerPresentData objectForKey:@"leaqueName"]];
    self.mLeaqueName.text = string;
       self.calendarMa.settings.weekModeEnabled = !self.calendarMa.settings.weekModeEnabled;
    [self.calendarMa reload];
   
    datePicker=[[UIDatePicker alloc]init];
    datePicker.datePickerMode=UIDatePickerModeDate;
    [self.dateSelectionTextField setInputView:datePicker];
    UIToolbar *toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [toolBar setTintColor:[UIColor grayColor]];
    UIBarButtonItem *doneBtn=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(ShowSelectedDate)];
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolBar setItems:[NSArray arrayWithObjects:space,doneBtn, nil]];
    [self.dateSelectionTextField setInputAccessoryView:toolBar];
    
    [self GetLeaguenewsList:leaquesmodel.id datestring:[Helper Leaque_date_String]];
    //[Helper Leaque_date_String]
}

-(void)GetLeaguenewsList :(NSString *)leaqueID datestring:(NSString *)DateString{
    
    [Helper showLoaderVProgressHUD];
    
    
    NSString *string = [NSString stringWithFormat:@"%@game/getLeaguenewsList/%@/%@/",KServiceBaseURL,leaqueID,DateString];
    [DM GetRequest:string parameter:nil onCompletion:^(id  _Nullable dict) {
        
        NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
        NSLog(@"ResponseDict %@",responseDict);
        
        NSMutableArray *breakingNews =[[NSMutableArray alloc]init];
        NSMutableArray *breakingNewsText =[[NSMutableArray alloc]init];
        
        if ([responseDict objectForKey:@"news"]) {
            [breakingNews removeAllObjects];
            [breakingNews addObjectsFromArray:[responseDict objectForKey:@"news"]];
            if (breakingNews.count > 0) {
                
                for (int i = 0; i < breakingNews.count; i++) {
                    [breakingNewsText addObject:[[breakingNews objectAtIndex:i]objectForKey:@"title"]];
                }
                NSString *stringobj = [breakingNewsText componentsJoinedByString:@" || "];
                NSLog(@"ResponseDict %@",stringobj);
                
                DM.LequebreakingNewsString  = [breakingNewsText componentsJoinedByString:@" || "];
                
                self.mNewsLabel.text = stringobj ;
                [DM marqueLabel:self.mNewsLabel];
                
                
            }
            else{
                
                self.mNewsLabel.text = @"No News Avalable" ;
                [DM marqueLabel:self.mNewsLabel];
                
                DM.LequebreakingNewsString  = [breakingNewsText componentsJoinedByString:@" || "];
                
            }
        }
        
        
        [Helper hideLoaderSVProgressHUD];
        
        
    } onError:^(NSError * _Nullable Error) {
        [Helper hideLoaderSVProgressHUD];
        NSLog(@"%@",Error);
        NSString *ErrorString = [NSString stringWithFormat:@"%@",Error];
        [Helper ISAlertTypeError:ErrorString andMessage:kNOInternet];
    }];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
//    self.mNewsLabel.text = DM.breakingNewsString ;
//    [DM marqueLabel:self.mNewsLabel];
    
    [self.calendarMa setContentView:self.calenderManager];
    [self.calendarMa setDate:todayDate];
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MMM YYYY"];
    self.dateSelectionTextField.text=[NSString stringWithFormat:@"%@",[formatter stringFromDate:todayDate]];
    NSDateFormatter *dateformate=[[NSDateFormatter alloc]init];
    [dateformate setDateFormat:@"yyyy-MM-dd"];
    NSString *date_String =[dateformate stringFromDate:todayDate];
    [self GetMatchList:date_String];
    
    
    NSIndexPath *tableSelection = [self.mMatchTableView indexPathForSelectedRow];
    [self.mMatchTableView deselectRowAtIndexPath:tableSelection animated:NO];
    self.mMatchTableView.separatorColor = [UIColor clearColor];
    
}

//-(void)viewDidAppear:(BOOL)animated{
//    [self viewWillAppear:YES];
//}

-(void)ShowSelectedDate
{
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MMM YYYY"];
    self.dateSelectionTextField.text=[NSString stringWithFormat:@"%@",[formatter stringFromDate:datePicker.date]];
    
    NSDateFormatter *dateformate=[[NSDateFormatter alloc]init];
    [dateformate setDateFormat:@"yyyy-MM-dd"];
    NSString *date_String =[dateformate stringFromDate:datePicker.date];
    [self GetMatchList:date_String];
    [self.calendarMa setDate:datePicker.date];
    [self.dateSelectionTextField resignFirstResponder];

}

- (void)createMinAndMaxDate
{
    todayDate = [NSDate date];
    
    // Min date will be 2 month before today
    minDate = [self.calendarMa.dateHelper addToDate:todayDate months:-10];
    
    // Max date will be 2 month after today
    maxDate = [self.calendarMa.dateHelper addToDate:todayDate months:10];
}




-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return TitalArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[mMatches_Dict objectForKey:[TitalArray objectAtIndex:section]] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *CellIdentifier = @"ListenMatchCell";
    ListenMatchCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
 
    if (cell == nil) {
        cell = [[ListenMatchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    UIView *bgColorView = [[UIView alloc] init];
    [bgColorView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3]];
    [cell setSelectedBackgroundView:bgColorView];
    channellistmodel = [[mMatches_Dict objectForKey:[TitalArray objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    
    NSString *string = [NSString stringWithFormat:@"%@",channellistmodel.match_start_time];

    NSString *team1Score = [NSString stringWithFormat:@"%@",channellistmodel.team1_score];
    NSString *team2Score = [NSString stringWithFormat:@"%@",channellistmodel.team2_score];
    
    if ([team1Score isEqualToString:@"(null)"]) {
        cell.mTeam1Score.text = @"-";
        cell.mTeam2Score.text = @"-";
    }
    else{
        cell.mTeam1Score.text = team1Score;
        cell.mTeam2Score.text = team2Score;
    }
    
    NSString *timeString = [NSString stringWithFormat:@"%@",channellistmodel.matchStatus];
    
    if (([timeString containsString:@"First Half"] != 0)||([string containsString:@"Second Half"] != 0)) {
        
        cell.mTimeLabel.text = [NSString stringWithFormat:@"Playing"];
    }else if ([timeString isEqualToString:@"Full Time"]){
        cell.mTimeLabel.text = [NSString stringWithFormat:@"FT"];
    }else if([timeString containsString:@"Kick off"] != 0){
        cell.mTimeLabel.text = [NSString stringWithFormat:@"Fixture"];
    }else{
        cell.mTimeLabel.text = @"-";
    }
    
    
    
    
   
    NSString *dateString = channellistmodel.match_start_time ;
    NSDateFormatter* dateFormatter1 = [[NSDateFormatter alloc] init];
    dateFormatter1.dateFormat = @"HH:mm:ss";
    NSDate *yourDate = [dateFormatter1 dateFromString:dateString];
    dateFormatter1.dateFormat = @"HH:mm";
    NSLog(@"%@",[dateFormatter1 stringFromDate:yourDate]);
    
    cell.mMatchDisplayTime.text = [dateFormatter1 stringFromDate:yourDate];
    cell.mTeam1Name.text = [NSString stringWithFormat:@"%@",channellistmodel.team1_name];
    cell.mTeam2name.text = [NSString stringWithFormat:@"%@",channellistmodel.team2_name];
   
    
    NSArray *arrayobj = [[mDataArray_Ref objectAtIndex:indexPath.row]objectForKey:@"channel"];
    if (arrayobj.count > 0) {
        cell.mCellBackgroundImage.image = [UIImage imageNamed:@"NewMatch-Lisitng-green.png"];
    }
    else{
        
        cell.mCellBackgroundImage.image = [UIImage imageNamed:@"NewMatch-Lisitng-white.png"];

    }
    /*
     if (arrayobj.count > 0) {
     cell.mCellBackgroundImage.image = [UIImage imageNamed:@"Match-Lisitng-green.png"];
     }
     else{
     
     cell.mCellBackgroundImage.image = [UIImage imageNamed:@"Match-Lisitng.png"];
     
     }
     */
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;{

    [mMatchTableView deselectRowAtIndexPath:indexPath animated:NO];
    DM.channelType = [NSString stringWithFormat:@"match"];
     channellistmodel = [[mMatches_Dict objectForKey:[TitalArray objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    

    self.mliveBroadcastersArray = [[mDataArray_Ref objectAtIndex:indexPath.row]objectForKey:@"channel"];
    
     DM.liveBroadcastersArray = [[mDataArray_Ref objectAtIndex:indexPath.row]objectForKey:@"channel"];
    
    
    
    ChannelNameObj = [NSString stringWithFormat:@"%@ V/s %@",channellistmodel.team1_name,channellistmodel.team2_name];
    
    ChatChannelId = [NSString stringWithFormat:@"%@",channellistmodel.chatChannelid];
    NSLog(@"%@",ChatChannelId);
    
    
    
    if([ChatChannelId intValue] == 0){
        
        [Helper showLoaderVProgressHUD];
        [self createChannel :ChannelNameObj:channellistmodel.match_id];
        
    }else{
        [self performSegueWithIdentifier:@"ListenMatchDetail" sender:self];
    }
    
    
    
  
}



- (void)createChannel:(NSString *)ChannelName :(NSString *)Match_id
{
    
    NSMutableDictionary *grpMetaData = [NSMutableDictionary new];
    
    // [grpMetaData setObject:@":adminName created group" forKey:AL_CREATE_GROUP_MESSAGE];
    [grpMetaData setObject:ChannelName forKey:AL_CREATE_GROUP_MESSAGE];
    [grpMetaData setObject:@":userName removed" forKey:AL_REMOVE_MEMBER_MESSAGE];
    [grpMetaData setObject:@":userName added" forKey:AL_ADD_MEMBER_MESSAGE];
    [grpMetaData setObject:@":userName joined" forKey:AL_JOIN_MEMBER_MESSAGE];
    [grpMetaData setObject:@"Group renamed to :groupName" forKey:AL_GROUP_NAME_CHANGE_MESSAGE];
    [grpMetaData setObject:@":groupName icon changed" forKey:AL_GROUP_ICON_CHANGE_MESSAGE];
    [grpMetaData setObject:@":userName left" forKey:AL_GROUP_LEFT_MESSAGE];
    [grpMetaData setObject:@":groupName deleted" forKey:AL_DELETED_GROUP_MESSAGE];
    [grpMetaData setObject:@(true) forKey:@"HIDE"];
    
    ALChannelService * channelService = [[ALChannelService alloc] init];
    NSMutableArray *arryobj = [[NSMutableArray alloc]initWithObjects:self.CurrentALUser.userId, nil];
    
    [channelService createChannel:ChannelName orClientChannelKey:nil andMembersList:arryobj andImageLink:nil channelType:PUBLIC andMetaData:grpMetaData withCompletion:^(ALChannel *alChannel, NSError *error) {
        if(alChannel){
            NSLog(@"%@",alChannel.key);
            
            [Helper hideLoaderSVProgressHUD];
            
            ChatChannelId = [NSString stringWithFormat:@"%@",alChannel.key];
            
            [self UpdateChatChannelID:Match_id];
        
            [self performSegueWithIdentifier:@"ListenMatchDetail" sender:self];

            
        }
        else{
            [Helper hideLoaderSVProgressHUD];
            
            NSLog(@"%@",error);
            
        }
    }];
}


-(void)UpdateChatChannelID:(NSString *)Matchid{
    
    NSMutableDictionary *ParameterDct =[[NSMutableDictionary alloc]init];
    [ParameterDct setObject:Matchid forKey:@"match_id"];
    [ParameterDct setObject:@"match" forKey:@"channeltype"];
    [ParameterDct setObject:ChatChannelId forKey:@"chatChannelid"];


    
    NSString *string = [NSString stringWithFormat:@"%@app/updateChatId/",KServiceBaseURL];
    [DM PostRequest:string parameter:ParameterDct onCompletion:^(id  _Nullable dict) {
        NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
        NSLog(@"ResponseDict %@",responseDict);
   
    } onError:^(NSError * _Nullable Error) {
        NSLog(@"Following Functionality Error %@",Error);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)BackButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"ListenMatchDetail"]) {

        ListenMatchDetailVC *destinationVC = segue.destinationViewController;
        destinationVC.ChatChannelid = ChatChannelId;
        destinationVC.channellist = channellistmodel;
        destinationVC.self.mrliveBroadcastersArray = _mliveBroadcastersArray;
        

    }
}

-(void)GetMatchList:(NSString*)date
{
    
    [Helper showLoaderVProgressHUD];
    self.mNoBroadCastersAvilable.hidden = YES;
    mMatches_Dict = [[NSMutableDictionary alloc]init];
    self.mMatchArray = [[NSMutableArray alloc]init];
    mDataArray_Ref = [[NSMutableArray alloc]init];
    
   // NSString *path=[NSString stringWithFormat:@"%@Game/getmatchdata/%@/%@/%@",kServiceBaseURL,leaquesmodel.sport_id,leaquesmodel.id,date];
    
   // getmatch
    // get_match_channel_list
    
    NSString *path=[NSString stringWithFormat:@"%@Game/get_match_channel_list/%@/%@/%@",kServiceBaseURL,leaquesmodel.sport_id,leaquesmodel.id,date];
    [DM GetRequest:path parameter:nil onCompletion:^(id dict) {
        NSError *errorJson=nil;
        NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:&errorJson];
        NSLog(@"%@",responseDict);
        
       
        
      //  if (![[responseDict valueForKey:@"data"] isKindOfClass:[NSNull class]]) {
            NSMutableArray *mDataArray  = [[NSMutableArray alloc] init];
            [mDataArray addObjectsFromArray:[responseDict valueForKey:@"data"]];
            [mDataArray_Ref addObjectsFromArray:[responseDict valueForKey:@"data"]];
            broadcaster_team_count = [NSString stringWithFormat:@"%@",[responseDict valueForKey:@"team_broadcaster_count"]];
            NSLog(@"%@",mDataArray);
            
            
            for (NSDictionary *MatchObj in mDataArray)
            {
                NSError *error;
                channellistmodel = [[ChannelListModel alloc] initWithDictionary:MatchObj error:&error];
                [self.mMatchArray addObject:channellistmodel];
            }
            mMatches_Dict = [self groupSessionByDate:self.mMatchArray];
            TitalArray = [[mMatches_Dict allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([broadcaster_team_count isEqualToString:@"0"]) {
                    self.broadcasterCountLabel.hidden = YES ;
                    self.broadcasterCountImageView.hidden = YES ;
                }else{
                    self.broadcasterCountLabel.text = broadcaster_team_count ;
                    self.broadcasterCountLabel.hidden = NO ;
                    self.broadcasterCountImageView.hidden = NO ;
                }
                if (TitalArray.count == 0) {
                    self.mNoBroadCastersAvilable.hidden = NO;
                }
                [self.mMatchTableView reloadData];
                [Helper hideLoaderSVProgressHUD];
                
            });
            
       
        
    } onError:^(NSError *Error) {
        [Helper hideLoaderSVProgressHUD];
        NSLog(@"%@",Error);
        NSString *ErrorString = [NSString stringWithFormat:@"%@",Error];
        [Helper ISAlertTypeError:ErrorString andMessage:kNOInternet];
        
    }];
    
}
-(NSString *)dayFinder:(NSString*)dateString
{
    NSDate *date = [NSDate date];
            
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    date = [formatter dateFromString:dateString];
    NSLog(@"%@", [formatter stringFromDate:date]);
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger units = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit;
    NSDateComponents *components = [calendar components:units fromDate:date];
    NSInteger year = [components year];
    NSInteger day = [components day];
    NSDateFormatter *weekDay = [[NSDateFormatter alloc] init];
    [weekDay setDateFormat:@"EEE"];
    
    NSDateFormatter *calMonth = [[NSDateFormatter alloc] init];
    [calMonth setDateFormat:@"MMMM"];
    NSString * stringToReturn = [NSString stringWithFormat:@"%@ %li %@ %li", [weekDay stringFromDate:date], (long)day, [calMonth stringFromDate:date], (long)year];
    
    return stringToReturn;
}


-(NSMutableDictionary *)groupSessionByDate:(NSArray *)matchArray {
    NSMutableSet *setObj = [[NSMutableSet alloc]init];
    
    for (channellistmodel in matchArray) {
        [setObj addObject:channellistmodel.match_start_date];
    }
    NSMutableDictionary *mMainDaatDict = [[NSMutableDictionary alloc] init];
    for (NSString *DateStr in [setObj allObjects]) {
        NSMutableArray *tempAry = [[NSMutableArray alloc] init];
        for (channellistmodel in matchArray) {
            if ([channellistmodel.match_start_date isEqualToString:DateStr]) {
                [tempAry addObject:channellistmodel];
            }
        }
        [mMainDaatDict setObject:tempAry forKey:DateStr];
    }
    
    NSLog(@"%@",mMainDaatDict);
    
    return mMainDaatDict;
}



#pragma mark - CalendarManager delegate



// Exemple of implementation of prepareDayView method
// Used to customize the appearance of dayView
- (void)calendar:(JTCalendarManager *)calendar prepareDayView:(JTCalendarDayView *)dayView
{
    // Today
    if([self.calendarMa.dateHelper date:[NSDate date] isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor whiteColor];
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor blackColor];
    }
    // Selected date
    else if(dateSelected && [self.calendarMa.dateHelper date:dateSelected isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    // Other month
    else if(![self.calendarMa.dateHelper date:self.calenderManager.date isTheSameMonthThan:dayView.date]){
        dayView.circleView.hidden = YES;
        dayView.dotView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        dayView.textLabel.textColor = [UIColor whiteColor];
        dayView.textLabel.font =[UIFont fontWithName:@"System-Bold" size:10];
        
    }
    // Another day of the current month
    else{
        dayView.circleView.hidden = YES;
        dayView.dotView.backgroundColor = [UIColor redColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
        
    }
    
    }

- (void)calendar:(JTCalendarManager *)calendar didTouchDayView:(JTCalendarDayView *)dayView
{
    dateSelected = dayView.date;
    NSDateFormatter *formatter1=[[NSDateFormatter alloc]init];
    [formatter1 setDateFormat:@"MMM YYYY"];
    self.dateSelectionTextField.text=[NSString stringWithFormat:@"%@",[formatter1 stringFromDate:dateSelected]];
    
    dateSelected = dayView.date;
    NSDateFormatter *dateformate=[[NSDateFormatter alloc]init];
    [dateformate setDateFormat:@"yyyy-MM-dd"];
    NSString *date_String =[dateformate stringFromDate:dateSelected];
    channellistmodel = [[ChannelListModel alloc] init];
    mMatchArray  = [[NSMutableArray alloc]init];
    [self GetMatchList:date_String];
    
   // date = dayView.date;
    
    // Animation for the circleView
    dayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
    [UIView transitionWithView:dayView
                      duration:.3
                       options:0
                    animations:^{
                        dayView.circleView.transform = CGAffineTransformIdentity;
                        [self.calendarMa reload];
                    } completion:nil];
    
    
    // Don't change page in week mode because block the selection of days in first and last weeks of the month
    if(self.calendarMa.settings.weekModeEnabled){
        return;
    }
    
    // Load the previous or next page if touch a day from another month
    
    if(![self.calendarMa.dateHelper date:self.calenderManager.date isTheSameMonthThan:dayView.date]){
        if([self.calenderManager.date compare:dayView.date] == NSOrderedAscending){
            [self.calenderManager loadNextPageWithAnimation];
        }
        else{
            [self.calenderManager loadPreviousPageWithAnimation];
        }
    }
}

#pragma mark - CalendarManager delegate - Page mangement

// Used to limit the date for the calendar, optional
- (BOOL)calendar:(JTCalendarManager *)calendar canDisplayPageWithDate:(NSDate *)date
{
    return [self.calendarMa.dateHelper date:date isEqualOrAfter:minDate andEqualOrBefore:maxDate];
}

- (void)calendarDidLoadNextPage:(JTCalendarManager *)calendar
{
    //    NSLog(@"Next page loaded");
}

- (void)calendarDidLoadPreviousPage:(JTCalendarManager *)calendar
{
    //    NSLog(@"Previous page loaded");
}



- (IBAction)todayButtonTap:(id)sender {
    [self.calendarMa setDate:todayDate];
    NSDateFormatter *dateformate=[[NSDateFormatter alloc]init];
    NSString *date_String =[dateformate stringFromDate:todayDate];
    [self GetMatchList:date_String];
}



- (IBAction)VideoHighlightsPressedButtonAction:(id)sender{
    
    VideoHighlightsVC *VideoHighlightsPressedUp = [self.storyboard instantiateViewControllerWithIdentifier:@"VideoHighlightsView"];
    
    VideoHighlightsPressedUp.leaqueID = leaquesmodel.id;
    
    
    [self.navigationController pushViewController:VideoHighlightsPressedUp animated:YES];
    
}


- (IBAction)OtherLeagueStationPressedButtonAction:(id)sender{
    
    OtherStationVC *OtherStationView = [self.storyboard instantiateViewControllerWithIdentifier:@"otherstationview"];
    
    OtherStationView.leaqueID = leaquesmodel.id;
    
    
    [self.navigationController pushViewController:OtherStationView animated:YES];
    
}




@end
