//
//  PDMyProfileCell.h
//  PicDu
//
//  Created by Gaurav Verma on 27/11/16.
//  Copyright © 2016 Gaurav Verma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailCell : UICollectionViewCell

@property (nonatomic,weak)IBOutlet UIImageView *mImageView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (nonatomic,weak)IBOutlet UILabel *mSportLable;

-(void)mImageVCCornerRadius;


@end


