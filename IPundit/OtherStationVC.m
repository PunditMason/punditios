//
//  LatestPodcastsVC.m
//  IPundit
//
//  Created by Gaurav  Verma on 23/04/18.
//  Copyright © 2018 James Mason. All rights reserved.
//

#import "OtherStationVC.h"

@interface OtherStationVC (){
    NSMutableArray * mStationsArray;
}

@end

@implementation OtherStationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    mStationsArray = [[NSMutableArray alloc] init];
    self.mBackgroudImageView.image = DM.backgroundImage ;
    [self GetOtherLeagueStation:self.leaqueID];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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




- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return mStationsArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LatestPodcastsCell *cell = [self.mCollectionView dequeueReusableCellWithReuseIdentifier:@"latestpodcastscell" forIndexPath:indexPath];
    self.mCollectionView.allowsMultipleSelection = NO;
    
    NSDictionary *dct = [mStationsArray objectAtIndex:indexPath.row];
    
    cell.mPodcastNameLable.text = [dct valueForKey:@"title"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[dct valueForKey:@"image"]]];
    [cell.mImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"noimage"]];

    

    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *index_path = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    
    NSDictionary *dct = [mStationsArray objectAtIndex:indexPath.row];
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:[NSString stringWithFormat:@"%@",[dct valueForKey:@"url"]]]];
    
}





-(void)GetOtherLeagueStation:(NSString *)leagueId {
    NSMutableDictionary *Parameters = [NSMutableDictionary new];
    [Parameters setObject:leagueId forKey:@"league_id"];
    
    [Helper showLoaderVProgressHUD];
    
    NSString *string = [NSString stringWithFormat:@"%@app/getOtherLeagueStation/",KServiceBaseURL];
    [DM PostRequest:string parameter:Parameters onCompletion:^(id  _Nullable dict) {
        NSDictionary* responseDict = [NSJSONSerialization  JSONObjectWithData:dict options:kNilOptions error:nil];
        NSLog(@"ResponseDict %@",responseDict);
        
        [mStationsArray removeAllObjects];
        [mStationsArray addObjectsFromArray:[responseDict valueForKey:@"leagueStation"]];
        [self.mCollectionView reloadData];
        [Helper hideLoaderSVProgressHUD];
        
    } onError:^(NSError * _Nullable Error) {
        
        [Helper hideLoaderSVProgressHUD];
        NSLog(@"%@",Error);
        NSString *ErrorString = [NSString stringWithFormat:@"%@",Error];
        [Helper ISAlertTypeError:@"Error!!" andMessage:ErrorString];
        
    }];
}




@end
