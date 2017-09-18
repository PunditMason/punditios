//
//  BroadcastVC.m
//  IPundit
//
//  Created by Deepak Kumar on 28/02/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import "BroadcastVC.h"
#import "DetailCell.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Additions.h"
#import "DetailVC.h"
#import <Crashlytics/Crashlytics.h>

@interface BroadcastVC (){
    NSMutableArray *mDataArray ;
    NSMutableArray *searchArray ;
}

@end

@implementation BroadcastVC
@synthesize mSearchString,mleaqueArray,Sports,refreshControl;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.mXButton.hidden = YES ;
    if (IS_IPHONE4) {
        self.view.frame = CGRectMake(0, 0, 320, 480);
        self.mCollectionView.frame = CGRectMake(13, 136, 294, 344);
    }
    self.backgroundImageView.image = DM.backgroundImage ;
    [self GetSportsList];
    refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.tintColor = [UIColor grayColor];
    [refreshControl addTarget:self action:@selector(refershControlAction) forControlEvents:UIControlEventValueChanged];
    [refreshControl setTintColor:[UIColor whiteColor]];
    [refreshControl tintColorDidChange];
    [self.mCollectionView addSubview:refreshControl];
     self.mCollectionView.alwaysBounceVertical = YES;
    
    

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    IQKeyboardManager.sharedManager.enable = true;
    [self.mCollectionView reloadData];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [self GetSportsList];
    [[IQKeyboardManager sharedManager] setEnable:YES];
}

-(void)refershControlAction{
    
    [self GetSportsList];
    

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return mDataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DetailCell *cell = [self.mCollectionView dequeueReusableCellWithReuseIdentifier:@"CollectionVC" forIndexPath:indexPath];
    self.mCollectionView.allowsMultipleSelection = NO;
    
    NSError *error;
    Sports = [[SportsModel alloc] initWithDictionary:[mDataArray objectAtIndex:indexPath.row] error:&error];
    NSString * string = [NSString stringWithFormat:@"%@ios_icons/%@",KserviceBaseIconURL,Sports.cover_image];
    NSString * iconString = [NSString stringWithFormat:@"%@ios_icons/%@",KserviceBaseIconURL,Sports.avatar];
    NSURL *url = [NSURL URLWithString:string];
    NSURL *iconUrl = [NSURL URLWithString:iconString];
    [cell.mImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"noimage"]];
    [cell.iconImageView sd_setImageWithURL:iconUrl];
    cell.mSportLable.text = Sports.name;
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    self.mSearchTextField.text = nil ;
    [self.mSearchTextField resignFirstResponder];
    NSString *index_path = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    NSError *error;
    Sports = [[SportsModel alloc] initWithDictionary:[mDataArray objectAtIndex:indexPath.row] error:&error];
    DM.refreshRefStringForBroadCast = Sports.id;
    [self performSegueWithIdentifier:@"DetailView" sender:self];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (self.mSearchTextField.text.length == 0) {
        mDataArray = [[NSMutableArray alloc]init];
        mDataArray = searchArray;
        [_mCollectionView reloadData];
    }else{
    [self.mSearchTextField addTarget:self action:@selector(GoButtonPressed:) forControlEvents:UIControlEventEditingDidEndOnExit];
    }
    return YES;
}
-(BOOL)textFieldShouldClear:(UITextField *)textField
{
    textField.text = nil;
    [textField resignFirstResponder];
    mDataArray = [[NSMutableArray alloc]init];
    mDataArray = searchArray;
    [_mCollectionView reloadData];
    
    return NO;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //self.mXButton.hidden = NO ;
    NSString * str  = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSMutableArray *array = [[NSMutableArray alloc]init];
    array = [self searchFunction:str];
    
    if (array.count > 0)
    {
        mDataArray = [[NSMutableArray alloc]init];
        mDataArray = array;
        [_mCollectionView reloadData];
    }else if(string.length > 0){
        mDataArray = [[NSMutableArray alloc]init];
        //mDataArray = array;
        [_mCollectionView reloadData];
    }
    
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    //self.mXButton.hidden = NO ;
    if (mDataArray.count < searchArray.count) {
        mDataArray = [[NSMutableArray alloc]init];
        mDataArray = searchArray;
    }
}

- (void)GoButtonPressed:(UITextField *)textField
{
    
    [self.mSearchTextField resignFirstResponder];
    NSString *stringContent = self.mSearchTextField.text;
    NSMutableArray *array = [[NSMutableArray alloc]init];
    array = [self searchFunction:stringContent];
    
    if (array.count > 0)
    {
        mDataArray = [[NSMutableArray alloc]init];
        mDataArray = array;
        //self.mXButton.hidden = YES ;
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


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"DetailView"]) {
        DetailVC *destinationVC = segue.destinationViewController;
        destinationVC.mLeaqueArray = mleaqueArray;
    }
}


- (IBAction)BackButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)xButtonTap:(id)sender {
    [self.mSearchTextField resignFirstResponder];
    self.mSearchTextField.text = nil;
    mDataArray = [[NSMutableArray alloc]init];
    mDataArray = searchArray;
    [_mCollectionView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)GetSportsList{
   // NSString *path=[NSString stringWithFormat:@"%@Game/getSportsname",KServiceBaseURL];
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


@end
