//
//  BroadcastMatchVC.m
//  IPundit
//
//  Created by Deepak Kumar on 03/03/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import "BroadcastMatchVC.h"
#import "BroadcastMatchCell.h"
#import "UIImage+Additions.h"
#import "BroadcastMatchDetailVC.h"
#import "UIImageView+WebCache.h"
#import "VideoHighlightsVC.h"

#import "SCSiriWaveformView.h"
#import <AVFoundation/AVFoundation.h>

typedef NS_ENUM(NSUInteger, SCSiriWaveformViewInputType) {
    SCSiriWaveformViewInputTypeRecorder,
    SCSiriWaveformViewInputTypePlayer
};

@interface BroadcastMatchVC (){
    NSArray *TitalArray;
    NSMutableDictionary *mMatches_Dict;
    NSData *tempDate;
    
    NSDate *todayDate;
    NSDate *minDate;
    NSDate *maxDate;
    
    NSDate *dateSelected;
    UIDatePicker *datePicker;
    NSString *ChannelNameObj;
    NSString *ChatChannelId;

}

@property (nonatomic, strong) AVAudioRecorder *recorder;
@property (nonatomic, strong) AVAudioPlayer *player;
@property (nonatomic, weak) IBOutlet SCSiriWaveformView *waveformView;
@property (nonatomic, assign) SCSiriWaveformViewInputType selectedInputType;

@end

@implementation BroadcastMatchVC
@synthesize mMatchArray,mMatchTableView,matchlistmodel,leaquesmodel,refreshControl;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self waveintial];

    self.backgroundImageView.image = DM.backgroundImage ;
    
    self.CurrentALUser = [ALChatManager getLoggedinUserInformation];

    if(IS_IPHONE4){
        
        self.view.frame = CGRectMake(0, 0, 320, 480);
        self.mMatchTableView.frame = CGRectMake(8, 117, 294, 195);
        self.matchView.frame = CGRectMake(5, 86, 310, 320);
        self.teamTable.frame = CGRectMake(16, 415, 288, 40);
        self.breakingNewsView.frame = CGRectMake(0, 462, 320, 18);
        self.noBroadCastersLabel.frame = CGRectMake(18, 162, 275, 44);

    }

    matchlistmodel = [[MatchListModel alloc] init];
    mMatchArray  = [[NSMutableArray alloc]init];
    self.calendarMa = [JTCalendarManager new];
    self.calendarMa.delegate = self;
    [self createMinAndMaxDate];
    self.noBroadCastersLabel.hidden = YES;
   
    [self.calendarMa setContentView:self.calenderManager];
    [self.calendarMa setDate:todayDate];
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MMM YYYY"];
    self.dateSelectionTextField.text=[NSString stringWithFormat:@"%@",[formatter stringFromDate:todayDate]];
    
    self.calendarMa.settings.weekModeEnabled = !self.calendarMa.settings.weekModeEnabled;
    [self.calendarMa reload];
    
   // self.breakingNewsLabel.text = DM.breakingNewsString ;
   // [DM marqueLabel:self.breakingNewsLabel];
   
    NSString * iconString = [NSString stringWithFormat:@"%@ios_league_mark/%@",KserviceBaseIconURL,[DM.broadCastPresentData objectForKey:@"icon"]];
    NSURL *iconUrl = [NSURL URLWithString:[DM.broadCastPresentData objectForKey:@"icon"]];
    [self.leaqueImageIcon sd_setImageWithURL:iconUrl placeholderImage:[UIImage imageNamed:@"LeaguesIconDummy.png"]];

    self.leaquenameLabel.text = [NSString stringWithFormat:@"%@",[DM.broadCastPresentData objectForKey:@"leaqueName"]];
    
    NSDateFormatter *dateformate=[[NSDateFormatter alloc]init];
    [dateformate setDateFormat:@"yyyy-MM-dd"];
    NSString *date_String =[dateformate stringFromDate:todayDate];
    [self GetMatchList:date_String];
    
    
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


