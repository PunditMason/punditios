//
//  Validation.h
//
//
//  Created by  on 6/16/14.
//  Copyright (c) 2014 . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Validation : NSObject


+(id)validationManager;
-(BOOL)validateEmail:(NSString*)emailString;
-(BOOL)validatePassword:(NSString*)password;
-(BOOL)validateBlankField:(NSString*)string;
-(BOOL)validatePhoneNumber:(NSString*)phoneString;
-(BOOL)validateZipCode:(NSString*)zipcodeString;
-(BOOL)validateCharacters:(NSString*)string;
-(BOOL)validateString:(NSString*)string equalTo:(NSString*)match ;
-(BOOL)validateUsername:(NSString*)usernameString;
-(BOOL)validateUsernameLength:(NSString*)usernameStringLength;
-(BOOL)validateNumericNumber:(NSString*)string;
-(BOOL)isAlphaNumericOnly:(NSString *)input;
- (BOOL) validateUrl: (NSString *) candidate;
-(BOOL)validateMessage:(NSString*)Message;
@end
