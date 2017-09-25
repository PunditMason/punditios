//
//  PoadcastDetailVC.m
//  IPundit
//
//  Created by Gaurav Verma on 13/09/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import "PoadcastDetailVC.h"

@interface PoadcastDetailVC (){
    NSMutableArray *EditedChannelArray;
}

@end

@implementation PoadcastDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    EditedChannelArray = [[NSMutableArray alloc] init];
    [EditedChannelArray addObjectsFromArray:self.ChannelArray];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)BackButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    NSIndexPath *tableSelection = [self.mPoadcastDetailTableView indexPathForSelectedRow];
    [self.mPoadcastDetailTableView deselectRowAtIndexPath:tableSelection animated:NO];
    self.mPoadcastDetailTableView.separatorColor = [UIColor clearColor];
    
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return EditedChannelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *CellIdentifier = @"Poadcastdetailcell";
    PoadcastDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if (cell == nil) {
        cell = [[PoadcastDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    UIView *bgColorView = [[UIView alloc] init];
    [bgColorView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3]];
    [cell setSelectedBackgroundView:bgColorView];
    
    NSLog(@"%@",EditedChannelArray);
    NSDictionary *dct = [Helper formatJSONDict:[EditedChannelArray objectAtIndex:indexPath.row]];
    cell.mMatchDetail.text = [dct objectForKey:@"time_stamp"];

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;{
    
    [self.mPoadcastDetailTableView deselectRowAtIndexPath:indexPath animated:NO];
    
     NSDictionary *dct = [Helper formatJSONDict:[EditedChannelArray objectAtIndex:indexPath.row]];
    
    
    
    [self openSocialUrl:[NSString stringWithFormat:@"https://s3.amazonaws.com/red5proautoplay/live/streams/%@.mp4",[dct objectForKey:@"streamName"]]];
    
    
    
    NSURL *streamURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://s3.amazonaws.com/red5proautoplay/live/streams/%@.mp4",[dct objectForKey:@"streamName"]]];
    
    //[self PlayAudio:streamURL];
}




- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dct = [Helper formatJSONDict:[EditedChannelArray objectAtIndex:indexPath.row]];
    if ([[dct objectForKey:@"broadcaster_id"] integerValue] == [[[Helper mCurrentUser]objectForKey:@"id"] integerValue]) {
        return YES;

    }
    else{
        return NO;

    }
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSDictionary *dct = [Helper formatJSONDict:[EditedChannelArray objectAtIndex:indexPath.row]];
        [self DeleteChannel:dct];
        
        
    }
}



//Parameters => ,


-(void)DeleteChannel:(NSDictionary *)dct {
    

    NSMutableDictionary *Parameters = [NSMutableDictionary new];
    [Parameters setObject:[dct objectForKey:@"broadcaster_id"] forKey:@"broadcaster_id"];
    [Parameters setObject:[dct objectForKey:@"id"] forKey:@"channel_id"];
    [Helper showLoaderVProgressHUD];
    
    NSString *string = [NSString stringWithFormat:@"%@app/deletePodcast/",KServiceBaseURL];
    [DM PostRequest:string parameter:Parameters onCompletion:^(id  _Nullable dict) {
        NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
        NSLog(@"ResponseDict %@",responseDict);
        
        if ([[responseDict objectForKey:@"responsestatus"] integerValue] == 1) {
            NSLog(@"%@",[responseDict objectForKey:@"message"]);
            [self BackButtonAction:self];
        }
        else{
            NSLog(@"%@",[responseDict objectForKey:@"message"]);
            
             [Helper ISAlertTypeError:[responseDict objectForKey:@"message"] andMessage:kNOInternet];
            
        }
            
        
        
        [self.mPoadcastDetailTableView reloadData];
        [Helper hideLoaderSVProgressHUD];
        
        
    } onError:^(NSError * _Nullable Error) {
        [Helper hideLoaderSVProgressHUD];
        NSLog(@"%@",Error);
        NSString *ErrorString = [NSString stringWithFormat:@"%@",Error];
        [Helper ISAlertTypeError:ErrorString andMessage:kNOInternet];
    }];
}





-(void)PlayAudio:(NSURL *)streamURL{

    self.streamPlayer = [[MPMoviePlayerController alloc] initWithContentURL:streamURL];
    self.streamPlayer.view.frame = CGRectMake(0, 528, 320, 40);
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleMPMoviePlayerPlaybackDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:nil];
    
    self.streamPlayer.controlStyle = MPMovieControlStyleEmbedded;
    self.streamPlayer.view.tag = 114;
    self.streamPlayer.scalingMode = MPMovieScalingModeAspectFill;
    self.streamPlayer.movieSourceType = MPMovieSourceTypeStreaming;
    [self.view addSubview:self.streamPlayer.view];
    
    [self.streamPlayer prepareToPlay];
    [self.streamPlayer play];
    
}

- (void)handleMPMoviePlayerPlaybackDidFinish:(NSNotification *)notification {
    [self.streamPlayer.view removeFromSuperview];
    NSDictionary *notificationUserInfo = [notification userInfo];
    NSNumber *resultValue = [notificationUserInfo objectForKey:MPMoviePlayerPlaybackDidFinishReasonUserInfoKey];
    MPMovieFinishReason reason = [resultValue intValue];
    if (reason == MPMovieFinishReasonPlaybackError) {
        NSError *mediaPlayerError = [notificationUserInfo objectForKey:@"error"];
        if (mediaPlayerError) {
            NSLog(@"playback failed with error description: %@", [mediaPlayerError localizedDescription]);
        }
        else {
            NSLog(@"playback failed without any given reason");
        }
    }
}



- (void)openSocialUrl:(NSString *) linkStr {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:linkStr]];
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
