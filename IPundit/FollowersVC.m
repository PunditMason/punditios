//
//  FollowersVC.m
//  IPundit
//
//  Created by Manoj Gadamsetty on 01/11/17.
//  Copyright © 2017 James Mason. All rights reserved.
//

#import "FollowersVC.h"
#import "PoadcastVC.h"
#import "UIImageView+WebCache.h"

@interface FollowersVC (){
    NSMutableArray *FollowersArray;

}

@end

@implementation FollowersVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    FollowersArray = [[NSMutableArray alloc]init];
    self.backgroundImageView.image = DM.backgroundImage ;

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    
    NSIndexPath *tableSelection = [self.mVideoHighlightTableView indexPathForSelectedRow];
    [self.mVideoHighlightTableView deselectRowAtIndexPath:tableSelection animated:NO];
    self.mVideoHighlightTableView.separatorColor = [UIColor clearColor];
    
    
    if ([self.Followstringg isEqualToString:@"Following"]) {
        self.mTitalLable.text = [@"Following" uppercaseString];
        [self GetFollowingList];
    }
    else if ([self.Followstringg isEqualToString:@"Followers"]) {
        
        self.mTitalLable.text = [@"Followers" uppercaseString];

        [self GetFollowersList];
        
    }
    
    

    
    
    
}


