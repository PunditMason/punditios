//
//  VideoHighlightsVC.h
//  IPundit
//
//  Created by Gaurav Verma on 30/10/17.
//  Copyright © 2017 James Mason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "Helper.h"
#import "DataManager.h"
#import "UIViewController+MJPopupViewController.h"
@interface VideoHighlightsVC : UIViewController<UIWebViewDelegate>{
    
}


@property (weak, nonatomic) IBOutlet UITableView *mVideoHighlightTableView;
@property (strong, nonatomic)  NSString *leaqueID;
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (strong, nonatomic) IBOutlet UILabel *mVideoHighlightsLable;



@end
