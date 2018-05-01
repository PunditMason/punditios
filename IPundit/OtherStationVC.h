//
//  LatestPodcastsVC.h
//  IPundit
//
//  Created by Gaurav  Verma on 23/04/18.
//  Copyright © 2018 James Mason. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DataManager.h"
#import "BaseVC.h"
#import "WebServicesHelper.h"
#import "UIImageView+WebCache.h"
#import "Constants.h"
#import "UIImage+animatedGIF.h"
#import "LatestPodcastsCell.h"


@interface OtherStationVC : UIViewController

@property (nonatomic,weak)IBOutlet UICollectionView *mCollectionView;
@property (strong, nonatomic)  NSString *leaqueID;

@property (strong, nonatomic) IBOutlet UIImageView *mBackgroudImageView;
- (IBAction)backButtonAction:(id)sender;


@end
