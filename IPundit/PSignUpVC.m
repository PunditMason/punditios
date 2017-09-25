//
//  PSignUpVC.m
//  IPundit
//
//  Created by Gaurav Verma on 22/09/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import "PSignUpVC.h"

@interface PSignUpVC ()

@end

@implementation PSignUpVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [[IQKeyboardManager sharedManager]setKeyboardDistanceFromTextField:50];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)CloseButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
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
