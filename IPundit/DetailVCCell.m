//
//  PDMyProfileCell.m
//  PicDu
//
//  Created by Gaurav Verma on 27/11/16.
//  Copyright © 2016 Gaurav Verma. All rights reserved.
//

#import "DetailVCCell.h"

@implementation DetailVCCell

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

    if (indexPath.row == 0) {
        
        
        self.mLeaqueIcon.frame = CGRectMake(14, 108, 57, 63);
        self.mImageView.frame = CGRectMake(0, 0, 294, 208);
        self.mLeaqueLable.frame = CGRectMake(10, 170, 129, 15);
        [self.mImageView addSubview:broadcastImageView];
        broadcastImageView.hidden = NO ;
    
    }
    else{
        self.mImageView.frame = CGRectMake(0, 0, 143, 100);
        broadcastImageView.hidden = YES ;
        //self.mLeaqueLable.frame = CGRectMake(6, 80, 129, 15);
    }
    
}


@end
