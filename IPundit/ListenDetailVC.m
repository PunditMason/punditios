//
//  DetailVC.m
//  IPundit
//
//  Created by Deepak Kumar on 02/03/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import "ListenDetailVC.h"
#import "ListenDetailCell.h"
#import "ListenMatchVC.h"
#import "MainListenDetailCell.h"
#import "ListenersTrophyTableViewCell.h"
#import "TrophyViewTableViewCell.h"
#import "ListenMatchDetailVC.h"
#import "PunditDetailVC.h"


@interface ListenDetailVC (){
    NSArray *searchArray ;
    NSString * searchRef ;
    NSMutableArray *searchDataArray ;
    NSMutableArray *teamSearchDataArray ;

    NSMutableArray *mDataArrayy;
    NSDictionary * dictReff;
    NSIndexPath *mmindexpath;
    
}

@end

@implementation ListenDetailVC
@synthesize mSearchString,mLeaqueArray,leaque,refreshControl,Sports;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mliveBroadcastersArray = [[NSMutableArray alloc] init];

    self.searchSelectionView.hidden = YES ;
    self.backgroundImageView.image = DM.backgroundImage ;

    if (IS_IPHONE4) {
        self.view.frame = CGRectMake(0, 0, 320, 480);
        self.mCollectionView.frame = CGRectMake(13, 136, 294, 324);
        self.breakingNewsView.frame = CGRectMake(0, 462, 320, 18);
    }else{
        self.mCollectionView.frame = CGRectMake(13, 136, 294, 412);
    }
    
    _userButton.selected = NO;
    _teamButton.selected = NO ;
    _leagueButton.selected = YES ;
    searchRef = [NSString stringWithFormat:@"%@",kleague];
    self.mTableView.hidden = YES ;
    self.mTeamTableView.hidden = YES ;

    NSString * string = [NSString stringWithFormat:@"%@%@",KServiceBaseProfileImageURL,[[Helper mGetProfileCurrentUser]objectForKey:@"avatar"]];
    NSURL *url = [NSURL URLWithString:string];
    if (url) {
      [self.profilePicImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"profile-icon"]];
    }
    
    CALayer *imageLayer = self.profilePicImageView.layer;
    [imageLayer setCornerRadius:5];
    [imageLayer setBorderColor:[[UIColor clearColor]CGColor]];
    [imageLayer setBorderWidth:0.5];
    [imageLayer setMasksToBounds:YES];
    

    refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.tintColor = [UIColor grayColor];
    [refreshControl addTarget:self action:@selector(refershControlAction) forControlEvents:UIControlEventValueChanged];
    [refreshControl setTintColor:[UIColor whiteColor]];
    [refreshControl tintColorDidChange];
    [self.mCollectionView addSubview:refreshControl];
    self.mCollectionView.alwaysBounceVertical = YES;
    self.mTableView.tableFooterView = [UIView new];
    self.mTeamTableView.tableFooterView = [UIView new];

    
}
-(void)refershControlAction{
    
    [self GetSportsList];
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    IQKeyboardManager.sharedManager.enable = true;
    
    self.breakingNewsLabel.text = DM.breakingNewsString ;
    [DM marqueLabel:self.breakingNewsLabel];
    searchDataArray = [[NSMutableArray alloc]init];
    [self.mTableView reloadData];
    [self.mCollectionView reloadData];
    [self GetSportsList];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [self GetSportsList];
    [[IQKeyboardManager sharedManager] setEnable:YES];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width=0.0;
    CGFloat height=0.0;
    if (indexPath.row == 0) {
         width = 294;
         height = 198;
    }
    else{
        width = 143;
        height = 100;
    }
    
    return CGSizeMake(width, height);
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return mLeaqueArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        MainListenDetailCell * cell = [self.mCollectionView dequeueReusableCellWithReuseIdentifier:@"MainListenDetailCell" forIndexPath:indexPath];
        
        
        self.mCollectionView.allowsMultipleSelection = NO;
        
        NSError *error;
        leaque = [[LeaquesModel alloc] initWithDictionary:[mLeaqueArray objectAtIndex:indexPath.row] error:&error];
        
        NSString * string = [NSString stringWithFormat:@"%@ios_league_mark/%@",KserviceBaseIconURL,leaque.cover_image];
        NSString * iconString = [NSString stringWithFormat:@"%@ios_league_mark/%@",KserviceBaseIconURL,leaque.mark_image];
        NSURL *url = [NSURL URLWithString:string];
        NSURL *iconUrl = [NSURL URLWithString:iconString];
        [cell.mImageView sd_setImageWithURL:url ];
        [cell.mImageIconView sd_setImageWithURL:iconUrl];
        cell.mLeaqueLable.text = leaque.name;
        if ([leaque.broadcaster_count isEqualToString:@"0"]) {
            cell.broadcasterCountImageView.hidden = YES ;
            cell.broadcasterCountLabel.hidden = YES ;
        }else{
            cell.broadcasterCountLabel.text = leaque.broadcaster_count;
            cell.broadcasterCountImageView.hidden = NO ;
            cell.broadcasterCountLabel.hidden = NO ;
        }
        [cell IndexPath:indexPath];
        cell.backgroundColor = [UIColor clearColor];
        return cell;
        
    }else{
        
        static NSString *CellIdentifier = @"DetailVCCell";
        
        ListenDetailCell *cell = [self.mCollectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        
        self.mCollectionView.allowsMultipleSelection = NO;
        NSError *error;
        leaque = [[LeaquesModel alloc] initWithDictionary:[mLeaqueArray objectAtIndex:indexPath.row] error:&error];
        
        
        NSString * string = [NSString stringWithFormat:@"%@ios_league_mark/%@",KserviceBaseIconURL,leaque.cover_image];
        NSString * iconString = [NSString stringWithFormat:@"%@ios_league_mark/%@",KserviceBaseIconURL,leaque.mark_image];
        NSURL *url = [NSURL URLWithString:string];
        NSURL *iconUrl = [NSURL URLWithString:iconString];
        [cell.mImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"noimage"]];
        cell.mLeaqueLable.text = leaque.name;
        [cell.mImageIconView sd_setImageWithURL:iconUrl];
        if ([leaque.broadcaster_count isEqualToString:@"0"]) {
            cell.broadcasterCountImageView.hidden = YES ;
            cell.broadcasterCountLabel.hidden = YES ;
        }else{
            cell.broadcasterCountLabel.text = leaque.broadcaster_count;
            cell.broadcasterCountImageView.hidden = NO ;
            cell.broadcasterCountLabel.hidden = NO ;
        }
        [cell IndexPath:indexPath];
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
   
    self.mSearchTextField.text = nil ;
    [self.mSearchTextField resignFirstResponder];
    NSString *index_path = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    NSError *error;
    leaque = [[LeaquesModel alloc] initWithDictionary:[mLeaqueArray objectAtIndex:indexPath.row] error:&error];
    [self performSegueWithIdentifier:@"ListenDetailSubView" sender:self];
    
    DM.sportsIdForTrophyVC = [NSString stringWithFormat:@"%@",leaque.sport_id];
    DM.leaqueIdForTrophyVC = [NSString stringWithFormat:@"%@",leaque.id];
    DM.leaqueNameForTrophyViewController = [NSString stringWithFormat:@"%@",leaque.name];
    DM.listenerPresentData =[[NSMutableDictionary alloc]init];
    [DM.listenerPresentData setValue:leaque.name forKey:@"leaqueName"];
    [DM.listenerPresentData setValue:leaque.mark_image forKey:@"icon"];
    DM.listenerPresentIcon = leaque.mark_image;

}



