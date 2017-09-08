//
//  BroadcastVC.m
//  IPundit
//
//  Created by Deepak Kumar on 28/02/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import "ListenVC.h"
#import "ListenCell.h"
#import "UIImageView+WebCache.h"
#import "ListenDetailVC.h"
#import "ListenersTrophyTableViewCell.h"
#import "TrophyViewTableViewCell.h"
#import "ListenMatchDetailVC.h"
#import "PunditDetailVC.h"


@interface ListenVC (){
    NSMutableArray *mDataArray ;
    NSMutableArray *searchArray ;
    NSString * searchRef ;
    NSMutableArray *searchDataArray ;
    NSMutableArray *teamSearchDataArray ;
    NSString * message ;
    
    
    NSMutableArray *mDataArrayy;
    NSDictionary * dictReff;
    NSIndexPath *mmindexpath;
    
    
}



@end

@implementation ListenVC
@synthesize mSearchString,mleaqueArray,Sports,leaques,refreshControl;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchSelectionView.hidden = YES ;
    searchRef = nil ;

    if (IS_IPHONE4) {
        self.view.frame = CGRectMake(0, 0, 320, 480);
        self.mCollectionView.frame = CGRectMake(13, 136, 294, 344);
        self.mTableView.frame = CGRectMake(13, 160, 294, 408);
        self.mTeamTableView.frame = CGRectMake(13, 160, 294, 408);
    }else{
        self.mCollectionView.frame = CGRectMake(13, 136, 294, 432);
    }
    
    _userButton.selected = NO;
    _teamButton.selected = NO ;
    _sportButton.selected = YES ;
    searchRef = [NSString stringWithFormat:@"%@",kSport];

    self.backgroundImageView.image = DM.backgroundImage ;
    self.mTableView.hidden = YES ;
    self.mTeamTableView.hidden = YES ;
    [self GetSportsList];
    
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
    [self SearchViewHideFunction];
    [self GetSportsList];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.mCollectionView reloadData];
    searchDataArray = [[NSMutableArray alloc]init];
    [self.mTableView reloadData];
    IQKeyboardManager.sharedManager.enable = true;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [self GetSportsList];
    [[IQKeyboardManager sharedManager] setEnable:YES];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return mDataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ListenCell *cell = [self.mCollectionView dequeueReusableCellWithReuseIdentifier:@"CollectionVC" forIndexPath:indexPath];
    self.mCollectionView.allowsMultipleSelection = NO;
    NSError *error;
    NSLog(@"%@",mDataArray);
    Sports = [[SportsModel alloc] initWithDictionary:[mDataArray objectAtIndex:indexPath.row] error:&error];
    NSString * string = [NSString stringWithFormat:@"%@icons/%@",KserviceBaseIconURL,Sports.cover_image];
    NSString * iconString = [NSString stringWithFormat:@"%@icons/%@",KserviceBaseIconURL,Sports.avatar];
    NSURL *url = [NSURL URLWithString:string];
    NSURL *iconUrl = [NSURL URLWithString:iconString];
    [cell.mImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"noimage"]];
    [cell.mImageIconView sd_setImageWithURL:iconUrl];
    cell.mSportLable.text = Sports.name;
    cell.backgroundColor = [UIColor clearColor];
    if ([Sports.broadcaster_count isEqualToString:@"0"]) {
        cell.lableBackgroundImage.hidden = YES ;
        cell.listenersCount.hidden = YES ;
    }else{
        cell.listenersCount.text = Sports.broadcaster_count;
        cell.lableBackgroundImage.hidden = NO ;
        cell.listenersCount.hidden = NO ;
    }
    
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
   
    NSLog(@"before%@",Sports.id);
    NSLog(@"after%@",mDataArray);
    NSError *error;
    Sports = [[SportsModel alloc] initWithDictionary:[mDataArray objectAtIndex:indexPath.row] error:&error];
    NSLog(@"after%@",[mDataArray objectAtIndex:indexPath.row]);

    NSLog(@"after%@",Sports.id);
    DM.refreshRefStringForListener = Sports.id;

    [self performSegueWithIdentifier:@"ListenDetailView" sender:self];
    self.mSearchTextField.text = nil ;
    [self.mSearchTextField resignFirstResponder];
    NSString *index_path = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
   
    [self.mSearchTextField addTarget:self action:@selector(GoButtonPressed:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    NSString * str  = [textField.text stringByReplacingCharactersInRange:range withString:string];

    if (_sportButton.isSelected) {
    NSMutableArray *array = [[NSMutableArray alloc]init];
    array = [self searchFunction:str];
    
    if (array.count > 0)
    {
        mDataArray = [[NSMutableArray alloc]init];
        mDataArray = array;
        [_mCollectionView reloadData];
    }else if(string.length > 0){
        mDataArray = [[NSMutableArray alloc]init];
        [_mCollectionView reloadData];
    }
    }
    else if (_userButton.isSelected){
        [self StartSearch:str];
    }else{
        [self StartTeamSearch:str];
    }

    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (_sportButton.isSelected) {
    if (mDataArray.count < searchArray.count) {
        mDataArray = [[NSMutableArray alloc]init];
        mDataArray = searchArray;
    }
    }
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [UIView animateWithDuration:0.5f animations:^{
        self.mCollectionView.frame = CGRectMake(13, 160, 294, 408);
        self.searchSelectionView.hidden = NO ;
    }];

}
- (void)GoButtonPressed:(UITextField *)textField
{
    NSString *stringContent = self.mSearchTextField.text;
    [self.mSearchTextField resignFirstResponder];
    if (_sportButton.isSelected) {
    NSMutableArray *array = [[NSMutableArray alloc]init];
        array = [self searchFunction:stringContent];
    if (array.count > 0)
    {
        mDataArray = [[NSMutableArray alloc]init];
        mDataArray = array;
        [_mCollectionView reloadData];
    }
    }else if (_userButton.isSelected || _teamButton.isSelected){
        [self StartSearch:stringContent];
    }
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


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"ListenDetailView"]) {
        ListenDetailVC *destinationVC = segue.destinationViewController;
        destinationVC.mLeaqueArray = mleaqueArray;
    }
    else if ([segue.identifier isEqualToString:@"PunditDetailVi"]) {
        PunditDetailVC *PunditDetailvc = segue.destinationViewController;
        PunditDetailvc.dictRefff = dictReff;
        PunditDetailvc.mDataArrayyy = mDataArrayy;
        PunditDetailvc.mindex = mmindexpath;
    }
    
}


