//
//  PDSliderCell.h
//  PicDu
//
//  Created by Gaurav Verma on 26/11/16.
//  Copyright © 2016 Gaurav Verma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "AppDelegate.h"
#import "SSProductsModel.h"

@interface SSContentCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UILabel *mProductNameLable;
@property (strong, nonatomic) IBOutlet UILabel *mProductDescriptionLable;

@property (strong, nonatomic) IBOutlet UILabel *mProductPriceLable;
@property (strong, nonatomic) IBOutlet UIImageView *mProductImageView;
@property (strong, nonatomic) IBOutlet UIImageView *mProductOverlayImageView;


-(void)updateCell:(NSIndexPath *)indexPath :(NSArray *)mitemDetailArray;
@end