-(void)GetFollowingList{
    
    [Helper showLoaderVProgressHUD];
    NSString *string = [NSString stringWithFormat:@"http://54.154.252.47/pundit-ios/v1/Game/getFollowingList/%@",[[Helper mCurrentUser]objectForKey:@"id"]];
    [DM GetRequest:string parameter:nil onCompletion:^(id  _Nullable dict) {
        NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
        NSLog(@"ResponseDict %@",responseDict);
        
        if ([responseDict objectForKey:@"following"]) {
            [FollowersArray removeAllObjects];
            [FollowersArray addObjectsFromArray:[responseDict objectForKey:@"following"]];
            if (FollowersArray.count > 0) {
                
                if ([self.Followstringg isEqualToString:@"Following"]) {
                    self.mNoFollowersLable.text = [@"No Followings" uppercaseString];
                }
                else if ([self.Followstringg isEqualToString:@"Followers"]) {
                    
                    self.mNoFollowersLable.text = [@"NO Followers" uppercaseString];
                }
                self.mNoFollowersLable.hidden = true;
                self.mVideoHighlightTableView.hidden = false;
                
    
            }
            else{
                if ([self.Followstringg isEqualToString:@"Following"]) {
                    self.mNoFollowersLable.text = [@"No Followings" uppercaseString];
                }
                else if ([self.Followstringg isEqualToString:@"Followers"]) {
                    
                    self.mNoFollowersLable.text = [@"NO Followers" uppercaseString];
                }
                
                self.mNoFollowersLable.hidden = false;
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


-(void)GetFollowersList{
    
    [Helper showLoaderVProgressHUD];
    NSString *string = [NSString stringWithFormat:@"http://54.154.252.47/pundit-ios/v1/Game/getFollowerList/%@",[[Helper mCurrentUser]objectForKey:@"id"]];
    [DM GetRequest:string parameter:nil onCompletion:^(id  _Nullable dict) {
        NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
        NSLog(@"ResponseDict %@",responseDict);
        
        if ([responseDict objectForKey:@"follwers"]) {
            [FollowersArray removeAllObjects];
            [FollowersArray addObjectsFromArray:[responseDict objectForKey:@"follwers"]];
            
            if (FollowersArray.count > 0) {
                if ([self.Followstringg isEqualToString:@"Following"]) {
                    self.mNoFollowersLable.text = [@"No Followings" uppercaseString];
                }
                else if ([self.Followstringg isEqualToString:@"Followers"]) {
                    
                    self.mNoFollowersLable.text = [@"NO Followers" uppercaseString];
                }
                self.mNoFollowersLable.hidden = true;
                self.mVideoHighlightTableView.hidden = false;
                
            }
            else{
                if ([self.Followstringg isEqualToString:@"Following"]) {
                    self.mNoFollowersLable.text = [@"No Followings" uppercaseString];
                }
                else if ([self.Followstringg isEqualToString:@"Followers"]) {
                    
                    self.mNoFollowersLable.text = [@"NO Followers" uppercaseString];
                }
                
                self.mNoFollowersLable.hidden = false;
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
    return FollowersArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"FollowersViewCeell";
    FollowersViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[FollowersViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
    
    UIView *bgColorView = [[UIView alloc] init];
    [bgColorView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3]];
    
    [cell setSelectedBackgroundView:bgColorView];
    
    cell.backgroundColor = [UIColor clearColor];
    
    NSDictionary *dct = [Helper formatJSONDict:[FollowersArray objectAtIndex:indexPath.row]];
    
    //mProfileImage

    cell.mNameLable.text = [dct valueForKey:@"first_name"];

    NSString * string = [NSString stringWithFormat:@"%@%@",KServiceBaseProfileImageURL,[dct valueForKey:@"avatar"]];
    NSURL *url = [NSURL URLWithString:string];
    [cell.mProfileImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"No-following-min"]];
    
    
    NSString *stringRef = [NSString stringWithFormat:@"%@",[dct objectForKey:@"follow"]];
    
    if ([stringRef isEqualToString:@"1"]) {
        [cell.mFollowButton setTitle:@"UNFOLLOW" forState:UIControlStateNormal];
    }
    else{
        [cell.mFollowButton setTitle:@"FOLLOW ME" forState:UIControlStateNormal];
    }

    
    cell.mFollowButton.tag = indexPath.row;
    
    [cell.mFollowButton addTarget:self action:@selector(FollowButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.mPodcastButton.tag = indexPath.row;
    [cell.mPodcastButton addTarget:self action:@selector(PodcastButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
    
}


-(void)PodcastButtonPressed:(UIButton*)sender{
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.mVideoHighlightTableView];
    NSIndexPath *indexPath = [self.mVideoHighlightTableView indexPathForRowAtPoint:buttonPosition];
    NSLog(@"PodcastButtonPressed");

    [self performSegueWithIdentifier:@"userPoadcastVieww" sender:self];
    
    
}

-(void)FollowButtonPressed:(UIButton*)sender{
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.mVideoHighlightTableView];
    NSIndexPath *indexPath = [self.mVideoHighlightTableView indexPathForRowAtPoint:buttonPosition];
    NSDictionary *dct = [Helper formatJSONDict:[FollowersArray objectAtIndex:indexPath.row]];

    NSLog(@"FollowButtonPressed");

    
    NSString *string = [NSString stringWithFormat:@"%@game/followlist/%@/%@",KServiceBaseURL,[[Helper mCurrentUser]objectForKey:@"id"],[dct objectForKey:@"id"]];
    [Helper showLoaderVProgressHUD];        [DM GetRequest:string parameter:nil onCompletion:^(id  _Nullable dict) {            NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];                        NSMutableDictionary *data = [[NSMutableDictionary alloc]init];            data = [responseDict objectForKey:@"data"];
        
        
        if ([self.Followstringg isEqualToString:@"Following"]) {
            self.mTitalLable.text = [@"Following" uppercaseString];
            [self GetFollowingList];
        }
        else if ([self.Followstringg isEqualToString:@"Followers"]) {
            
            self.mTitalLable.text = [@"Followers" uppercaseString];
            
            [self GetFollowersList];
            
        }
        
        
        [Helper hideLoaderSVProgressHUD];
        [DM getProfile];
    } onError:^(NSError * _Nullable Error) {
        NSLog(@"Following Functionality Error %@",Error);
        [Helper hideLoaderSVProgressHUD];
    }];
    
    
   

    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;{
    
    NSLog(@"Selected View index=%ld",(long)indexPath.row);
    [self.mVideoHighlightTableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
    
}

- (IBAction)closePopup:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
    
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    

    if ([segue.identifier isEqualToString:@"userPoadcastVieww"]) {
        PoadcastVC *destinationVC = segue.destinationViewController;
        destinationVC.selectedUser = [[Helper mCurrentUser]objectForKey:@"id"];
        
    }
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

@end
