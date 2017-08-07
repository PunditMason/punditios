//
//  PDMyProfileCell.m
//  PicDu
//
//  Created by Gaurav Verma on 27/11/16.
//  Copyright © 2016 Gaurav Verma. All rights reserved.
//

#import "ListenCell.h"

@implementation ListenCell

-(void)mImageVCCornerRadius{
    CALayer *imageLayera = self.mImageView.layer;
    [imageLayera setCornerRadius:5];
    [imageLayera setBorderColor:[[UIColor clearColor]CGColor]];
    [imageLayera setBorderWidth:0.5];
    [imageLayera setMasksToBounds:YES];
}

@end
