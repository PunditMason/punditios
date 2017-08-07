//
//  BLCountry.h
//  BonkApp
//
//  Created by Bhupinder Verma on 19/10/16.
//  Copyright © 2016 Wowza, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLCountry : NSObject

@property (nonatomic,copy)NSString *mCountryName;
@property (nonatomic,copy)NSString *mCountryCode;
@property (nonatomic,copy)NSString *mSearchString;


+(BLCountry *)defaultCountry ;
+(NSDictionary *)getCountryCodeDictionary;
@end



/*
 
 BLCountry *country = [BLCountry defaultCountry];
 self.mCountriesTextField.text = [NSString stringWithFormat:@"  %@",country.mCountryName];
 [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SelectedCountry:) name:@"kNOTIFICATION_COUNTRIES" object:nil];
 }
 
 -(void)SelectedCountry:(NSNotification *)notif{
 NSDictionary *dct = [notif userInfo];
 NSLog(@"%@",dct);
 BLCountry *country = [dct valueForKey:@"val"];
 self.mCountriesTextField.text = [NSString stringWithFormat:@"  %@",country.mCountryName];
 
 }

 
 
 */








