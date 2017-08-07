//
//  PDMyProfileCell.h
//  PicDu
//
//  Created by Gaurav Verma on 27/11/16.
//  Copyright © 2016 Gaurav Verma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListenDetailCell : UICollectionViewCell

@property (nonatomic,weak)IBOutlet UIImageView *mImageView;
@property (nonatomic,weak)IBOutlet UILabel *mLeaqueLable;
@property (weak, nonatomic) IBOutlet UIImageView *mImageIconView;
@property (strong, nonatomic) IBOutlet UIImageView *broadcasterCountImageView;
@property (strong, nonatomic) IBOutlet UILabel *broadcasterCountLabel;

-(void)mImageVCCornerRadius;

-(void)IndexPath:(NSIndexPath *)indexPath;


@end
