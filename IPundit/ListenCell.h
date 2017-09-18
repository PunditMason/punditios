//
//  PDMyProfileCell.h
//  PicDu
//
//  Created by Gaurav Verma on 27/11/16.
//  Copyright © 2016 Gaurav Verma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListenCell : UICollectionViewCell

@property (nonatomic,weak)IBOutlet UIImageView *mImageView;
@property (nonatomic,weak)IBOutlet UILabel *mSportLable;
@property (weak, nonatomic) IBOutlet UIImageView *mImageIconView;
@property (weak, nonatomic) IBOutlet UIImageView *lableBackgroundImage;
@property (weak, nonatomic) IBOutlet UILabel *listenersCount;


-(void)mImageVCCornerRadius;


@end