-(void)textFieldDidBeginEditing:(UITextField *)textField{
    self.mSearchTextField.backgroundColor = [UIColor whiteColor];
    [UIView animateWithDuration:0.5f animations:^{
        self.mCollectionView.frame = CGRectMake(13, 160, 294, 390);
        self.searchSelectionView.hidden = NO ;
    }];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"ListenDetailSubView"]) {
        ListenMatchVC *destinationVC = segue.destinationViewController;
        destinationVC.leaquesmodel = leaque;
    }
    else if ([segue.identifier isEqualToString:@"PunditDetail"]) {
        PunditDetailVC *PunditDetailvc = segue.destinationViewController;
        PunditDetailvc.dictRefff = dictReff;
        PunditDetailvc.mDataArrayyy = mDataArrayy;
        PunditDetailvc.mindex = mmindexpath;
        
    }
}



- (IBAction)BackButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//http://punditsports.com:81/pundit-ios/v1/Game/getSports
- (void)GetSportsList{
   // NSString *path=[NSString stringWithFormat:@"%@Game/getSportsname",KServiceBaseURL];
    
    NSString *path=[NSString stringWithFormat:@"%@Game/getSports",KServiceBaseURL];

    [DM GetRequest:path parameter:nil onCompletion:^(id dict) {
        
        
        NSError *errorJson=nil;
        NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:&errorJson];
        NSMutableArray *mDataArray = [[NSMutableArray alloc]init];
        [mDataArray addObjectsFromArray:[responseDict valueForKey:@"data"]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSDictionary *dict = [[NSMutableDictionary alloc]init];
            for (NSDictionary *MatchObj in mDataArray) {
                NSError *error;
                Sports = [[SportsModel alloc]initWithDictionary:MatchObj error:&error];
                NSString *string = [NSString stringWithFormat:@"%@",Sports.id];
                if ([string isEqualToString:DM.refreshRefStringForListener]) {
                    dict = MatchObj;
                }
            }
            Sports =[[SportsModel alloc]initWithDictionary:dict error:nil];
            mLeaqueArray = [[NSArray alloc]init];
            searchArray = [[NSArray alloc]init];
            mLeaqueArray = Sports.league;
            searchArray = Sports.league;
            [self.mCollectionView reloadData];
            [refreshControl endRefreshing];
        });
        
    } onError:^(NSError *Error) {
        [self GetSportsList];
    }];
    

    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self.mSearchTextField addTarget:self action:@selector(GoButtonPressed:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString * str  = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (_leagueButton.isSelected) {
    
    NSMutableArray *array = [[NSMutableArray alloc]init];
    array = [self searchFunction:str];
    
    if (array.count > 0)
    {
        mLeaqueArray = [[NSArray alloc]init];
        mLeaqueArray = array;
        [_mCollectionView reloadData];
    }else if(string.length > 0){
        mLeaqueArray = [[NSArray alloc]init];
        [_mCollectionView reloadData];
    }
    } else if (_userButton.isSelected){
        [self StartSearch:str];
    }else{
        [self StartTeamSearch:str];
    }
    return YES;
}

