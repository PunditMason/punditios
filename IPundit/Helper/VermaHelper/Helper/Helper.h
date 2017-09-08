//
//  Helper.h
//  Coupon
//
//  Created by Gaurav Verma on 24/08/15.
//  Copyright (c) 2015 Gaurav Verma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SVProgressHUD.h"
#import "Reachability.h"
#import "ISMessages.h"

@interface Helper : NSObject{
    
}
+(void)showAlert:(NSString *__nullable)title andMessage:(NSString *__nullable)message andButton:(NSString *__nullable)btnTitle;

+ (NSString *) checkNullString:(NSString *)string;
+(UIView *)view:(NSString *)Message ViewWidth:(CGFloat)ViewWidth andHeight:(CGFloat)ViewHight myview:(UIView*)Myview;
+(CGFloat)SizeThatFits:(CGFloat)size MutableAtrributedString:(NSMutableAttributedString*)MutableString FontSize:(float)fontSize LineSpacing:(CGFloat)lineSpace;

+(void)movewithStoryBourdID:(UINavigationController*)navigationcontroler Id:(NSString*)strID animation:(bool)yes;

+ (NSString*)base64EncodedStringFromImage:(UIImage *)sourceImage;
+ (NSString*)base64EncodedString:(NSString *)sourceString;
+ (UIImage *)decodeBase64ToImage:(NSString *)strEncodeData;

+ (NSString*)date_String;
+(NSString*)Current_Device_Id;
+ (NSString *) timeStamp;
+ (NSString*)date_Time_String;
+ (NSString*)TempId;
+(NSString *)getRandomPINString:(NSInteger)length;
+(UIColor*)colorWithHexString:(NSString*)hex;


+(NSArray *)fetchJsonWithFileName:(NSString *)fileName;
+(void)removePreviousData:(NSString *)file;
+(void)writeJsonData:(NSString *)jsonString andfileName:(NSString *)fileName ;


+(NSString *)saveImage:(UIImage*)img withName:(NSString *)imageName;
+(NSString *)documentImagePath;
+(NSString *)docFolderPath:(NSString *)fileName;
+ (void)deleteFileWithName:(NSString *)fileName;

+ (NSString*)GetImageUrl;

+(void)copyFile:(NSString *)fileName;
+ (nonnull NSString *)appBundleInformation;
+(NSDictionary*__nullable)mCurrentUser;
+(NSDictionary*__nullable)mGetProfileCurrentUser;

+(NSDictionary *__nullable)formatJSONDict:(NSDictionary *__nullable)dct;

+(void)showLoaderVProgressHUD;
+(void)hideLoaderSVProgressHUD;
+(BOOL)isInternetConnection;

@property (weak, nonatomic) IBOutlet UISwitch *__nullable positionSwitcher;

+(void)ISAlertTypeError:(NSString *__nullable)title andMessage:(NSString *__nullable)message;
+(void)ISAlertTypeSuccess:(NSString *__nullable)title andMessage:(NSString *__nullable)message;
+(void)ISAlertTypeWarning:(NSString *__nullable)title andMessage:(NSString *__nullable)message;

@end















