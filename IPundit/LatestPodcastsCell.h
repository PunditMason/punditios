//
//  PDMyProfileCell.h
//  PicDu
//
//  Created by Gaurav Verma on 27/11/16.
//  Copyright © 2016 Gaurav Verma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LatestPodcastsCell : UICollectionViewCell


@property (nonatomic,weak)IBOutlet UIImageView *mImageView;
@property (nonatomic,weak)IBOutlet UIImageView *mTeam1ImageView;
@property (nonatomic,weak)IBOutlet UIImageView *mTeam2ImageView;

@property (nonatomic,weak)IBOutlet UILabel *mPodcastNameLable;
@property (nonatomic,weak)IBOutlet UILabel *mUserNameLable;


-(void)mImageVCCornerRadius;


@end


