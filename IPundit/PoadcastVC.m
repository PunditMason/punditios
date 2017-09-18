//
//  PoadcastVC.m
//  IPundit
//
//  Created by Gaurav Verma on 13/09/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import "PoadcastVC.h"
#import "PoadcastDetailVC.h"

@interface PoadcastVC (){
    NSMutableArray *MatchArray;
    NSMutableArray *SelectedMatchArray;
}

@end

@implementation PoadcastVC

- (void)viewDidLoad {
    [super viewDidLoad];
    MatchArray =  [[NSMutableArray alloc] init];
    SelectedMatchArray = [[NSMutableArray alloc] init];
    // Do any additional setup after loading the view.
    [self GetChannelt];
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

    NSString *string = [NSString stringWithFormat:@"%@game/getChannelCount/%@/",KServiceBaseURL,self.selectedUser];
    [DM GetRequest:string parameter:nil onCompletion:^(id  _Nullable dict) {
        NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
        NSLog(@"ResponseDict %@",responseDict);
        
        if ([[responseDict objectForKey:@"Match"]isEqual:[NSNull null]]) {
            self.mNoPoadcastAvilable.hidden = NO;
            [Helper hideLoaderSVProgressHUD];
            return ;
        }else{
            [MatchArray addObjectsFromArray:[responseDict objectForKey:@"Match"]];

        }
    
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
    
    NSIndexPath *tableSelection = [self.mPoadcastTableView indexPathForSelectedRow];
    [self.mPoadcastTableView deselectRowAtIndexPath:tableSelection animated:NO];
    self.mPoadcastTableView.separatorColor = [UIColor clearColor];
    
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return MatchArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *CellIdentifier = @"Poadcastcell";
    PoadcastCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if (cell == nil) {
        cell = [[PoadcastCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    UIView *bgColorView = [[UIView alloc] init];
    [bgColorView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3]];
    [cell setSelectedBackgroundView:bgColorView];
    
    
    NSDictionary *dct = [Helper formatJSONDict:[MatchArray objectAtIndex:indexPath.row]];
    cell.mMatchName.text = [NSString stringWithFormat:@"%@ V/S %@",[dct objectForKey:@"team1_name"],[dct objectForKey:@"team2_name"]];
    
    //
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;{
    
    [self.mPoadcastTableView deselectRowAtIndexPath:indexPath animated:NO];
    [SelectedMatchArray removeAllObjects];
    [SelectedMatchArray addObjectsFromArray:[[MatchArray objectAtIndex:indexPath.row] objectForKey:@"channel"]];
    
    [self performSegueWithIdentifier:@"PoadcastDView" sender:self];
    
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"PoadcastDView"]) {
        PoadcastDetailVC *destinationVC = segue.destinationViewController;
          destinationVC.ChannelArray = SelectedMatchArray;
        
    }
}
@end
