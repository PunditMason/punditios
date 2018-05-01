//
//  PoadcastDetailVC.m
//  IPundit
//
//  Created by Gaurav Verma on 13/09/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import "ManageLeaqueDetailVC.h"

@interface ManageLeaqueDetailVC (){
    NSMutableArray *EditedChannelArray;
    ManageLeaqueDetailCell *cell;
    NSMutableArray *mSelectedArray;
    BOOL playpausecheckbool;

}

@end

@implementation ManageLeaqueDetailVC
@synthesize player;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    EditedChannelArray = [[NSMutableArray alloc] init];
    [EditedChannelArray addObjectsFromArray:self.ChannelArray];
    mSelectedArray = [[NSMutableArray alloc]init];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)BackButtonAction:(id)sender {
    /*
    if (playpausecheckbool == FALSE) {
        [player pause];
    }
    */
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
    
    
    static NSString *CellIdentifier = @"ManageLeaquedetailcell";
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if (cell == nil) {
        cell = [[ManageLeaqueDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    UIView *bgColorView = [[UIView alloc] init];
    [bgColorView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3]];
    [cell setSelectedBackgroundView:bgColorView];
    
    NSLog(@"%@",EditedChannelArray);
    NSDictionary *dct = [Helper formatJSONDict:[EditedChannelArray objectAtIndex:indexPath.row]];
    
    NSURL *settingsUrl = [NSURL URLWithString:self.LIString];
    [cell.mImageview sd_setImageWithURL:settingsUrl placeholderImage:[UIImage imageNamed:@"pod_bg.png"]];
    
    
    if ([mSelectedArray containsObject:indexPath]) {
        cell.mPlayImageview.image = [UIImage imageNamed:@"if_Stop1PressedBlue_22950.png"];

    } else {
        cell.mPlayImageview.image = [UIImage imageNamed:@"if_Play1Pressed_22932.png"];


        
    }
    
    NSString *str1 = [dct objectForKey:@"name"];
    NSRange range = [str1 rangeOfString:@"-"];
    if (range.location != NSNotFound) {
        NSString *newString = [str1 substringToIndex:range.location];
        NSLog(@"%@",newString);
        cell.mMatchDetail.text = newString;

    } else {
        cell.mMatchDetail.text = [dct objectForKey:@"name"];
    }
    
    cell.mPodcastNameLable.text = [dct objectForKey:@"podcast_name"];
    cell.mTimeLable.text = [dct objectForKey:@"length"];

    cell.mPodcastNameButton.tag = indexPath.row;
    [cell.mPodcastNameButton addTarget:self action:@selector(PodcastNameButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    
    return cell;
}
-(void)PodcastNameButtonPressed:(UIButton*)sender{
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.mPoadcastDetailTableView];
    NSIndexPath *indexPath = [self.mPoadcastDetailTableView indexPathForRowAtPoint:buttonPosition];
    NSDictionary *dct = [Helper formatJSONDict:[EditedChannelArray objectAtIndex:indexPath.row]];
    NSString *mSelectedPodcast = [NSString stringWithFormat:@"%@",[dct objectForKey:@"podcast_name"]];
    
    NSLog(@"PodcastNameButtonPressed");
    
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"EDIT PODCAST" message: @"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Edit Podcast";
        textField.text = mSelectedPodcast;
        textField.textColor = [UIColor blueColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
    }];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSArray * textfields = alertController.textFields;
        UITextField * mEditDataTextField = textfields[0];
        if (mEditDataTextField.text.length > 0) {
            NSLog(@"%@",mEditDataTextField.text);
            
            
           // cell.mPodcastNameLable.text = mEditDataTextField.text;
            
           // [self UpdatePodcastName:mEditDataTextField.text andpodcastid:dct];
            [self UpdatePodcastName:mEditDataTextField.text andpodcastid:dct atindex:indexPath];

        }
        [self.mPoadcastDetailTableView reloadData];
        
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        
    }]];
    
    if ([[dct objectForKey:@"broadcaster_id"] integerValue] == [[[Helper mCurrentUser]objectForKey:@"id"] integerValue]) {
        
        [self presentViewController:alertController animated:YES completion:nil];

    }
    

}




