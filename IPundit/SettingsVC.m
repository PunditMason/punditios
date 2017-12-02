//
//  SettingsVC.m
//  IPundit
//
//  Created by Deepak Kumar on 28/02/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import "SettingsVC.h"
#import "UserTBCell.h"
#import "ListenersTrophyTableViewCell.h"
#import "TrophyViewTableViewCell.h"
#import "ListenMatchDetailVC.h"
#import "PunditDetailVC.h"




@interface SettingsVC (){
    NSMutableDictionary * mDataDict ;
    NSMutableArray * mDataArray ;
    NSMutableArray *mDataArrayy;
    NSDictionary * dictReff;
    NSIndexPath *mmindexpath;
    
}

@end

@implementation SettingsVC
@synthesize mTableView,refreshControl;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.backgroundImageView.image = DM.backgroundImage ;

    [self getUsers];
    refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.tintColor = [UIColor grayColor];
    [refreshControl addTarget:self action:@selector(refershControlAction) forControlEvents:UIControlEventValueChanged];
    [refreshControl setTintColor:[UIColor whiteColor]];
    [refreshControl tintColorDidChange];
    [mTableView addSubview:refreshControl];
    mTableView.alwaysBounceVertical = YES;
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self getUsers];
}

-(void)refershControlAction{
    [self getUsers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return mDataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableDictionary * dictRef = [[NSMutableDictionary alloc]init];
    dictRef = [mDataArray objectAtIndex:indexPath.row];
    
    NSString * stringRef = [NSString stringWithFormat:@"%@",[dictRef objectForKey:@"live"]];
    if (dictRef [@"channel_info"] ) {
            static NSString *CellIdentifier = @"ListenersTrophyTableViewCell";
            ListenersTrophyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            NSArray * xibReff = [[NSBundle mainBundle]loadNibNamed:@"ListenersTrophyTableViewCell" owner:self options:nil];
            if (cell == nil) {
                cell = [xibReff objectAtIndex:0];
            }
            
            cell.posLabel.hidden = YES;
            cell.clubNameLabel.frame = CGRectMake(35, 9, 170, 26);
            cell.clubNameLabel.text = [NSString stringWithFormat:@"%@",[dictRef objectForKey:@"first_name"]];
            cell.clubNameLabel.font = [UIFont fontWithName:@"System Bold " size:14] ;
       
            cell.pLabel.hidden = YES;
            cell.wLabel.hidden = YES;
            cell.dLabel.hidden = YES;
            cell.lLabel.hidden = YES;
            cell.mGDLabel.hidden = YES;
            cell.mPointsLabel.hidden = YES;
            
            UIView *bgColorView = [[UIView alloc] init];
            [bgColorView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3]];
            [cell setSelectedBackgroundView:bgColorView];
            cell.backgroundColor = [UIColor clearColor];
            //[cell setUserInteractionEnabled:NO];
        
            return cell;
    }else{
    
    static NSString *CellIdentifier = @"TrophyViewTableViewCell";
    TrophyViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSArray * xibReff = [[NSBundle mainBundle]loadNibNamed:@"TrophyViewTableViewCell" owner:self options:nil];
    if (cell == nil) {
        cell = [xibReff objectAtIndex:0];
    }
    
    cell.posLabel.hidden = YES ;
    cell.clubNameLabel.frame = CGRectMake(35, 9, 250, 26);
    cell.clubNameLabel.text = [NSString stringWithFormat:@"%@",[dictRef objectForKey:@"first_name"]];
    cell.clubNameLabel.font = [UIFont fontWithName:@"System Bold" size:14] ;
    cell.pLabel.hidden = YES;
    cell.wLabel.hidden = YES;
    cell.dLabel.hidden = YES;
    cell.lLabel.hidden = YES;
    cell.mGDLabel.hidden = YES;
    cell.mPointsLabel.hidden = YES;
    
    
    UIView *bgColorView = [[UIView alloc] init];
    [bgColorView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3]];
    [cell setSelectedBackgroundView:bgColorView];
    cell.backgroundColor = [UIColor clearColor];
   // [cell setUserInteractionEnabled:NO];
    
    
    return cell;
}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    // PunditDetailView
    NSMutableDictionary * dictRef = [[NSMutableDictionary alloc]init];
    dictRef = [mDataArray objectAtIndex:indexPath.row];
    ListenMatchDetailVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ListenMatchDetailVC"];
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    dict = [[dictRef valueForKey:@"channel_info"]objectAtIndex:0];
    vc.punditsMessage = @"yes" ;
    vc.channelDict = [dict valueForKey:@"channel"];
    
    if ([[[dict valueForKey:@"channel"] valueForKey:@"channel_type"]isEqualToString:@"match"]) {
    vc.matchInfoDict = [dict valueForKey:@"match_info"];
    }else{
    vc.matchInfoDict = [dict valueForKey:@"team_info"];
    }
    
    NSLog(@"%@",dict);
    DM.listenerPresentIcon = [NSString stringWithFormat:@"%@",[[dict valueForKey:@"channel"]valueForKey:@"mark_image"]];
    [self.navigationController pushViewController:vc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
     */
    
    [mDataArrayy addObjectsFromArray:[mDataArray objectAtIndex:indexPath.row]];
    dictReff = [Helper formatJSONDict:[mDataArray objectAtIndex:indexPath.row]];
    mmindexpath = indexPath;
    
    [self performSegueWithIdentifier: @"PunditDetailVie" sender: self];
}



-(void)getUsers{
    
    [Helper showLoaderVProgressHUD];
    //NSString *path = [NSString stringWithFormat:@"%@Game/get_users_match_info",KServiceBaseURL];
    NSString *path = [NSString stringWithFormat:@"%@Game/getProfiles/%@",KServiceBaseURL,[[Helper mCurrentUser]objectForKey:@"id"]];
    
    [DM GetRequest:path parameter:nil onCompletion:^(id  _Nullable dict) {
        
        NSError *errorJson=nil;
        NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:&errorJson];
        
        mDataArray = [[NSMutableArray alloc]init];
        mDataArray = [responseDict objectForKey:@"users_list"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [mTableView reloadData];
            [self.refreshControl endRefreshing];
            [Helper hideLoaderSVProgressHUD];
        });
    
    } onError:^(NSError * _Nullable Error) {
        [Helper hideLoaderSVProgressHUD];
    }];
    
}














#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"PunditDetailVie"]) {
        PunditDetailVC *PunditDetailvc = segue.destinationViewController;
        PunditDetailvc.dictRefff = dictReff;
        PunditDetailvc.mDataArrayyy = mDataArray;
        PunditDetailvc.mindex = mmindexpath;
 
    }
    

}

- (IBAction)BackButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
