//
//  TrophyViewController.m
//  IPundit
//
//  Created by softuvo on 20/04/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import "TrophyViewController.h"
#import "TrophyViewTableViewCell.h"
#import "ListenersTrophyTableViewCell.h"
#import "BroadcastMatchDetailVC.h"
#import "ListenMatchDetailVC.h"
#import "Constants.h"
#import "DataManager.h"

@interface TrophyViewController (){
    NSIndexPath *broadcastRef ;
}

@end

@implementation TrophyViewController
@synthesize leaquesModel,refreshControl,matchlistmodel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.backgroundImageView.image = DM.backgroundImage ;
    if (IS_IPHONE4) {
        self.view.frame = CGRectMake(0, 0, 320, 480);
        self.tableView.frame = CGRectMake(0, 84, 320, 376);
        self.notifyLabel.frame = CGRectMake(12, 378, 300, 17);
        self.noMatchesLabel.frame = CGRectMake(22, 192, 275, 44);
    }
    self.noMatchesLabel.hidden = YES ;
    NSString *captialString =[DM.leaqueNameForTrophyViewController uppercaseString];

    self.leaqueNameLabel.text = captialString ;

    [Helper showLoaderVProgressHUD];
    self.tableView.backgroundColor = [UIColor clearColor];
    leaquesModel = [[LeaquesModel alloc]initWithDictionary:DM.trophyViewControllerData error:nil];
    
    _serverResponse = [[NSMutableArray alloc]init];
  
    refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.tintColor = [UIColor grayColor];
    [refreshControl addTarget:self action:@selector(refershControlAction) forControlEvents:UIControlEventValueChanged];
    [refreshControl setTintColor:[UIColor whiteColor]];
    [refreshControl tintColorDidChange];
    [self.tableView addSubview:refreshControl];
    self.tableView.delegate = self ;
    self.tableView.dataSource = self ;
    self.tableView.allowsSelection = YES;
    
    if ( [DM.appFlowRef isEqualToString:@"Listen"]) {
        self.notifyLabel.text = [NSString stringWithFormat:@"Tap a club name to Listen about this team"];
    }else{
        self.notifyLabel.text = [NSString stringWithFormat:@"Tap a club name to Broadcast about this team"];
    }
}

-(void)refershControlAction{
    
    [self getData];
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [self getData];
    [[IQKeyboardManager sharedManager] setEnable:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [self getData];
    self.mOverlayView.hidden = YES;
    self.mProfileView.frame = CGRectMake(self.mProfileView.frame.origin.x,self.view.frame.size.height,self.mProfileView.frame.size.width,self.mProfileView.frame.size.height);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.serverResponse.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([DM.appFlowRef isEqualToString:@"Listen"]) {
        
        NSArray * array = [NSArray arrayWithArray:[[self.serverResponse objectAtIndex:indexPath.row]objectForKey:@"channel"]];
        if (array.count > 0) {
            static NSString *CellIdentifier = @"ListenersTrophyTableViewCell";
            ListenersTrophyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            NSArray * xibReff = [[NSBundle mainBundle]loadNibNamed:@"ListenersTrophyTableViewCell" owner:self options:nil];
            if (cell == nil) {
                cell = [xibReff objectAtIndex:0];
            }
            
            cell.posLabel.text =[[self.serverResponse objectAtIndex:indexPath.row]objectForKey:@"rank"];
            cell.clubNameLabel.text =[[self.serverResponse objectAtIndex:indexPath.row]objectForKey:@"contestantClubName"];
            cell.pLabel.text =[[self.serverResponse objectAtIndex:indexPath.row]objectForKey:@"matchesPlayed"];
            cell.wLabel.text =[[self.serverResponse objectAtIndex:indexPath.row]objectForKey:@"matchesWon"];
            cell.dLabel.text =[[self.serverResponse objectAtIndex:indexPath.row]objectForKey:@"matchesDrawn"];
            cell.lLabel.text =[[self.serverResponse objectAtIndex:indexPath.row]objectForKey:@"matchesLost"];
            cell.mGDLabel.text =[[self.serverResponse objectAtIndex:indexPath.row]objectForKey:@"goaldifference"];
            cell.mPointsLabel.text =[[self.serverResponse objectAtIndex:indexPath.row]objectForKey:@"points"];
            
            
            UIView *bgColorView = [[UIView alloc] init];
            [bgColorView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3]];
            [cell setSelectedBackgroundView:bgColorView];
            cell.backgroundColor = [UIColor clearColor];
            
            return cell;

        }
    }

    static NSString *CellIdentifier = @"TrophyViewTableViewCell";
    TrophyViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSArray * xibReff = [[NSBundle mainBundle]loadNibNamed:@"TrophyViewTableViewCell" owner:self options:nil];
    if (cell == nil) {
       cell = [xibReff objectAtIndex:0];
    }
    
    cell.posLabel.text =[[self.serverResponse objectAtIndex:indexPath.row]objectForKey:@"rank"];
    cell.clubNameLabel.text =[[self.serverResponse objectAtIndex:indexPath.row]objectForKey:@"contestantClubName"];
    cell.pLabel.text =[[self.serverResponse objectAtIndex:indexPath.row]objectForKey:@"matchesPlayed"];
    cell.wLabel.text =[[self.serverResponse objectAtIndex:indexPath.row]objectForKey:@"matchesWon"];
    cell.dLabel.text =[[self.serverResponse objectAtIndex:indexPath.row]objectForKey:@"matchesDrawn"];
    cell.lLabel.text =[[self.serverResponse objectAtIndex:indexPath.row]objectForKey:@"matchesLost"];
    cell.mGDLabel.text =[[self.serverResponse objectAtIndex:indexPath.row]objectForKey:@"goaldifference"];
    cell.mPointsLabel.text =[[self.serverResponse objectAtIndex:indexPath.row]objectForKey:@"points"];
    
    
    UIView *bgColorView = [[UIView alloc] init];
    [bgColorView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3]];
    [cell setSelectedBackgroundView:bgColorView];
    cell.backgroundColor = [UIColor clearColor];
    
     if ([DM.appFlowRef isEqualToString:@"Listen"]) {
         [cell setUserInteractionEnabled:NO];
     }
    
    return cell;
    
}