-(void)UpdatePodcastName:(NSString *)podcastname andpodcastid:(NSDictionary *)dct atindex:(NSIndexPath *)index{
    NSMutableDictionary *Parameters = [NSMutableDictionary new];
    [Parameters setObject:podcastname forKey:@"podcast_name"];
    [Parameters setObject:[dct objectForKey:@"id"] forKey:@"channel_id"];
    [Parameters setObject:[dct objectForKey:@"name_index_update"] forKey:@"name_index_update"];

    [Helper showLoaderVProgressHUD];
    
    NSString *string = [NSString stringWithFormat:@"%@app/updatePodcastName/",KServiceBaseURL];
    [DM PostRequest:string parameter:Parameters onCompletion:^(id  _Nullable dict) {
        NSDictionary* responseDict = [NSJSONSerialization  JSONObjectWithData:dict options:kNilOptions error:nil];
        NSLog(@"ResponseDict %@",responseDict);
        
//        EditedChannelArray = [[NSMutableArray alloc] init];
//        [EditedChannelArray addObjectsFromArray:[responseDict valueForKey:@"channel_info"]];
//        [self.mPoadcastDetailTableView reloadData];
        
          [EditedChannelArray replaceObjectAtIndex:index.row withObject:[responseDict valueForKey:@"channel_info"]];
            [self.mPoadcastDetailTableView reloadData];

        
        
       // [self BackButtonAction:self];
        [Helper hideLoaderSVProgressHUD];
    } onError:^(NSError * _Nullable Error) {
        [Helper hideLoaderSVProgressHUD];
        NSLog(@"%@",Error);
        NSString *ErrorString = [NSString stringWithFormat:@"%@",Error];
        [Helper ISAlertTypeError:@"Error!!" andMessage:ErrorString];
    }];
}






- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;{
    
    [self.mPoadcastDetailTableView deselectRowAtIndexPath:indexPath animated:NO];
    
     NSDictionary *dct = [Helper formatJSONDict:[EditedChannelArray objectAtIndex:indexPath.row]];
    
    
    
    [self openSocialUrl:[NSString stringWithFormat:@"https://s3.amazonaws.com/red5proautoplay/live/streams/%@.mp4",[dct objectForKey:@"streamName"]]];
    
    

    /*
    NSURL *streamURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://s3.amazonaws.com/red5proautoplay/live/streams/%@.mp4",[dct objectForKey:@"streamName"]]];

    
    
    
   
    if ([mSelectedArray containsObject:indexPath]) {
        [self PauseFunction];
        
    } else {
        [Helper showLoaderVProgressHUD];

        
        [mSelectedArray removeAllObjects];
        [mSelectedArray addObject:indexPath];
        [self.mPoadcastDetailTableView reloadData];
        if(streamURL){
            [self setupAVPlayerForURL:streamURL];

        }
        
        playpausecheckbool = FALSE;

        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 5 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [Helper hideLoaderSVProgressHUD];
        });

    
    }
    */
    
    //  [self PlayAudio:streamURL];
    


    
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
        }else{
            NSLog(@"%@",[responseDict objectForKey:@"message"]);
             [Helper ISAlertTypeError:@"Error!!" andMessage:[responseDict objectForKey:@"message"]];
        }
        [self.mPoadcastDetailTableView reloadData];
        [Helper hideLoaderSVProgressHUD];
    } onError:^(NSError * _Nullable Error) {
        [Helper hideLoaderSVProgressHUD];
        NSLog(@"%@",Error);
        NSString *ErrorString = [NSString stringWithFormat:@"%@",Error];
        [Helper ISAlertTypeError:@"Error!!" andMessage:ErrorString];
    }];
}


 
 -(void) setupAVPlayerForURL: (NSURL*) url {
 AVAsset *asset = [AVURLAsset URLAssetWithURL:url options:nil];
 AVPlayerItem *anItem = [AVPlayerItem playerItemWithAsset:asset];
 
 player = [AVPlayer playerWithPlayerItem:anItem];
 [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemDidFinishPlaying:) name:AVPlayerItemDidPlayToEndTimeNotification object:player.currentItem];
 
 
 [player addObserver:self forKeyPath:@"status" options:0 context:nil];
 [player play];
 
 }
 -(void)itemDidFinishPlaying:(NSNotification *) notification {
 
     [self PauseFunction];

 }

-(void)PauseFunction{
    
    [mSelectedArray removeAllObjects];
    [self.mPoadcastDetailTableView reloadData];
    [player pause];
    playpausecheckbool = TRUE;
    
    
    
}

 - (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
 
 if (object == player && [keyPath isEqualToString:@"status"]) {
 if (player.status == AVPlayerStatusFailed) {
 NSLog(@"AVPlayer Failed");
 } else if (player.status == AVPlayerStatusReadyToPlay) {
 NSLog(@"AVPlayer Ready to Play");
 } else if (player.status == AVPlayerItemStatusUnknown) {
 NSLog(@"AVPlayer Unknown");
 }
 }
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
    [mSelectedArray removeAllObjects];
    [self.mPoadcastDetailTableView reloadData];
    
    
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
