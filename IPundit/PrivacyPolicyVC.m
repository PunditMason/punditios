//
//  PrivacyPolicyVC.m
//  IPundit
//
//  Created by Deepak  on 17/06/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import "PrivacyPolicyVC.h"

@interface PrivacyPolicyVC ()

@end

@implementation PrivacyPolicyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mBackgroudImageView.image = DM.backgroundImage ;
    if (IS_IPHONE4) {
        self.view.frame = CGRectMake(0, 0, 320, 480);
        self.mBackgroudImageView.frame = CGRectMake(0, 0, 320, 480);
        self.mPrivacyPolicyTextView.frame = CGRectMake(16, 74, 288, 386);
    }
    
    
    
    self.mPrivacyPolicyTextView.text = [NSString stringWithFormat:@"%@",[DM.aboutPageContent objectForKey:@"content"]];
    self.pricavyTitle.text = [NSString stringWithFormat:@"%@",[DM.aboutPageContent objectForKey:@"title"]];
    self.mPrivacyPolicyTextView.textColor = [UIColor whiteColor];
    self.mPrivacyPolicyTextView.font = [UIFont systemFontOfSize:14];
    self.mPrivacyPolicyTextView.textAlignment = NSTextAlignmentJustified ;
    // Do any additional setup after loading the view.
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
@end
