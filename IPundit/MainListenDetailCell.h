//
//  MainListenDetailCell.h
//  IPundit
//
//  Created by Manoj Gadamsetty on 18/06/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainListenDetailCell : UICollectionViewCell

@property (nonatomic,weak)IBOutlet UIImageView *mImageView;
@property (nonatomic,weak)IBOutlet UILabel *mLeaqueLable;
@property (weak, nonatomic) IBOutlet UIImageView *mImageIconView;
@property (strong, nonatomic) IBOutlet UIImageView *broadcasterCountImageView;
@property (strong, nonatomic) IBOutlet UILabel *broadcasterCountLabel;
-(void)mImageVCCornerRadius;

-(void)IndexPath:(NSIndexPath *)indexPath;


@end
