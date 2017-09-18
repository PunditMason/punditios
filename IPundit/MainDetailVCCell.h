//
//  MainDetailVCCell.h
//  IPundit
//
//  Created by Manoj Gadamsetty on 18/06/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainDetailVCCell : UICollectionViewCell



@property (nonatomic,weak)IBOutlet UIImageView *mImageView;
@property (nonatomic,weak)IBOutlet UILabel *mLeaqueLable;
@property (weak, nonatomic) IBOutlet UIImageView *mLeaqueIcon;


-(void)mImageVCCornerRadius;

-(void)IndexPath:(NSIndexPath *)indexPath;





@end
