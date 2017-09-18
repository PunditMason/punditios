//
//  DetailVC.m
//  IPundit
//
//  Created by Deepak Kumar on 02/03/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//
#import <Crashlytics/Crashlytics.h>
#import "DetailVC.h"
#import "DetailVCCell.h"
#import "BroadcastMatchVC.h"
#import "MainDetailVCCell.h"


@interface DetailVC (){
    NSArray *searchArray ;

}



@end

@implementation DetailVC
@synthesize mSearchString,mLeaqueArray,leaque,refreshControl,Sports;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self GetSportsList];
    

    self.backgroundImageView.image = DM.backgroundImage ;
    
    if (IS_IPHONE4) {
        self.view.frame = CGRectMake(0, 0, 320, 480);
        self.mCollectionView.frame = CGRectMake(13, 136, 294, 324);
        self.breakingNewsView.frame = CGRectMake(0, 462, 320, 18);
    }
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

    
}
-(void)refershControlAction{
    
    [self GetSportsList];
    
   // [[Crashlytics sharedInstance] crash];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    IQKeyboardManager.sharedManager.enable = true;
    self.breakingNewsLabel.text = DM.breakingNewsString ;
    
    
    [DM marqueLabel:self.breakingNewsLabel];
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
         height = 195;
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
    if (indexPath.row == 0)
    {
        
        MainDetailVCCell * cell = [self.mCollectionView dequeueReusableCellWithReuseIdentifier:@"MainDetailVCCell" forIndexPath:indexPath];
        
        
        self.mCollectionView.allowsMultipleSelection = NO;
        
        NSError *error;
        leaque = [[LeaquesModel alloc] initWithDictionary:[mLeaqueArray objectAtIndex:indexPath.row] error:&error];
        
        NSString * string = [NSString stringWithFormat:@"%@ios_league_mark/%@",KserviceBaseIconURL,leaque.cover_image];
        NSString * iconString = [NSString stringWithFormat:@"%@ios_league_mark/%@",KserviceBaseIconURL,leaque.mark_image];
        NSURL *url = [NSURL URLWithString:string];
        NSURL *iconUrl = [NSURL URLWithString:iconString];
        [cell.mImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"noimage"]];
        [cell.mLeaqueIcon sd_setImageWithURL:iconUrl];
        cell.mLeaqueLable.text = leaque.name;
        
        [cell IndexPath:indexPath];
        cell.backgroundColor = [UIColor clearColor];
        return cell;
        
    }else{
        
        
        DetailVCCell *cell = [self.mCollectionView dequeueReusableCellWithReuseIdentifier:@"DetailVCCell" forIndexPath:indexPath];
        self.mCollectionView.allowsMultipleSelection = NO;
        
        NSError *error;
        leaque = [[LeaquesModel alloc] initWithDictionary:[mLeaqueArray objectAtIndex:indexPath.row] error:&error];
        
        NSString * string = [NSString stringWithFormat:@"%@ios_league_mark/%@",KserviceBaseIconURL,leaque.cover_image];
        NSString * iconString = [NSString stringWithFormat:@"%@ios_league_mark/%@",KserviceBaseIconURL,leaque.mark_image];
        NSURL *url = [NSURL URLWithString:string];
        NSURL *iconUrl = [NSURL URLWithString:iconString];
        [cell.mImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"noimage"]];
        [cell.mLeaqueIcon sd_setImageWithURL:iconUrl];
        cell.mLeaqueLable.text = leaque.name;
        
        [cell IndexPath:indexPath];
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }

}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    self.mSearchTextField.text = nil ;
    [self.mSearchTextField resignFirstResponder];
    NSError *error;
    leaque = [[LeaquesModel alloc] initWithDictionary:[mLeaqueArray objectAtIndex:indexPath.row] error:&error];
    DM.sportsIdForTrophyVC = [NSString stringWithFormat:@"%@",leaque.sport_id];
    DM.leaqueIdForTrophyVC = [NSString stringWithFormat:@"%@",leaque.id];
    DM.leaqueNameForTrophyViewController = [NSString stringWithFormat:@"%@",leaque.name];
    DM.broadCastPresentData =[[NSMutableDictionary alloc]init];
    [DM.broadCastPresentData setValue:leaque.sport_id forKey:@"sportId"];
    [DM.broadCastPresentData setValue:leaque.name forKey:@"leaqueName"];
    [DM.broadCastPresentData setValue:leaque.mark_image forKey:@"icon"];
    [DM.broadCastPresentData setValue:leaque.id forKey:@"leaqueId"];
    
    [self performSegueWithIdentifier:@"DetailSubView" sender:self];
}





- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"DetailSubView"]) {
        BroadcastMatchVC *destinationVC = segue.destinationViewController;
        destinationVC.leaquesmodel = leaque;
    }
}



- (IBAction)BackButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)GetSportsList{
  //  NSString *path=[NSString stringWithFormat:@"%@Game/getSportsname",KServiceBaseURL];
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
                if ([string isEqualToString:DM.refreshRefStringForBroadCast]) {
                    dict = MatchObj;
                }
            }
        Sports =[[SportsModel alloc]initWithDictionary:dict error:nil];
        mLeaqueArray = [[NSArray alloc]init];
        searchArray = [[NSArray alloc]init];
        mLeaqueArray = Sports.league;
        searchArray = Sports.league;
        [self.mCollectionView reloadData];
        [self.refreshControl endRefreshing];
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
    
    return YES;
}

- (void)GoButtonPressed:(UITextField *)textField
{
    [self.mSearchTextField resignFirstResponder];
    NSString *stringContent = self.mSearchTextField.text;
    NSMutableArray *array = [[NSMutableArray alloc]init];
    array = [self searchFunction:stringContent];
    
    if (array.count > 0)
    {
        mLeaqueArray = [[NSArray alloc]init];
        mLeaqueArray = array;
        [_mCollectionView reloadData];
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

- (IBAction)textFieldXButtonTap:(id)sender {
    [self.mSearchTextField resignFirstResponder];
    self.mSearchTextField.text = nil;
    mLeaqueArray = [[NSArray alloc]init];
    mLeaqueArray = searchArray;
    [_mCollectionView reloadData];
    
}

@end