-(void)waveintial{
    NSDictionary *settings = @{AVSampleRateKey:          [NSNumber numberWithFloat: 44100.0],
                               AVFormatIDKey:            [NSNumber numberWithInt: kAudioFormatAppleLossless],
                               AVNumberOfChannelsKey:    [NSNumber numberWithInt: 2],
                               AVEncoderAudioQualityKey: [NSNumber numberWithInt: AVAudioQualityMin]};
    
    NSError *error;
    NSURL *url = [NSURL fileURLWithPath:@"/dev/null"];
    self.recorder = [[AVAudioRecorder alloc] initWithURL:url settings:settings error:&error];
    
    if(error) {
        NSLog(@"Ups, could not create recorder %@", error);
        return;
    }
   
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"sample" withExtension:@"m4a"] error:&error];
    if(error) {
        NSLog(@"Ups, could not create player %@", error);
        return;
    }
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
    
    if (error) {
        NSLog(@"Error setting category: %@", [error description]);
        return;
    }
    
    CADisplayLink *displaylink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateMeters)];
    [displaylink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
    [self.waveformView setWaveColor:[UIColor whiteColor]];
    [self.waveformView setPrimaryWaveLineWidth:3.0f];
    [self.waveformView setSecondaryWaveLineWidth:1.0];
    
    [self setSelectedInputType:SCSiriWaveformViewInputTypeRecorder];
    
    
}


- (void)setSelectedInputType:(SCSiriWaveformViewInputType)selectedInputType
{
    _selectedInputType = selectedInputType;
    
    switch (selectedInputType) {
        case SCSiriWaveformViewInputTypeRecorder: {
            [self.player stop];
            
            [self.recorder prepareToRecord];
            [self.recorder setMeteringEnabled:YES];
            [self.recorder record];
            break;
        }
        case SCSiriWaveformViewInputTypePlayer: {
            [self.recorder stop];
            
            [self.player prepareToPlay];
            [self.player setMeteringEnabled:YES];
            [self.player play];
            break;
        }
    }
}


- (void)updateMeters
{
    CGFloat normalizedValue;
    switch (self.selectedInputType) {
        case SCSiriWaveformViewInputTypeRecorder: {
            [self.recorder updateMeters];
            normalizedValue = [self _normalizedPowerLevelFromDecibels:[self.recorder averagePowerForChannel:0]];
            break;
        }
        case SCSiriWaveformViewInputTypePlayer: {
            [self.player updateMeters];
            normalizedValue = [self _normalizedPowerLevelFromDecibels:[self.player averagePowerForChannel:0]];
            break;
        }
    }
    
    [self.waveformView updateWithLevel:normalizedValue];
}

#pragma mark - Private

