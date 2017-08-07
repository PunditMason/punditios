//
//  PDSliderCell.m
//  PicDu
//
//  Created by Gaurav Verma on 26/11/16.
//  Copyright © 2016 Gaurav Verma. All rights reserved.
//

#import "SSContentCell.h"
#import "UIImageView+WebCache.h"

@implementation SSContentCell

- (void)awakeFromNib {
    [super awakeFromNib];

    CALayer *imageLayera = self.mProductImageView.layer;
    [imageLayera setCornerRadius:2];
    [imageLayera setBorderColor:[[UIColor clearColor]CGColor]];
    [imageLayera setBorderWidth:0.5];
    [imageLayera setMasksToBounds:YES];
    
    CALayer *imageLayera1 = self.mProductOverlayImageView.layer;
    [imageLayera1 setCornerRadius:5];
    [imageLayera1 setBorderColor:[[UIColor clearColor]CGColor]];
    [imageLayera1 setBorderWidth:0.5];
    [imageLayera1 setMasksToBounds:YES];
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



-(void)updateCell:(NSIndexPath *)indexPath :(NSArray *)mitemDetailArray
{
    
    
    SSProductsModel *Productobj = [[SSProductsModel alloc] init];

    Productobj = [mitemDetailArray objectAtIndex:indexPath.row];
    
  
   // PFFile *userImageFile = [[mitemDetailArray objectAtIndex:indexPath.row]objectForKey:@"Product_Thumbnail_Image"];
    
    NSURL *Url = [NSURL URLWithString:Productobj.Product_Thumbnail_Image];
    NSLog(@"%@",Url);
    [self.mProductImageView sd_setImageWithURL:Url placeholderImage:[UIImage imageNamed:@"No-photos.png"]];
    
   
    
//    if (userImageFile && ![userImageFile isEqual:[NSNull null]]) {
//        [userImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
//            if (!error)
//            {
//                self.mProductImageView.image  = [UIImage imageWithData:imageData];
//            }
//        }];
//    }
    
    
  //  self.mProductNameLable.text = [[[mitemDetailArray objectAtIndex:indexPath.row]objectForKey:@"Product_Name"] uppercaseString];
    
    self.mProductNameLable.text = [Productobj.Product_Name uppercaseString];
    
    
  //  self.mProductDescriptionLable.text = [[mitemDetailArray objectAtIndex:indexPath.row]objectForKey:@"Product_Description"];
    
    self.mProductDescriptionLable.text = Productobj.Product_Description;

    
   // NSString *Price = [NSString stringWithFormat:@"%@",[[mitemDetailArray objectAtIndex:indexPath.row]objectForKey:@"Product_Price"]];
    
    NSString *Price = [NSString stringWithFormat:@"₹ %@",Productobj.Product_Price];
    
    self.mProductPriceLable.text = Price ;
}

@end
