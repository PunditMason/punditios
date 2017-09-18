//
//  AboutVC.m
//  IPundit
//
//  Created by Deepak Kumar on 28/02/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import "AboutVC.h"
#import "DataManager.h"
#import "Constants.h"

@interface AboutVC ()

@end

@implementation AboutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backgroundImageView.image = DM.backgroundImage ;
    
    if (IS_IPHONE4) {
        self.view.frame = CGRectMake(0, 0, 320, 480);
        self.backgroundImageView.frame = CGRectMake(0, 0, 320, 480);
        self.mTextView.frame = CGRectMake(16, 98, 288, 268);
        self.privacyButton.frame = CGRectMake(85, 406, 150, 41);
    }
    
    
    [self getData];

    // Do any additional setup after loading the view.
}


-(void)getData{
    NSString *stringPath = [NSString stringWithFormat:@"%@Game/get_about",KServiceBaseURL];
    
    [DM GetRequest:stringPath parameter:nil onCompletion:^(id  _Nullable dict) {
     NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
        
        DM.aboutPageContent = [[responseDict objectForKey:@"data"]objectAtIndex:1];
        self.aboutUsString = [NSString stringWithFormat:@"%@",[[[responseDict objectForKey:@"data"]objectAtIndex:0]objectForKey:@"content"]];
       
        self.aboutUsTitle.text = [NSString stringWithFormat:@"%@",[[[responseDict objectForKey:@"data"]objectAtIndex:0]objectForKey:@"title"]];
        self.mTextView.text = self.aboutUsString ;
        self.mTextView.textColor = [UIColor whiteColor];
        self.mTextView.font = [UIFont systemFontOfSize:14];
        self.mTextView.textAlignment = NSTextAlignmentJustified ;
        [self adjustContentSize:_mTextView];
    } onError:^(NSError * _Nullable Error) {
        
    }];
}
-(void)adjustContentSize:(UITextView*)tv{
    CGFloat deadSpace = ([tv bounds].size.height - [tv contentSize].height);
    CGFloat inset = MAX(0, deadSpace/2.0);
    tv.contentInset = UIEdgeInsetsMake(inset, tv.contentInset.left, inset, tv.contentInset.right);
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

- (IBAction)BackButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
