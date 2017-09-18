//
//  BLCountriesCell.h
//  WowzaGoCoderSDKSampleApp
//
//  Created by Gaurav Verma on 14/10/16.
//  Copyright © 2016 Wowza, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLCountry.h"
@interface BLCountriesCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *mCountriesLable;
@property (nonatomic, strong) IBOutlet UILabel *mCountriesCodeLable;

-(void)setCountry:(BLCountry *)country;

@end
