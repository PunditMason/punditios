//
//  YTPlayerVC.h
//  IPundit
//
//  Created by Gaurav Verma on 06/11/17.
//  Copyright © 2017 James Mason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTPlayerView.h"
#import "Constants.h"
#import "Helper.h"
#import "DataManager.h"

@interface YTPlayerVC : UIViewController
@property(nonatomic, strong) IBOutlet YTPlayerView *playerView;
@property (strong, nonatomic)  NSString *youTubeId;
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;
- (IBAction)BackButtonAction:(id)sender;

@end
