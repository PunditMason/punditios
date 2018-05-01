//
//  PoadcastVC.m
//  IPundit
//
//  Created by Gaurav Verma on 13/09/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import "ManageLeaqueVC.h"
#import "ManageLeaqueDetailVC.h"

@interface ManageLeaqueVC (){
    NSMutableArray *MatchArray;
    NSMutableArray *SelectedMatchArray;
    NSString *TeamBNamestring;
    NSString *LeagueIconString;
    NSMutableArray *SelectedLeaqueArray;

    
}

@end

@implementation ManageLeaqueVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MatchArray =  [[NSMutableArray alloc] init];
    SelectedMatchArray = [[NSMutableArray alloc] init];
    SelectedLeaqueArray = [[NSMutableArray alloc] init];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)BackButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}



-(void)GetChannelt{

    [Helper showLoaderVProgressHUD];
    self.mNoPoadcastAvilable.hidden = YES;
    NSString *string = [NSString stringWithFormat:@"%@game/getUserleaguesList/%@/",KServiceBaseURL,self.selectedUser];
    [DM GetRequest:string parameter:nil onCompletion:^(id  _Nullable dict) {
        NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
        NSLog(@"ResponseDict %@",responseDict);
        
        if ([[responseDict objectForKey:@"data"]isEqual:[NSNull null]]) {
            self.mNoPoadcastAvilable.hidden = NO;
            [Helper hideLoaderSVProgressHUD];
            return ;
        }else{
            [MatchArray removeAllObjects];
            [MatchArray addObjectsFromArray:[responseDict objectForKey:@"data"]];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [SelectedLeaqueArray removeAllObjects];
            for (NSDictionary *dctobj in [responseDict objectForKey:@"data"]) {
                
                for (NSDictionary *dctobj1 in [dctobj valueForKey:@"league"]) {
                    
                    if ([[dctobj1 objectForKey:@"selected_league"] integerValue] == 1) {
                        [SelectedLeaqueArray addObject:dctobj1];
                    }
                    
                    
                }
                
                
            }
            
            
            [self.mPoadcastTableView reloadData];
        });
        

        [self.mPoadcastTableView reloadData];
        [Helper hideLoaderSVProgressHUD];

    } onError:^(NSError * _Nullable Error) {
        [Helper hideLoaderSVProgressHUD];
        NSLog(@"%@",Error);
        NSString *ErrorString = [NSString stringWithFormat:@"%@",Error];
        [Helper ISAlertTypeError:ErrorString andMessage:kNOInternet];
    }];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];

    [self GetChannelt];

    NSIndexPath *tableSelection = [self.mPoadcastTableView indexPathForSelectedRow];
    [self.mPoadcastTableView deselectRowAtIndexPath:tableSelection animated:NO];
    self.mPoadcastTableView.separatorColor = [UIColor clearColor];
    
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"%@ viewWillDisappear", self);
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return MatchArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    
    return [[[MatchArray objectAtIndex:section]valueForKey:@"league"]count ];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"ManageLeaquecell";
    ManageLeaqueCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil) {
        cell = [[ManageLeaqueCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
   
    }
    UIView *bgColorView = [[UIView alloc] init];
    [bgColorView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3]];
    [cell setSelectedBackgroundView:bgColorView];
    
   // NSString *strobj
    NSDictionary *dct = [[[MatchArray objectAtIndex:indexPath.section]valueForKey:@"league"] objectAtIndex:indexPath.row];
  //  NSDictionary *dct1 = [[MatchArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    cell.mMatchName.text = [dct objectForKey:@"name"];
    
    if ([[dct objectForKey:@"selected_league"] integerValue] == 1) {
        cell.mSelectionImage.image = [UIImage imageNamed:@"checked"];

    }else{
        cell.mSelectionImage.image = [UIImage imageNamed:@"check-box"];
       // [SelectedLeaqueArray removeObject:dct];

    }
    
    //
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;{
    
    [self.mPoadcastTableView deselectRowAtIndexPath:indexPath animated:NO];
   
    
    NSDictionary *dct = [[[MatchArray objectAtIndex:indexPath.section]valueForKey:@"league"] objectAtIndex:indexPath.row];

    if ([SelectedLeaqueArray containsObject:dct]) {
        [SelectedLeaqueArray removeObject:dct];
    } else {
         [SelectedLeaqueArray addObject:dct];
    }


    
    NSString *Selected_Id ;
    Selected_Id = @"";
    for (NSDictionary *dctObj in SelectedLeaqueArray) {
        Selected_Id = [NSString stringWithFormat:@"%@,%@",Selected_Id,[dctObj objectForKey:@"id"]];
    }
    
   Selected_Id = [Selected_Id substringFromIndex:1];
    
    NSLog(@"%@",Selected_Id);
    
    [self UpdateManageLeaque:Selected_Id anduserId:self.selectedUser];
    
}




-(void)UpdateManageLeaque:(NSString *)leaguesId anduserId:(NSString *)userId{
    NSMutableDictionary *Parameters = [NSMutableDictionary new];
    [Parameters setObject:leaguesId forKey:@"leagues_ids"];
    [Parameters setObject:userId forKey:@"user_id"];
  //  [Helper showLoaderVProgressHUD];
    
    NSString *string = [NSString stringWithFormat:@"%@app/updateUserleaguesList/",KServiceBaseURL];
    [DM PostRequest:string parameter:Parameters onCompletion:^(id  _Nullable dict) {
        NSDictionary* responseDict = [NSJSONSerialization  JSONObjectWithData:dict options:kNilOptions error:nil];
        NSLog(@"ResponseDict %@",responseDict);
        
        [self GetChannelt];
      //  [Helper hideLoaderSVProgressHUD];
    } onError:^(NSError * _Nullable Error) {
        [Helper hideLoaderSVProgressHUD];
        NSLog(@"%@",Error);
        NSString *ErrorString = [NSString stringWithFormat:@"%@",Error];
        [Helper ISAlertTypeError:@"Error!!" andMessage:ErrorString];
    }];
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ManageLeaqueDView"]) {
        ManageLeaqueDetailVC *destinationVC = segue.destinationViewController;
          destinationVC.ChannelArray = SelectedMatchArray;
       //  destinationVC.TMName = TeamBNamestring;
        destinationVC.LIString =LeagueIconString;
    }
}


 - (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
 {
 NSString *sectionName;
 sectionName = [NSString stringWithFormat: @"%@",[[[MatchArray objectAtIndex:section] objectForKey:@"name"]uppercaseString]];
 return sectionName;
 }
 
 - (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
 {
 
     
 UIView *HeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
 [HeaderView setBackgroundColor: [Helper colorWithHexString:@"32CD32"]];
     UIView *HeaderLineView=[[UIView alloc]initWithFrame:CGRectMake(0, 39, 320, 1)];
     [HeaderLineView setBackgroundColor:[UIColor whiteColor]];
     [HeaderView addSubview:HeaderLineView];

 UILabel *LblObj=[[UILabel alloc]initWithFrame:CGRectMake(10, 8, 300, 24)];
 LblObj.text = [NSString stringWithFormat: @"%@",[[[MatchArray objectAtIndex:section] objectForKey:@"name"]uppercaseString]];
 LblObj.textColor = [UIColor whiteColor];
 LblObj.backgroundColor = [UIColor clearColor];
 LblObj.font =[UIFont fontWithName:@"Lato Regular" size:17.0];
 LblObj.textAlignment = NSTextAlignmentCenter ;

 [HeaderView addSubview:LblObj];
 return HeaderView;
 }
 
 - (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
 {
 return 40;
 }



@end
