//
//  VideoHighlightsVC.m
//  IPundit
//
//  Created by Gaurav Verma on 30/10/17.
//  Copyright © 2017 James Mason. All rights reserved.
//

#import "VideoHighlightsVC.h"
#import "VideoHighlightsCell.h"
#import "DZNWebViewController.h"
#import "UIImageView+WebCache.h"
#import "YTPlayerVC.h"
@interface VideoHighlightsVC (){
    NSMutableArray *videosArray;
    VideoHighlightsCell *cell;
}

@end

@implementation VideoHighlightsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    videosArray =  [[NSMutableArray alloc] init];
    self.backgroundImageView.image = DM.backgroundImage ;

    [self GetLeagueVideoList];
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    
    NSIndexPath *tableSelection = [self.mVideoHighlightTableView indexPathForSelectedRow];
    [self.mVideoHighlightTableView deselectRowAtIndexPath:tableSelection animated:NO];
    self.mVideoHighlightTableView.separatorColor = [UIColor clearColor];
    
    
}




-(void)GetLeagueVideoList{
    
    [Helper showLoaderVProgressHUD];
    

    NSString *string = [NSString stringWithFormat:@"%@game/getLeagueVideoList/%@/",KServiceBaseURL,_leaqueID];
    [DM GetRequest:string parameter:nil onCompletion:^(id  _Nullable dict) {
        NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
        NSLog(@"ResponseDict %@",responseDict);
        
        if ([responseDict objectForKey:@"videos"]) {
            [videosArray removeAllObjects];
            [videosArray addObjectsFromArray:[responseDict objectForKey:@"videos"]];
            if (videosArray.count > 0) {
                self.mVideoHighlightsLable.hidden = true;
                self.mVideoHighlightTableView.hidden = false;

            }
            else{
                self.mVideoHighlightsLable.hidden = false;
                self.mVideoHighlightTableView.hidden = true;


            }
            
        }
        
        [self.mVideoHighlightTableView reloadData];
        [Helper hideLoaderSVProgressHUD];
        
        
    } onError:^(NSError * _Nullable Error) {
        [Helper hideLoaderSVProgressHUD];
        NSLog(@"%@",Error);
        NSString *ErrorString = [NSString stringWithFormat:@"%@",Error];
        [Helper ISAlertTypeError:ErrorString andMessage:kNOInternet];
    }];
}




-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return videosArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"VideoHighlightsCeell";
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[VideoHighlightsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
    
    UIView *bgColorView = [[UIView alloc] init];
    [bgColorView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3]];
    
    [cell setSelectedBackgroundView:bgColorView];
    
    cell.backgroundColor = [UIColor clearColor];
    NSDictionary *dct = [Helper formatJSONDict:[videosArray objectAtIndex:indexPath.row]];
    
    cell.mTitalCellLbl.text = [dct objectForKey:@"video_title"];
    cell.mSubTitalCellLbl.text = [NSString stringWithFormat:@"%@ %@",[dct objectForKey:@"video_date"],[dct objectForKey:@"video_channel_title"]];

  //  [cell.playerView loadWithVideoId:[dct objectForKey:@"youTubeId"]];

    
    NSString * string = [NSString stringWithFormat:@"https://img.youtube.com/vi/%@/sddefault.jpg",[dct objectForKey:@"youTubeId"]];
    NSURL *url = [NSURL URLWithString:string];
    [cell.mimageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"Novideo2"]];
    
    
    
    

    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;{
    
    NSLog(@"Selected View index=%ld",(long)indexPath.row);
    [self.mVideoHighlightTableView deselectRowAtIndexPath:indexPath animated:NO];
    NSDictionary *dct = [Helper formatJSONDict:[videosArray objectAtIndex:indexPath.row]];

    YTPlayerVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"YTPlayerView"];
    vc.youTubeId = [dct objectForKey:@"youTubeId"];
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
   // [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[dct objectForKey:@"video_link"]]];
    
    


    /*
    NSURL *URL = [NSURL URLWithString:[dct objectForKey:@"video_link"]];
    
    DZNWebViewController *WVC = [[DZNWebViewController alloc] initWithURL:URL];
    UINavigationController *NC = [[UINavigationController alloc] initWithRootViewController:WVC];
    
    WVC.supportedWebNavigationTools = DZNWebNavigationToolNone;
    WVC.supportedWebActions = DZNWebActionNone;
    WVC.showPageTitleAndURL = YES;
    WVC.showLoadingProgress = YES;
    WVC.allowHistory = YES;
    WVC.hideBarsWithGestures = YES;
    
    [self presentViewController:NC animated:YES completion:NULL];
    */

}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closePopup:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];

    
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
