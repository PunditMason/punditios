//
//  BaseVC.m
//  Givel
//
//  Created by Developer on 05/01/17.
//  Copyright © 2017 inext. All rights reserved.
//

#import "BaseVC.h"
//import "SelectOptionView.h"
#import "DataManager.h"

@interface BaseVC ()

@end

@implementation BaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveTestNotification:)
                                                 name:@"MFSideMenuStateNotificationEvent"
                                               object:nil];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





-(void)viewWillAppear:(BOOL)animated{
    
    
}

-(void)NavigationWithImage{
    [self.navigationController.navigationBar setFrame:CGRectMake(0, 0, self.view.frame.size.width,64)];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"header02"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
    self.navigationController.navigationBar.hidden=NO;

    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    UIImage *image = [UIImage imageNamed:@"#F-Gl"];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:image];
    UIBarButtonItem *leftButton=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Menubutton"]
                                                                style:UIBarButtonItemStylePlain
                                                               target:self
                                                               action:@selector(stop:)];
    UIBarButtonItem *Rightbutton=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"#F-P"]
                                                                 style:UIBarButtonItemStylePlain
                                                                target:self
                                                                action:@selector(Post:)];
    Rightbutton.imageInsets = UIEdgeInsetsMake(0, -6, -.5, 3);
    leftButton.imageInsets=UIEdgeInsetsMake(6, -4, -5, 0);
    [leftButton setTintColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1]];
    [Rightbutton setTintColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1]];
    self.navigationItem.rightBarButtonItem =Rightbutton;
    self.navigationItem.leftBarButtonItem = leftButton;
   // [CommonMethod IncreseNavigationHeight:self.navigationController View:self.view];

    self.navigationController.navigationBar.backgroundColor= [UIColor clearColor];
    [self.navigationController.navigationBar setFrame:CGRectMake(0, 0, self.view.frame.size.width,64)];
}
-(void)NavigationWithTitle:(NSString*)Title{
    [self.navigationItem setTitle:Title];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
    self.navigationController.navigationBar.hidden=NO;
    UIBarButtonItem *leftButton=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"#F-M"]
                                                                style:UIBarButtonItemStylePlain
                                                               target:self
                                                               action:@selector(stop:)];
    self.tabBarController.tabBar.backgroundImage=[UIImage imageNamed:@"nav1"];
    [leftButton setTintColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1]];
    
    UIBarButtonItem *Rightbutton=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"#F-P"]
                                                                 style:UIBarButtonItemStylePlain
                                                                target:self
                                                                action:@selector(Post:)];
    Rightbutton.imageInsets = UIEdgeInsetsMake(0, -6, -.5, 3);
    leftButton.imageInsets=UIEdgeInsetsMake(0, -4, -3, 0);
    [Rightbutton setTintColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1]];
    self.navigationItem.rightBarButtonItem =Rightbutton;
    self.navigationItem.leftBarButtonItem = leftButton;
 //   [CommonMethod IncreseNavigationHeight:self.navigationController View:self.view];
    [self.navigationController.navigationBar setFrame:CGRectMake(0, 0, self.view.frame.size.width,64)];
}

-(void)NavigationWithBackButton:(NSString*)Title {
    self.navigationItem.title=Title;
    self.navigationController.navigationBar.hidden=NO;
    self.navigationController.navigationBar.backgroundColor=[UIColor clearColor];
    [self.navigationController.navigationBar setFrame:CGRectMake(0, 0, self.view.frame.size.width,64)];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.navigationItem.hidesBackButton=NO;
    UIBarButtonItem *leftButton=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"BW"]
                                                                style:UIBarButtonItemStylePlain
                                                               target:self
                                                               action:@selector(backButton:)];
    [leftButton setTintColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1]];
    self.navigationItem.leftBarButtonItem =leftButton;
  //  [CommonMethod IncreseNavigationHeight:self.navigationController View:self.view];
    self.navigationItem.hidesBackButton=NO;
}


- (IBAction)Post:(id)sender{
   // [SelectOptionView showSelectionView:self.navigationController];
    //[CommonMethod movewithStoryBourdID:self.navigationController Id:@"MenuTBC"];
}
- (IBAction)stop:(id)sender{
  //  [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];
}
- (IBAction)backButton:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark-ChangeMenu Notification ##########################
- (void) receiveTestNotification:(NSNotification *) notification  {
    if ([[notification name] isEqualToString:@"MFSideMenuStateNotificationEvent"])
        NSLog(@"%@",[notification valueForKey:@"userInfo"]);
    if ([[[notification valueForKey:@"userInfo"]valueForKey:@"eventType"] intValue] == 1) {
        UIBarButtonItem *leftButton=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"BW"]
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:self
                                                                   action:@selector(stop:)];
        [leftButton setTintColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1]];
        leftButton.imageInsets=UIEdgeInsetsMake(6, -4, -5, 0);
        self.navigationItem.leftBarButtonItem =leftButton;
    }
    else if([[[notification valueForKey:@"userInfo"]valueForKey:@"eventType"] intValue] == 3){
        UIBarButtonItem *leftButton=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Menubutton"]
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:self
                                                                   action:@selector(stop:)];
        leftButton.imageInsets=UIEdgeInsetsMake(6, -4, -5, 0);
        [leftButton setTintColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1]];
        self.navigationItem.leftBarButtonItem =leftButton;
        
    }
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