-(void)getData{
   
    [Helper showLoaderVProgressHUD];
    self.noMatchesLabel.hidden = YES ;
    NSString *path;
    if ([DM.appFlowRef isEqualToString:@"Listen"]) {
          path=[NSString stringWithFormat:@"%@Game/leaguestatest/%@/%@",kServiceBaseURL,DM.sportsIdForTrophyVC,DM.leaqueIdForTrophyVC];
       
    }else{
    
        path =[NSString stringWithFormat:@"%@Game/leaguestat/%@/%@",kServiceBaseURL,DM.sportsIdForTrophyVC,DM.leaqueIdForTrophyVC];
    }
    
    [DM GetRequest:path parameter:nil onCompletion:^(id  _Nullable dict) {
        
        NSMutableDictionary *serverData=[NSJSONSerialization JSONObjectWithData:dict options:0 error:nil];
        self.serverResponse =[serverData objectForKey:@"data"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [self.refreshControl endRefreshing];
            
            if (self.serverResponse.count == 0 ) {
                self.noMatchesLabel.hidden = NO ;
            }
            [Helper hideLoaderSVProgressHUD];
        });

        
    } onError:^(NSError * _Nullable Error) {
        
    }];

}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"Selected View index=%ld",(long)indexPath.row);

    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];

    DM.channelType = @"team";
    if ([DM.appFlowRef isEqualToString:@"Listen"]) {
        ListenMatchDetailVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ListenMatchDetailVC"];
        vc.teamListenDetails = [self.serverResponse objectAtIndex:indexPath.row];
        DM.liveBroadcastersArray = [[self.serverResponse objectAtIndex:indexPath.row]objectForKey:@"channel"];
        NSLog(@"%@",DM.liveBroadcastersArray);
        [self.navigationController pushViewController:vc animated:YES];
        
    }else{
        broadcastRef = indexPath;
        self.mOverlayView.hidden = NO;
        [UIView animateWithDuration:0.5 animations:^{
            self.mProfileView.frame = CGRectMake(self.mProfileView.frame.origin.x,self.view.frame.size.height-self.mProfileView.frame.size.height,self.mProfileView.frame.size.width,self.mProfileView.frame.size.height);
            
        }];
    }
    
}



- (IBAction)OverlaybackgroundTap:(id)sender {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        self.mOverlayView.hidden = YES;
    });
    
    [UIView animateWithDuration:0.5 animations:^{
        self.mProfileView.frame = CGRectMake(self.mProfileView.frame.origin.x,self.view.frame.size.height,self.mProfileView.frame.size.width,self.mProfileView.frame.size.height);
    }];
    
}

- (IBAction)StreemingButtonAction:(id)sender {
    
    BroadcastMatchDetailVC * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"BroadcastMatchDetailVC"];
    vc.teamBroadCastDict = [self.serverResponse objectAtIndex:broadcastRef.row];
    
    [self.navigationController pushViewController:vc animated:YES];
}






/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backButtonAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
@end
