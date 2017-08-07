//
//  MainListenDetailCell.m
//  IPundit
//
//  Created by Manoj Gadamsetty on 18/06/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import "MainListenDetailCell.h"

@implementation MainListenDetailCell

-(void)mImageVCCornerRadius{
    CALayer *imageLayera = self.mImageView.layer;
    [imageLayera setCornerRadius:5];
    [imageLayera setBorderColor:[[UIColor clearColor]CGColor]];
    [imageLayera setBorderWidth:0.5];
    [imageLayera setMasksToBounds:YES];
}

-(void)IndexPath:(NSIndexPath *)indexPath{
    UIImageView * broadcastImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, 179, 188)];
    [broadcastImageView setImage:[UIImage imageNamed:@"greentile.png"]];
    broadcastImageView.backgroundColor = [UIColor clearColor];
        self.mImageIconView.frame = CGRectMake(14, 105, 57, 63);
        self.mImageView.frame = CGRectMake(0, 0, 294, 208);
        self.mLeaqueLable.frame = CGRectMake(10, 165,129, 30);
        self.mLeaqueLable.numberOfLines = 2 ;
        [self.mImageView addSubview:broadcastImageView];
        self.broadcasterCountImageView.frame = CGRectMake(260, 2, 28, 32);
        self.broadcasterCountLabel.frame = CGRectMake(260, 8, 28, 19);
}


@end