- (CGFloat)_normalizedPowerLevelFromDecibels:(CGFloat)decibels
{
    if (decibels < -60.0f || decibels == 0.0f) {
        return 0.0f;
    }
    
    return powf((powf(10.0f, 0.05f * decibels) - powf(10.0f, 0.05f * -60.0f)) * (1.0f / (1.0f - powf(10.0f, 0.05f * -60.0f))), 1.0f / 2.0f);
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
                
                
                self.breakingNewsLabel.text = stringobj ;
                [DM marqueLabel:self.breakingNewsLabel];
                
   
            }
            else{
                
                self.breakingNewsLabel.text = @"No News Avalable" ;
                [DM marqueLabel:self.breakingNewsLabel];
                
                DM.LequebreakingNewsString   = @"No News Avalable" ;
                
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





-(void)ShowSelectedDate
{   NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MMM YYYY"];
    self.dateSelectionTextField.text=[NSString stringWithFormat:@"%@",[formatter stringFromDate:datePicker.date]];
    [self.dateSelectionTextField resignFirstResponder];
    [self.calendarMa setDate:datePicker.date];
    NSDateFormatter *dateformate=[[NSDateFormatter alloc]init];
    [dateformate setDateFormat:@"yyyy-MM-dd"];
    NSString *date_String =[dateformate stringFromDate:datePicker.date];
    [self GetMatchList:date_String];
    
   
}

- (void)createMinAndMaxDate
{
    todayDate = [NSDate date];
    
    // Min date will be 2 month before today
    minDate = [self.calendarMa.dateHelper addToDate:todayDate months:-10];
    
    // Max date will be 2 month after today
    maxDate = [self.calendarMa.dateHelper addToDate:todayDate months:10];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];

    self.mOverlayView.hidden = YES;
    self.mProfileView.frame = CGRectMake(self.mProfileView.frame.origin.x,self.view.frame.size.height,self.mProfileView.frame.size.width,self.mProfileView.frame.size.height);

    
    NSIndexPath *tableSelection = [self.mMatchTableView indexPathForSelectedRow];
    [self.mMatchTableView deselectRowAtIndexPath:tableSelection animated:NO];
    self.mMatchTableView.separatorColor = [UIColor clearColor];
    
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return TitalArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[mMatches_Dict objectForKey:[TitalArray objectAtIndex:section]] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *CellIdentifier = @"MatchCell";
    BroadcastMatchCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[BroadcastMatchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    UIView *bgColorView = [[UIView alloc] init];
    [bgColorView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3]];
    [cell setSelectedBackgroundView:bgColorView];
    //cell.backgroundColor = [UIColor clearColor];
    
    
    matchlistmodel = [[mMatches_Dict objectForKey:[TitalArray objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    
    NSString *team1Score = [NSString stringWithFormat:@"%@",matchlistmodel.team1_score];
    NSString *team2Score = [NSString stringWithFormat:@"%@",matchlistmodel.team2_score];
    
    if ([team1Score isEqualToString:@"(null)"]) {
        cell.mTeam1Score.text = @"-";
        cell.mteam2Score.text = @"-";
    }else{
        cell.mTeam1Score.text = team1Score;
        cell.mteam2Score.text = team2Score;
    }
    
    NSString *string = [NSString stringWithFormat:@"%@",matchlistmodel.matchStatus];
    if (([string containsString:@"First Half"] != 0)||([string containsString:@"Second Half"] != 0)) {

        cell.mmatchStatus.text = [NSString stringWithFormat:@"Playing"];
    }else if ([string isEqualToString:@"Full Time"]){
        cell.mmatchStatus.text = [NSString stringWithFormat:@"FT"];
    }else if([string containsString:@"Kick off"] != 0){
        cell.mmatchStatus.text = [NSString stringWithFormat:@"Fixture"];
    }else{
        cell.mmatchStatus.text = @"-";
    }
    
    NSString *dateString = matchlistmodel.match_start_time ;
    NSDateFormatter* dateFormatter1 = [[NSDateFormatter alloc] init];
    dateFormatter1.dateFormat = @"HH:mm:ss";
    NSDate *yourDate = [dateFormatter1 dateFromString:dateString];
    dateFormatter1.dateFormat = @"HH:mm";
    NSLog(@"%@",[dateFormatter1 stringFromDate:yourDate]);
    
    cell.mMatchStartTime.text = [dateFormatter1 stringFromDate:yourDate];
    cell.mTeam1Name.text = [NSString stringWithFormat:@"%@",matchlistmodel.team1_name];
    cell.mTeam2Name.text = [NSString stringWithFormat:@"%@",matchlistmodel.team2_name];
    

    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;{

    NSLog(@"Selected View index=%ld",(long)indexPath.row);
    [mMatchTableView deselectRowAtIndexPath:indexPath animated:NO];
    
    matchlistmodel = [[mMatches_Dict objectForKey:[TitalArray objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    
    self.mOverlayView.hidden = NO;
    [UIView animateWithDuration:0.5 animations:^{
        self.mProfileView.frame = CGRectMake(self.mProfileView.frame.origin.x,self.view.frame.size.height-self.mProfileView.frame.size.height,self.mProfileView.frame.size.width,self.mProfileView.frame.size.height);
        
    }];
    
    
    //ChannelNameObj = [NSString stringWithFormat:@"%@V/s%@_%@",matchlistmodel.team1_name,matchlistmodel.team2_name,[[Helper mCurrentUser]objectForKey:@"id"]];
    
    ChannelNameObj = [NSString stringWithFormat:@"%@ V/s %@",matchlistmodel.team1_name,matchlistmodel.team2_name];
   
        ChatChannelId = [NSString stringWithFormat:@"%@",matchlistmodel.chatChannelid];
        NSLog(@"%@",ChatChannelId);


}







- (void)createChannel:(NSString *)ChannelName
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
            
            
             [self performSegueWithIdentifier:@"MatchDetail" sender:self];
            
        }
        else{
            [Helper hideLoaderSVProgressHUD];

            NSLog(@"%@",error);
            
        }
    }];
}





- (IBAction)OverlaybackgroundTap:(id)sender {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        self.mOverlayView.hidden = YES;
    });
    
    [UIView animateWithDuration:0.5 animations:^{
        self.mProfileView.frame = CGRectMake(self.mProfileView.frame.origin.x,self.view.frame.size.height,self.mProfileView.frame.size.width,self.mProfileView.frame.size.height);
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)BackButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)StreemingButtonAction:(id)sender {
    if([ChatChannelId intValue] == 0){
        
        [Helper showLoaderVProgressHUD];
        [self createChannel:ChannelNameObj];
        
    }else{
        
        NSNumber *mChannelKey = [NSNumber numberWithInteger:[ChatChannelId integerValue]];
        NSLog(@"%@",mChannelKey);
        NSLog(@"%@",self.CurrentALUser.userId);
        
        ALChannelService * channelService = [[ALChannelService alloc] init];
        [channelService addMemberToChannel:self.CurrentALUser.userId andChannelKey:mChannelKey orClientChannelKey:nil withCompletion:^(NSError *error, ALAPIResponse *response) {
            NSLog(@"%@",response);
            
        }];

        
        [self performSegueWithIdentifier:@"MatchDetail" sender:self];
    }
   
    
}

- (IBAction)todayButtonTap:(id)sender {
    [self.calendarMa setDate:todayDate];
    NSDateFormatter *dateformate=[[NSDateFormatter alloc]init];
    NSString *date_String =[dateformate stringFromDate:todayDate];
    [self GetMatchList:date_String];

}




- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"MatchDetail"]) {
         DM.channelType = @"match";
         BroadcastMatchDetailVC *destinationVC = segue.destinationViewController;
           destinationVC.matchlist = matchlistmodel;
        destinationVC.ChatChannelid = ChatChannelId;
    }
}