- (void)GoButtonPressed:(UITextField *)textField
{
     NSString *stringContent = self.mSearchTextField.text;
     if (_leagueButton.isSelected) {
    [self.mSearchTextField resignFirstResponder];
   
    NSMutableArray *array = [[NSMutableArray alloc]init];
    array = [self searchFunction:stringContent];
    
    if (array.count > 0)
    {
        mLeaqueArray = [[NSArray alloc]init];
        mLeaqueArray = array;
        [_mCollectionView reloadData];
    }
     }else if (_userButton.isSelected || _teamButton.isSelected){
         [self StartSearch:stringContent];
     }
    
}
- (IBAction)UserButtonSelection:(id)sender {
    searchRef = nil ;
    _teamButton.selected = NO;
    _leagueButton.selected = NO ;
    _userButton.selected = YES ;
    searchRef = [NSString stringWithFormat:@"%@",kUser];
    [self.mCollectionView setHidden:YES];
    [self.mTeamTableView setHidden:YES];
    [self.mTableView setHidden:NO];
}

- (IBAction)TeamButtonSelection:(id)sender {
    searchRef = nil ;
    _userButton.selected = NO;
    _leagueButton.selected = NO ;
    _teamButton.selected = YES ;
    searchRef = [NSString stringWithFormat:@"%@",kTeam];
    [self.mCollectionView setHidden:YES];
    [self.mTableView setHidden:YES];
    [self.mTeamTableView setHidden:NO];
}

- (IBAction)leagueButtonSelection:(id)sender {
    searchRef = nil ;
    _userButton.selected = NO;
    _teamButton.selected = NO ;
    _leagueButton.selected = YES ;
    searchRef = [NSString stringWithFormat:@"%@",kleague];
    [self.mTableView setHidden:YES];
    [self.mTeamTableView setHidden:YES];
    [self.mCollectionView setHidden:NO];
}



