//
//  TrophyViewTableViewCell.h
//  IPundit
//
//  Created by softuvo on 20/04/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TrophyViewTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *posLabel;
@property (weak, nonatomic) IBOutlet UILabel *clubNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *pLabel;
@property (weak, nonatomic) IBOutlet UILabel *wLabel;
@property (weak, nonatomic) IBOutlet UILabel *dLabel;
@property (weak, nonatomic) IBOutlet UILabel *lLabel;
@property (strong, nonatomic) IBOutlet UILabel *mGDLabel;
@property (strong, nonatomic) IBOutlet UILabel *mPointsLabel;
@property (strong, nonatomic) IBOutlet UIImageView *mImageView;




@end