- (void)GetMatchList:(NSString*)date
    {
    [Helper showLoaderVProgressHUD];
        self.noBroadCastersLabel.hidden = YES;
        self.mMatchArray = [[NSMutableArray alloc]init];
        mMatches_Dict = [[NSMutableDictionary alloc]init];
        

    NSString *path=[NSString stringWithFormat:@"%@Game/get_match_list_filter/%@/%@/%@",kServiceBaseURL,leaquesmodel.sport_id,leaquesmodel.id,date];
    
    [DM GetRequest:path parameter:nil onCompletion:^(id dict) {
        NSError *errorJson=nil;
        NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:&errorJson];
        NSLog(@"%@",responseDict);
        NSMutableArray *mDataArray  = [[NSMutableArray alloc] init];
        [mDataArray addObjectsFromArray:[responseDict valueForKey:@"data"]];
        NSLog(@"%@",mDataArray);
        
        for (NSDictionary *MatchObj in mDataArray)
        {
            NSError *error;
            matchlistmodel = [[MatchListModel alloc] initWithDictionary:MatchObj error:&error];
            [self.mMatchArray addObject:matchlistmodel];
            [self.refreshControl endRefreshing];

        }
        NSLog(@"%@",mMatchArray);
        
       mMatches_Dict = [self groupSessionByDate:self.mMatchArray];
       
       TitalArray = [[mMatches_Dict allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (TitalArray.count == 0) {
                //[Helper ISAlertTypeError:@"Sorry" andMessage:@"No Matches avilable for this week"];
                self.noBroadCastersLabel.hidden = NO;
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
    
    for (matchlistmodel in matchArray) {
        [setObj addObject:matchlistmodel.match_start_date];
    }
    NSMutableDictionary *mMainDaatDict = [[NSMutableDictionary alloc] init];
    for (NSString *DateStr in [setObj allObjects]) {
        NSMutableArray *tempAry = [[NSMutableArray alloc] init];
        for (matchlistmodel in matchArray) {
            if ([matchlistmodel.match_start_date isEqualToString:DateStr]) {
                [tempAry addObject:matchlistmodel];
            }
        }
        [mMainDaatDict setObject:tempAry forKey:DateStr];
    }
    
    NSLog(@"%@",mMainDaatDict);
    
    return mMainDaatDict;
}



#pragma mark - CalendarManager delegate


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
    
    
    
    NSDateFormatter *dateformate=[[NSDateFormatter alloc]init];
    [dateformate setDateFormat:@"yyyy-MM-dd"];
    NSString *date_String =[dateformate stringFromDate:dateSelected];
    matchlistmodel = [[MatchListModel alloc] init];
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
    
    
    
    
}


- (IBAction)VideoHighlightsPressedButtonAction:(id)sender{
    
    VideoHighlightsVC *VideoHighlightsPressedUp = [self.storyboard instantiateViewControllerWithIdentifier:@"VideoHighlightsView"];
    
    VideoHighlightsPressedUp.leaqueID = leaquesmodel.id;
    
    
    [self.navigationController pushViewController:VideoHighlightsPressedUp animated:YES];

}






@end