-(NSMutableArray *)searchFunction:(NSString *)searchingWord
{
    NSMutableArray *arrayRef = [[NSMutableArray alloc]init];
    
    for (int i=0; i < searchArray.count; i++)
    {
        NSMutableDictionary * dict =[[NSMutableDictionary alloc]init]; ;
        dict = [searchArray objectAtIndex:i];
        NSString *strng = [NSString stringWithFormat:@"%@",[dict valueForKey:@"name"]];
        NSString *searchString = searchingWord;
        NSComparisonResult searchResult = [strng compare:searchString options:(NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch) range:[strng rangeOfString:searchString options:(NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch)]];
        
        if (searchResult == NSOrderedSame)
        {
            [arrayRef addObject:dict];
        }
    }
    return arrayRef;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView == self.mTableView) {
        return searchDataArray.count;
    }else{
        return teamSearchDataArray.count ;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (tableView == self.mTableView) {
        /*
        NSMutableDictionary * dictRef = [[NSMutableDictionary alloc]init];
        dictRef = [searchDataArray objectAtIndex:indexPath.row];
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
         */
        mDataArrayy = [[NSMutableArray alloc]init];
        [mDataArrayy addObjectsFromArray:searchDataArray ];
        dictReff = [Helper formatJSONDict:[searchDataArray objectAtIndex:indexPath.row]];
        mmindexpath = indexPath;
        
        [self performSegueWithIdentifier: @"PunditDetail" sender: self];

        
    }
    else if (tableView == self.mTeamTableView)
    {
            DM.channelType = @"team";
            self.mliveBroadcastersArray = [[teamSearchDataArray objectAtIndex:indexPath.row]objectForKey:@"channel_info"];
            ListenMatchDetailVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ListenMatchDetailVC"];
            vc.mrliveBroadcastersArray = _mliveBroadcastersArray;
            vc.teamListenDetails = [teamSearchDataArray objectAtIndex:indexPath.row];
            DM.liveBroadcastersArray = [[teamSearchDataArray objectAtIndex:indexPath.row]objectForKey:@"channel_info"];
            NSLog(@"%@",DM.liveBroadcastersArray);
            [self.navigationController pushViewController:vc animated:YES];

    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableDictionary * dictRef = [[NSMutableDictionary alloc]init];
    
    if (tableView == self.mTableView) {
       // if (searchDataArray) {
        
            
      //  }
       
        dictRef = [searchDataArray objectAtIndex:indexPath.row];
        if (dictRef [@"channel_info"] ) {
            static NSString *CellIdentifier = @"ListenersTrophyTableViewCell";
            ListenersTrophyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            NSArray * xibReff = [[NSBundle mainBundle]loadNibNamed:@"ListenersTrophyTableViewCell" owner:self options:nil];
            if (cell == nil) {
                cell = [xibReff objectAtIndex:0];
            }
            
            cell.posLabel.hidden = YES;
            cell.clubNameLabel.frame = CGRectMake(25, 9, 255, 26);
            cell.clubNameLabel.textAlignment = NSTextAlignmentCenter ;
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
            return cell;
        }else{
            
            static NSString *CellIdentifier = @"TrophyViewTableViewCell";
            TrophyViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            NSArray * xibReff = [[NSBundle mainBundle]loadNibNamed:@"TrophyViewTableViewCell" owner:self options:nil];
            if (cell == nil) {
                cell = [xibReff objectAtIndex:0];
            }
            
            cell.posLabel.hidden = YES;
            cell.clubNameLabel.frame = CGRectMake(25, 9, 255, 26);
            cell.clubNameLabel.textAlignment = NSTextAlignmentCenter ;
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
    else {
        dictRef = [teamSearchDataArray objectAtIndex:indexPath.row];
        
        if (dictRef [@"channel_info"] ) {
            static NSString *CellIdentifier = @"ListenersTrophyTableViewCell";
            ListenersTrophyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            NSArray * xibReff = [[NSBundle mainBundle]loadNibNamed:@"ListenersTrophyTableViewCell" owner:self options:nil];
            if (cell == nil) {
                cell = [xibReff objectAtIndex:0];
            }
            
            cell.posLabel.hidden = YES;
            cell.clubNameLabel.frame = CGRectMake(25, 9, 255, 26);
            cell.clubNameLabel.textAlignment = NSTextAlignmentCenter ;
            cell.clubNameLabel.text = [NSString stringWithFormat:@"%@",[dictRef objectForKey:@"name"]];
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
            return cell;
        }else{
            
            static NSString *CellIdentifier = @"TrophyViewTableViewCell";
            TrophyViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            NSArray * xibReff = [[NSBundle mainBundle]loadNibNamed:@"TrophyViewTableViewCell" owner:self options:nil];
            if (cell == nil) {
                cell = [xibReff objectAtIndex:0];
            }
            
            cell.posLabel.hidden = YES;
            cell.clubNameLabel.frame = CGRectMake(25, 9, 255, 26);
            cell.clubNameLabel.textAlignment = NSTextAlignmentCenter ;
            cell.clubNameLabel.text = [NSString stringWithFormat:@"%@",[dictRef objectForKey:@"name"]];
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
            [cell setUserInteractionEnabled:NO];
            return cell;
        }
        
    }
}


- (IBAction)textFieldXButtonTap:(id)sender {
    [self SearchViewHideFunction];
}


-(void)SearchViewHideFunction{
    searchRef = nil ;
    self.mSearchTextField.text = nil ;
    [self.mSearchTextField resignFirstResponder];
    mLeaqueArray = [[NSMutableArray alloc]init];
    mLeaqueArray = searchArray;
    [_mCollectionView reloadData];
    _userButton.selected = NO;
    _teamButton.selected = NO ;
    _leagueButton.selected = YES ;
    searchRef = [NSString stringWithFormat:@"%@",kSport];
    [UIView animateWithDuration:0.2f animations:^{
        self.searchSelectionView.hidden = YES ;
        self.mTableView.hidden = YES ;
        self.mTeamTableView.hidden = YES ;
        self.mCollectionView.frame = CGRectMake(13, 136, 294, 412);
        [self.mCollectionView setHidden:NO];
    }];
}

-(void)StartSearch:(NSString *)searchingWord{
    if ([searchingWord isEqualToString:@""]) {
        return;
    }
    //NSString *path = [NSString stringWithFormat:@"%@Demosearch/league_search",KV2serviceBaseIconURL];
    NSString *path = [NSString stringWithFormat:@"%@IosSearch/league_search",KV2serviceBaseIconURL];

    NSMutableDictionary * parameters = [[NSMutableDictionary alloc]init];
    [parameters setValue:searchingWord forKey:@"search_text"];
    [parameters setValue:[[Helper mCurrentUser]objectForKey:@"id"] forKey:@"user_id"];
    [parameters setValue:searchRef forKey:@"search_type"];
    [parameters setValue:DM.refreshRefStringForListener forKey:@"sport_id"];
    [parameters setValue:@"1" forKey:@"live"];
    
    [DM PostRequest:path parameter:parameters onCompletion:^(id  _Nullable dict) {
        
        NSError *errorJson=nil;
        NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:&errorJson];
        searchDataArray = [[NSMutableArray alloc]init];
        searchDataArray = [responseDict objectForKey:@"data"];
        
        NSString *myString;
        
        if ([[responseDict objectForKey:@"data"]isEqual:[NSNull null]]) {
            return ;
        }else{
            myString = [NSString stringWithFormat:@"%@",[responseDict objectForKey:@"data"]];
        }
        
        if (![myString isEqualToString:@"No Data found"] ) {
            searchDataArray = [[NSMutableArray alloc]init];
            searchDataArray = [responseDict objectForKey:@"data"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.mTableView reloadData];
            });
        }
        else{
        }
        
    } onError:^(NSError * _Nullable Error) {
        
    }];
    
}



