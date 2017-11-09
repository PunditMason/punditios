//
//  YTPlayerVC.m
//  IPundit
//
//  Created by Gaurav Verma on 06/11/17.
//  Copyright © 2017 James Mason. All rights reserved.
//

#import "YTPlayerVC.h"

@interface YTPlayerVC ()

@end

@implementation YTPlayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [Helper showLoaderVProgressHUD];
    self.playerView.hidden = true;
    [self.playerView loadWithVideoId:self.youTubeId];
    self.backgroundImageView.image = DM.backgroundImage ;

    [self performSelector:@selector(YouTubeExecute) withObject:nil afterDelay:3.0 ];
    

}
-(void)YouTubeExecute{
    [Helper hideLoaderSVProgressHUD];
    self.playerView.hidden = false;

    
}
- (IBAction)BackButtonAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];

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