- (IBAction)BackButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)UserButtonSelection:(id)sender {
    searchRef = nil ;
    _teamButton.selected = NO;
    _sportButton.selected = NO ;
    _userButton.selected = YES ;
    searchRef = [NSString stringWithFormat:@"%@",kUser];
    [self.mCollectionView setHidden:YES];
    [self.mTeamTableView setHidden:YES];
    [self.mTableView setHidden:NO];
}

- (IBAction)TeamButtonSelection:(id)sender {
    searchRef = nil ;
    _userButton.selected = NO;
    _sportButton.selected = NO ;
    _teamButton.selected = YES ;
    searchRef = [NSString stringWithFormat:@"%@",kTeam];
    [self.mCollectionView setHidden:YES];
    [self.mTableView setHidden:YES];
    [self.mTeamTableView setHidden:NO];

}

- (IBAction)SportButtonSelection:(id)sender {
    searchRef = nil ;
    _userButton.selected = NO;
    _teamButton.selected = NO ;
    _sportButton.selected = YES ;
    searchRef = [NSString stringWithFormat:@"%@",kSport];
    [self.mTableView setHidden:YES];
    [self.mTeamTableView setHidden:YES];
    [self.mCollectionView setHidden:NO];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


- (void)GetSportsList{
   
   NSString *path=[NSString stringWithFormat:@"%@Game/getSports",KServiceBaseURL];
    [DM GetRequest:path parameter:nil onCompletion:^(id dict) {
        
        NSError *errorJson=nil;
        NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:&errorJson];
        mDataArray = [[NSMutableArray alloc]init];
        searchArray = [[NSMutableArray alloc]init];
        [mDataArray addObjectsFromArray:[responseDict valueForKey:@"data"]];
        [searchArray addObjectsFromArray:[responseDict valueForKey:@"data"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.mCollectionView reloadData];
            [self.refreshControl endRefreshing];
        });
    } onError:^(NSError *Error) {
        [self GetSportsList];
    }];
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

 /*
        
        [mDataArrayy addObjectsFromArray:[mDataArray objectAtIndex:indexPath.row]];
    
        PunditDetailVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"PunditDetailView"];
        vc.dictRefff = [Helper formatJSONDict:[mDataArray objectAtIndex:indexPath.row]]; ;
        vc.mDataArrayyy = mDataArray ;
        vc.mindex = indexPath ;
        [self.navigationController pushViewController:vc animated:YES];

        */
        mDataArrayy = [[NSMutableArray alloc]init];
        [mDataArrayy addObjectsFromArray:searchDataArray ];
        NSLog(@"%@",searchDataArray);
        NSLog(@"%@",mDataArrayy);
        dictReff = [Helper formatJSONDict:[searchDataArray objectAtIndex:indexPath.row]];
        mmindexpath = indexPath;
        
        [self performSegueWithIdentifier: @"PunditDetailVi" sender: self];
        
    }
    else if (tableView == self.mTeamTableView)
    {
        DM.channelType = @"team";
        ListenMatchDetailVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ListenMatchDetailVC"];
        vc.teamListenDetails = [teamSearchDataArray objectAtIndex:indexPath.row];
        DM.liveBroadcastersArray = [[teamSearchDataArray objectAtIndex:indexPath.row]objectForKey:@"channel_info"];
        NSLog(@"%@",DM.liveBroadcastersArray);
        [self.navigationController pushViewController:vc animated:YES];
    }
}





- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableDictionary * dictRef = [[NSMutableDictionary alloc]init];
    
    if (tableView == self.mTableView) {
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
            //[cell setUserInteractionEnabled:NO];
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
    mDataArray = [[NSMutableArray alloc]init];
    mDataArray = searchArray;
    [_mCollectionView reloadData];
    _userButton.selected = NO;
    _teamButton.selected = NO ;
    _sportButton.selected = YES ;
    searchRef = [NSString stringWithFormat:@"%@",kSport];
    [UIView animateWithDuration:0.2f animations:^{
        self.searchSelectionView.hidden = YES ;
        self.mTableView.hidden = YES ;
        self.mTeamTableView.hidden = YES ;
        self.mCollectionView.frame = CGRectMake(13, 136, 294, 432);
        [self.mCollectionView setHidden:NO];
    }];
}

-(void)StartSearch:(NSString *)searchingWord{
    
    if ([searchingWord isEqualToString:@""]) {
        return;
    }
    
    NSString *path = [NSString stringWithFormat:@"%@IosSearch/sport_search",KV2serviceBaseIconURL];
    NSMutableDictionary * parameters = [[NSMutableDictionary alloc]init];
    [parameters setValue:searchingWord forKey:@"search_text"];
    [parameters setValue:kUser forKey:@"search_type"];
    [parameters setValue:[[Helper mCurrentUser]objectForKey:@"id"] forKey:@"user_id"];
    [parameters setValue:@"1" forKey:@"live"];
    [self.mTableView setUserInteractionEnabled:NO];
    self.mHideView.hidden = NO;
    
    
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
            searchDataArray = [[NSMutableArray alloc]init];
            searchDataArray = [responseDict objectForKey:@"data"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.mTableView reloadData];
                [self.mTableView setUserInteractionEnabled:YES];
                self.mHideView.hidden = YES;


            });
        }
        else{
             self.mHideView.hidden = YES;
        }
        
    } onError:^(NSError * _Nullable Error) {
        
    }];

}

-(void)StartTeamSearch:(NSString *)searchingWord{
    
    if ([searchingWord isEqualToString:@""]) {
        return;
    }
    
    NSString *path = [NSString stringWithFormat:@"%@IosSearch/sport_search",KV2serviceBaseIconURL];
    NSMutableDictionary * parameters = [[NSMutableDictionary alloc]init];
    [parameters setValue:searchingWord forKey:@"search_text"];
    [parameters setValue:kTeam forKey:@"search_type"];
    [parameters setValue:[[Helper mCurrentUser]objectForKey:@"id"] forKey:@"user_id"];
    [parameters setValue:@"1" forKey:@"live"];
    
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
            });
        }
    } onError:^(NSError * _Nullable Error) {
        
    }];
    
}

@end