-(void)StartTeamSearch:(NSString *)searchingWord{
    
    if ([searchingWord isEqualToString:@""]) {
        return;
    }
    
    NSString *path = [NSString stringWithFormat:@"%@IosSearch/league_search",KV2serviceBaseIconURL];

    NSMutableDictionary * parameters = [[NSMutableDictionary alloc]init];
    [parameters setValue:searchingWord forKey:@"search_text"];
    [parameters setValue:[[Helper mCurrentUser]objectForKey:@"id"] forKey:@"user_id"];
    [parameters setValue:kTeam forKey:@"search_type"];
    [parameters setValue:DM.refreshRefStringForListener forKey:@"sport_id"];
    [parameters setValue:@"1" forKey:@"live"];
    [self.mTableView setUserInteractionEnabled:NO];

    [DM PostRequest:path parameter:parameters onCompletion:^(id  _Nullable dict) {
        NSError *errorJson=nil;
        NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:&errorJson];
        
        NSString *myString;
        
        if ([[responseDict objectForKey:@"data"]isEqual:[NSNull null]]) {
            return ;
        }else{
            myString = [NSString stringWithFormat:@"%@",[responseDict objectForKey:@"data"]];
        }
        
        if (![myString isEqualToString:@"No Data found"] ) {
            teamSearchDataArray = [[NSMutableArray alloc]init];
            teamSearchDataArray = [responseDict objectForKey:@"data"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.mTeamTableView reloadData];
                [self.mTableView setUserInteractionEnabled:YES];

            });
        }
        else{
            //[self.mTableView setUserInteractionEnabled:YES];
        }
    } onError:^(NSError * _Nullable Error) {
        
    }];
    
}
@end
