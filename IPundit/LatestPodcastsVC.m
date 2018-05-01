//
//  LatestPodcastsVC.m
//  IPundit
//
//  Created by Gaurav  Verma on 23/04/18.
//  Copyright © 2018 James Mason. All rights reserved.
//

#import "LatestPodcastsVC.h"

@interface LatestPodcastsVC (){
    NSMutableArray *mLatestPodcastArray;
}

@end

@implementation LatestPodcastsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mBackgroudImageView.image = DM.backgroundImage ;
    mLatestPodcastArray = [[NSMutableArray alloc]init];

    [self GetOtherLeagueStation];
    
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
    
    return mLatestPodcastArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LatestPodcastsCell *cell = [self.mCollectionView dequeueReusableCellWithReuseIdentifier:@"latestpodcastscell" forIndexPath:indexPath];
    self.mCollectionView.allowsMultipleSelection = NO;
    
    NSDictionary *dct = [mLatestPodcastArray objectAtIndex:indexPath.row];
    cell.mPodcastNameLable.text = [dct valueForKey:@"name"];
    cell.mUserNameLable.text = [dct valueForKey:@"broadcaster_name"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[dct valueForKey:@"league_icon"]]];
    [cell.mImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"noimage"]];
    
    
    
    NSURL *url1 = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[dct valueForKey:@"team1_icone"]]];
    [cell.mTeam1ImageView sd_setImageWithURL:url1 placeholderImage:[UIImage imageNamed:@""]];
    NSURL *url2 = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[dct valueForKey:@"team2_icone"]]];
    [cell.mTeam2ImageView sd_setImageWithURL:url2 placeholderImage:[UIImage imageNamed:@""]];
    
    
    

    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *index_path = [NSString stringWithFormat:@"%ld",(long)indexPath.row];

    NSDictionary *dct = [mLatestPodcastArray objectAtIndex:indexPath.row];

    PoadcastDetailVC *destinationVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PoadcastDetailview"];
    
    destinationVC.ChannelArray = [dct valueForKey:@"stream"];
    destinationVC.LIString =[dct valueForKey:@"league_icon"];
    
    [self.navigationController pushViewController:destinationVC animated:YES];
    
}



-(void)GetOtherLeagueStation {
   
    [Helper showLoaderVProgressHUD];
    
    NSString *string = [NSString stringWithFormat:@"%@game/getChannelList/",KServiceBaseURL];
    [DM GetRequest:string parameter:nil onCompletion:^(id  _Nullable dict) {
        NSDictionary* responseDict = [NSJSONSerialization  JSONObjectWithData:dict options:kNilOptions error:nil];
        NSLog(@"ResponseDict %@",responseDict);
        
        [mLatestPodcastArray removeAllObjects];
        [mLatestPodcastArray addObjectsFromArray:[responseDict valueForKey:@"channel"]];
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
