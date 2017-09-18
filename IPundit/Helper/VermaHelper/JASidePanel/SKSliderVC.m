//
//  SKSliderVC.m
//  SHKUN
//
//  Created by Gaurav Verma on 21/12/16.
//  Copyright © 2016 Gaurav Verma. All rights reserved.
//

#import "SKSliderVC.h"



@interface SKSliderVC (){
    NSMutableArray *mSliderImageTableArray;
}

@end

@implementation SKSliderVC
@synthesize mSliderTableArray,mSliderTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}





-(void)initializeSliderData{
    
    mSliderTableArray = [[NSMutableArray alloc]init];
    mSliderImageTableArray = [[NSMutableArray alloc]init];

    dct = [[NSMutableDictionary alloc] init];
    
    
        mSliderTableArray  = [[NSMutableArray alloc]initWithObjects:@"Home",@"Notification",@"Order History",@"Track Order",@"Enquiry",@"T&C Disclaimer",@"Settings",@"Logout", nil];
    
    mSliderImageTableArray  = [[NSMutableArray alloc]initWithObjects:@"favProduct.png",@"notification_icon.png",@"9.png",@"scooter_active.png",@"9.png",@"9.png",@"9.png",@"9.png", nil];

    
    
    CALayer *imageLayera = self.mLogoImageView.layer;
    [imageLayera setCornerRadius:self.mLogoImageView.frame.size.width/2];
    [imageLayera setBorderColor:[[UIColor whiteColor]CGColor]];
    [imageLayera setBorderWidth:1];
    [imageLayera setMasksToBounds:YES];
    
    [self CurrentUser];
    [mSliderTableView reloadData];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [self initializeSliderData];
    
    NSIndexPath *tableSelection = [self.mSliderTableView indexPathForSelectedRow];
    [self.mSliderTableView deselectRowAtIndexPath:tableSelection animated:NO];
    self.mSliderTableView.separatorColor = [UIColor clearColor];
    
    
}


-(void)CurrentUser{
    SKUser *CurrentUser = [[SKUser alloc] init];
    [CurrentUser setupUser:[Helper mCurrentUser]];
    
    self.mNameLbl.text = CurrentUser.mFull_Name;
    self.mLocationLbl.text = CurrentUser.mEmail;
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",CurrentUser.mUserImage]];
    [self.mLogoImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"user_icon.jpg"]];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

/*
 - (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
 {
 NSString *sectionName;
 sectionName = [NSString stringWithFormat: @"MENU"];
 return sectionName;
 }
 
 - (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
 {
 
 UIView *HeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
 
 [HeaderView setBackgroundColor: [Helper colorWithHexString:@"1F1811"]];
 
 UILabel *LblObj=[[UILabel alloc]initWithFrame:CGRectMake(0, 8, 232, 24)];
 LblObj.text = @"MENU";
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
 */
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return mSliderTableArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *CellIdentifier = @"slidercell";
    SKSliderCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[SKSliderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
    
    UIView *bgColorView = [[UIView alloc] init];
    [bgColorView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3]];
    
    [cell setSelectedBackgroundView:bgColorView];
    
    cell.backgroundColor = [UIColor clearColor];
    
    cell.mSliderCellLbl.text = [mSliderTableArray objectAtIndex:indexPath.row];
    
    cell.mLogoImageView.image = [UIImage imageNamed:[mSliderImageTableArray objectAtIndex:indexPath.row]];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;{
    
    NSLog(@"Selected View index=%ld",(long)indexPath.row);
    [mSliderTableView deselectRowAtIndexPath:indexPath animated:NO];
    NSNumber *num = [NSNumber numberWithInt:indexPath.row];
    [dct setObject:num forKey:@"val"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kNOTIFICATION_MESSAGES" object:nil userInfo:dct];
    if (indexPath.row == 7) {
        NSLog(@"Logout");
        [DM.mAppObj logout];
    }
    [DM.mAppObj.mSlideVC showCenterPanelAnimated:YES];

}




-(IBAction)facebookClicked:(id)sender {
    
    if (DM.mInternetStatus == false) {
        UIAlertView *alrt = [[UIAlertView alloc] initWithTitle:@"Network Error:" message:@"Sorry, your device is not connected to internet." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alrt show];
        alrt = nil;
        return;
    }
    
    NSURL *desiredurl = [NSURL URLWithString:@"fb://profile/1159582604108550"];
    NSString *openStr = [desiredurl absoluteString];
    if([[UIApplication sharedApplication] canOpenURL:desiredurl]) {
        [self openSocialUrl:openStr];
    }
    else {
        NSArray *mTempArr = [openStr componentsSeparatedByString:@"/"];
        if ([mTempArr count]){
            NSString *postFixStr = [mTempArr lastObject];
            [self openSocialUrl:[NSString stringWithFormat:@"%@%@", kfbPrefixStr, postFixStr]];
        }
    }
    
}

-(IBAction)twitterClicked:(id)sender {
    if (DM.mInternetStatus == false) {
        UIAlertView *alrt = [[UIAlertView alloc] initWithTitle:@"Network Error:" message:@"Sorry, your device is not connected to internet." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alrt show];
        alrt = nil;
        return;
    }
    
    NSURL *desiredurl = [NSURL URLWithString:@"twitter://user?screen_name=vermz814"];
    NSString *openStr = [desiredurl absoluteString];
    if([[UIApplication sharedApplication] canOpenURL:desiredurl]) {
        [self openSocialUrl:openStr];
    }
    else {
        NSArray *mTempArr = [openStr componentsSeparatedByString:@"="];
        if ([mTempArr count]){
            NSString *postFixStr = [mTempArr lastObject];
            [self openSocialUrl:[NSString stringWithFormat:@"%@%@", ktwitterPrefixStr, postFixStr]];
        }
    }
}

- (void)openSocialUrl:(NSString *) linkStr {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:linkStr]];
}


-(IBAction)openWebsiteAction:(id)sender {
    CVBWebsiteVC *webvcObj = [self.storyboard instantiateViewControllerWithIdentifier:@"webvc"];
    webvcObj.webURL = @"https://www.facebook.com/shreesna/";
    webvcObj.titleStr = @"";
    [self presentViewController:webvcObj animated:YES completion:NULL];
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
