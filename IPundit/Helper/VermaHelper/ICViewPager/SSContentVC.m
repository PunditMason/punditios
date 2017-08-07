//
//  SSContentVC.m
//  Shree Sweets
//
//  Created by Gaurav Verma on 29/01/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import "SSContentVC.h"
#import "SSContentCell.h"
#import "UIImageView+WebCache.h"
#import "SSProductDetailVC.h"
@interface SSContentVC (){
    SSProductsModel *Productobj;
}

@end

@implementation SSContentVC
@synthesize mITemsTableView;



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shuffleScreen:) name:@"kNOTIFICATION_MESSAGES" object:nil];
    
    self.mRefreshControl = [[SSARefreshControl alloc] initWithScrollView:self.mITemsTableView andRefreshViewLayerType:SSARefreshViewLayerTypeOnScrollView];
    self.mRefreshControl.delegate = self;

}



-(void)shuffleScreen:(NSNotification *)notif{
    
    NSDictionary *dct = [notif userInfo];
    NSNumber *num = [dct objectForKey:@"val"];
    
    if ([num integerValue] == 0){
        
        NSLog(@"Home");
        
    }
    else if ([num integerValue] == 1){
        
        NSLog(@"Notification");
        
       // [self performSegueWithIdentifier:@"NotificationVC" sender:self];

    }
    else if ([num integerValue] == 2){
        
        NSLog(@"Order History");
        
        
        
    }
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
 //   mITemsTableArray = [[NSMutableArray alloc]init];

    
    NSIndexPath *tableSelection = [self.mITemsTableView indexPathForSelectedRow];
    [self.mITemsTableView deselectRowAtIndexPath:tableSelection animated:NO];
    self.mITemsTableView.separatorColor = [UIColor clearColor];
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 101;
}


//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    NSString *sectionName;
//    sectionName = [NSString stringWithFormat: @"Products"];
//    return sectionName;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//
//    UIView *HeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
//
//    [HeaderView setBackgroundColor: [Helper colorWithHexString:@"272A2B"]];
//
//    UILabel *LblObj=[[UILabel alloc]initWithFrame:CGRectMake(0, 8, 232, 24)];
//    LblObj.text = @"Products";
//    LblObj.textColor = [UIColor whiteColor];
//    LblObj.backgroundColor = [UIColor clearColor];
//    LblObj.font =[UIFont fontWithName:@"-Montserrat-Bold" size:17.0];
//    LblObj.textAlignment = NSTextAlignmentCenter ;
//
//    [HeaderView addSubview:LblObj];
//    return HeaderView;
//}
//
//- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 40;
//}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.ProductArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *CellIdentifier = @"ViewCell";
    SSContentCell *cell =(SSContentCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[SSContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
    
    UIView *bgColorView = [[UIView alloc] init];
    [bgColorView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3]];
    
    [cell setSelectedBackgroundView:bgColorView];
    
    cell.backgroundColor = [UIColor clearColor];
    
    [cell updateCell:indexPath :self.ProductArray];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;{
    
    NSLog(@"Selected View index=%ld",(long)indexPath.row);
    [mITemsTableView deselectRowAtIndexPath:indexPath animated:NO];
    
    Productobj = [[SSProductsModel alloc] init];
    Productobj = [self.ProductArray objectAtIndex:indexPath.row];
    
    
    [self performSegueWithIdentifier:@"ProductDetailVC" sender:self];

}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"ProductDetailVC"]) {
        SSProductDetailVC *destinationVC = segue.destinationViewController;
        destinationVC.mItemDetalObj = Productobj;
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark =============================================================
#pragma mark ============================= REFRESH VIEW DELEGATES ========
#pragma mark =============================================================

- (void)beganRefreshing {
    
    [self loadDataSource];
}

- (void)loadDataSource {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1.5);
         [self.View_Controller DownloadProducts];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.mITemsTableView reloadData];
            [self.mRefreshControl endRefreshing];
        });
    });
}










@end


