//
//  BLCountriesCell.m
//  WowzaGoCoderSDKSampleApp
//
//  Created by Gaurav Verma on 14/10/16.
//  Copyright © 2016 Wowza, Inc. All rights reserved.
//

#import "BLCountriesCell.h"

@implementation BLCountriesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setCountry:(BLCountry *)country {
    self.mCountriesLable.text = country.mCountryName;
    self.mCountriesCodeLable.text = country.mCountryCode;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
