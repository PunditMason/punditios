//
//  Helper.m
//  Coupon
//
//  Created by Gaurav Verma on 24/08/15.
//  Copyright (c) 2015 Gaurav Verma. All rights reserved.
//

#import "Helper.h"
#import "Constants.h"
#import <CoreText/CoreText.h>
@implementation Helper


#pragma mark ---------------------------------------------------------
#pragma mark Move with StoryBourdID
#pragma mark ---------------------------------------------------------



+(void)movewithStoryBourdID:(UINavigationController*)navigationcontroler Id:(NSString*)strID animation:(bool)yes
{
    
    UIStoryboard *stroyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *ininavigation = [stroyboard instantiateViewControllerWithIdentifier:strID];
    [navigationcontroler pushViewController:ininavigation animated:yes];
}

#pragma mark ---------------------------------------------------------
#pragma mark Move with StoryBourdID
#pragma mark ---------------------------------------------------------



#pragma mark ---------------------------------------------------------
#pragma mark ALERT
#pragma mark ---------------------------------------------------------

+ (NSString *) checkNullString:(NSString *)string{
    if (string == nil || string == (id)[NSNull null])
        string = @"";
    return string;
}

+(UIView *)view:(NSString *)Message ViewWidth:(CGFloat)ViewWidth andHeight:(CGFloat)ViewHight myview:(UIView*)Myview

{
    
    [UIView animateWithDuration:3.0 animations:^{
        Myview.frame =  CGRectMake(0, 0, ViewWidth,30);
        Myview.backgroundColor=[UIColor redColor];
        UILabel *lableMessage= [[UILabel alloc]initWithFrame:CGRectMake(10, 5, ViewWidth, 25)];
        lableMessage.textColor=[UIColor whiteColor];
        lableMessage.text=Message;
        
        lableMessage.textAlignment = NSTextAlignmentCenter;
        lableMessage.font=[UIFont fontWithName:@"GothamBook" size:15];
        [Myview addSubview:lableMessage];
        
    }];
    return Myview;
}

#pragma for calculate mutablestring height

+(CGFloat)SizeThatFits:(CGFloat)size MutableAtrributedString:(NSMutableAttributedString*)MutableString FontSize:(float)fontSize LineSpacing:(CGFloat)lineSpace
{
    NSMutableParagraphStyle *style3 = [[NSMutableParagraphStyle alloc] init];
    style3.lineSpacing = lineSpace;
    style3.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attribute=@{NSParagraphStyleAttributeName:style3,
                              NSFontAttributeName:[UIFont fontWithName:@"GothamBook" size:fontSize]};
    [MutableString addAttributes:attribute range:NSMakeRange(0, MutableString.length)];
    CFDictionaryRef dict = (__bridge CFDictionaryRef)attribute;
    
    
    
    CFAttributedStringRef attributedString = (__bridge CFAttributedStringRef)MutableString;
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString(attributedString);
    CGSize size2 = CTFramesetterSuggestFrameSizeWithConstraints(frameSetter,CFRangeMake(0, MutableString.length), dict, CGSizeMake(size, 1000), NULL);
    
    CFRelease(frameSetter);
    return size2.height ;
    
}



+(void)showAlert:(NSString *)title andMessage:(NSString *)message andButton:(NSString *)btnTitle {
    
    UILabel *label=[UILabel new];
    label.text=title;
    label.textColor=[UIColor redColor];
    
    UIAlertView *alrt = [[UIAlertView alloc] initWithTitle:label.text message:message delegate:self cancelButtonTitle:btnTitle otherButtonTitles:nil];
    alrt.tintColor=[UIColor redColor];

    [alrt show];
    alrt = nil;
}

#pragma mark ---------------------------------------------------------
#pragma mark DEVICE ID
#pragma mark ---------------------------------------------------------

+(NSString*)Current_Device_Id{
    
    UIDevice *device = [UIDevice currentDevice];
    NSString  *Current_Device_Id = [[device identifierForVendor]UUIDString];
   // NSLog(@"%@",Current_Device_Id);
    
    return Current_Device_Id;
    
}

+(NSDictionary*)mCurrentUser{
    
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:kCurrentUser];
    NSDictionary *mCurrentUser = [NSKeyedUnarchiver unarchiveObjectWithData:data];

   // NSDictionary *mCurrentUser = [[NSUserDefaults standardUserDefaults] valueForKey:kCurrentUser];
    return mCurrentUser;
}

+(NSDictionary*)mGetProfileCurrentUser{
    NSData *data = [[NSUserDefaults standardUserDefaults]objectForKey:KGetProfileCurrentUser];
    NSDictionary *mGetProfileCurrentUser = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    return mGetProfileCurrentUser;
}


#pragma mark ---------------------------------------------------------
#pragma mark TIME STAMP
#pragma mark ---------------------------------------------------------

+(NSString*)timeStamp {
   NSString  *timeStamp = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970] * 1000];
   // NSLog(@"%@",timeStamp);
    
    return timeStamp;
}

+(NSString *)getRandomPINString:(NSInteger)length
{
    NSMutableString *returnString = [NSMutableString stringWithCapacity:length];
    
    NSString *numbers = @"0123456789";
    
    // First number cannot be 0
    [returnString appendFormat:@"%C", [numbers characterAtIndex:(arc4random() % ([numbers length]-1))+1]];
    
    for (int i = 1; i < length; i++)
    {
        [returnString appendFormat:@"%C", [numbers characterAtIndex:arc4random() % [numbers length]]];
    }
    
    return returnString;
}

+ (NSString*)date_Time_String {
    
    NSDateFormatter *dateformate=[[NSDateFormatter alloc]init];
    //[dateformate setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateformate setDateFormat:@"yyyy-MM-dd"];

    NSString *date_String =[dateformate stringFromDate:[NSDate date]];
    NSLog(@"%@",date_String);
    return date_String;
}

    
    
    + (NSString*)TempId {
        
        NSDateFormatter *dateformate=[[NSDateFormatter alloc]init];
        [dateformate setDateFormat:@"yyyyMMddHHmmss"];
        NSString *date_String =[dateformate stringFromDate:[NSDate date]];
        NSLog(@"%@",date_String);
        return date_String;
    }



#pragma mark ---------------------------------------------------------
#pragma mark DATE
#pragma mark ---------------------------------------------------------

+ (NSString*)date_String {
    
    NSDateFormatter *dateformate=[[NSDateFormatter alloc]init];
    [dateformate setDateFormat:@"YYYY-MM-dd"];
    NSString *date_String =[dateformate stringFromDate:[NSDate date]];
    NSLog(@"%@",date_String);
    return date_String;
}




+ (NSString*)GetImageUrl{
    NSString *Server_Name = [[NSUserDefaults standardUserDefaults] valueForKey:@"GetImageUrl"];
    return Server_Name;

}






#pragma mark ---------------------------------------------------------
#pragma mark BASE 64 ENCODE
#pragma mark ---------------------------------------------------------

+ (NSString*)base64EncodedStringFromImage:(UIImage *)sourceImage {
    //NSData *theData = UIImagePNGRepresentation(sourceImage);
    NSData *theData = UIImageJPEGRepresentation(sourceImage, 0.5);

    const uint8_t* input = (const uint8_t*)[theData bytes];
    NSInteger length = [theData length];
    
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    
    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data.mutableBytes;
    
    NSInteger i;
    for (i=0; i < length; i += 3) {
        NSInteger value = 0;
        NSInteger j;
        for (j = i; j < (i + 3); j++) {
            value <<= 8;
            
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        NSInteger theIndex = (i / 3) * 4;
        output[theIndex + 0] =                    table[(value >> 18) & 0x3F];
        output[theIndex + 1] =                    table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
    }
    
    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}


#pragma mark ---------------------------------------------------------
#pragma mark BASE 64 DECODE
#pragma mark ---------------------------------------------------------


+ (UIImage *)decodeBase64ToImage:(NSString *)strEncodeData {
    NSData *data = [[NSData alloc]initWithBase64EncodedString:strEncodeData options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [UIImage imageWithData:data];
}



#pragma mark ---------------------------------------------------------
#pragma mark HEXA COLOR CODE
#pragma mark ---------------------------------------------------------
+(UIColor*)colorWithHexString:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}





+(NSArray *)fetchJsonWithFileName:(NSString *)fileName {
    NSMutableArray *DataAry = [[NSMutableArray alloc]init];
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.json",fileName]];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    NSData *jsonData = [NSData dataWithContentsOfURL:url];
    
    if (jsonData) {
        NSError* error;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
        NSLog(@"%@",json);
        
        DataAry = [json objectForKey:[NSString stringWithFormat:@"%@Data",fileName]];
        
        NSLog(@"%lu",(unsigned long)DataAry.count);
        NSLog(@"%@",DataAry);
        
        
        NSLog(@"%@ File Successfully Load",fileName);
        return DataAry;
        
    }
    else
    {
        return nil;
    }
    
}



+(void)removePreviousData:(NSString *)file{
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *folderPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",file]];
    NSError *error;
    [[NSFileManager defaultManager] removeItemAtPath:folderPath error:&error];
}


+(void)writeJsonData:(NSString *)jsonString andfileName:(NSString *)fileName {
    [self removePreviousData:[NSString stringWithFormat:@"%@.json",fileName]];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.json",fileName]];
    [jsonString writeToFile:path atomically:YES];
    
    NSLog(@"%@ File Successfully Saved",fileName);
}





+(NSDictionary *)formatJSONDict:(NSDictionary *)dct {
    NSArray *dctKeys = [dct allKeys];
    NSMutableDictionary *tempDct = [[NSMutableDictionary alloc] init];
    for (NSString *strVal in dctKeys) {
        id val = [dct objectForKey:strVal];
        if (val == (id)[NSNull null]) {
            // tel is null
            [tempDct setValue:@"" forKey:strVal];
        }
        
        if ([val isKindOfClass:[NSNumber class]]) {
            NSString *tmpVal = [NSString stringWithFormat:@"%ld",(long)[val integerValue]];
            
            [tempDct setValue:tmpVal forKey:strVal];
            
        }
        if ([val isKindOfClass:[NSString class]]) {
            [tempDct setValue:val forKey:strVal];
        }
        if ([val isKindOfClass:[NSURL class]]) {
            [tempDct setValue:val forKey:strVal];
        }
   
    }
    return tempDct;
}

+(NSString *)saveImage:(UIImage*)img withName:(NSString *)imageName{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [paths objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",imageName]];
    NSData* data = UIImagePNGRepresentation(img);
    [data writeToFile:path atomically:NO];
    return path;
}

+(NSString *)documentImagePath{
    NSArray *dir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *str = dir[0];
    return str;
}


+(NSString *)docFolderPath:(NSString *)fileName {
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *folderPath = [documentsDirectory stringByAppendingPathComponent:fileName];
    return folderPath;
}


+ (void)deleteFileWithName:(NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    // Have the absolute path of file named fileName by joining the document path with fileName, separated by path separator.
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:fileName];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    // Need to check if the to be deleted file exists.
    if ([manager fileExistsAtPath:filePath]) {
        NSError *error = nil;
        // This function also returnsYES if the item was removed successfully or if path was nil.
        // Returns NO if an error occurred.
        [manager removeItemAtPath:filePath error:&error];
        if (error) {
            NSLog(@"There is an Error: %@", error);
        }
        else{
            NSLog(@"Remove Image with Image Name: %@", fileName);
        }
    } else {
        NSLog(@"File %@ doesn't exists", fileName);
    }
}







+(void)copyFile:(NSString *)fileName{
    @try {
        NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *sourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:fileName];
        NSString *folderPath = [documentsDirectory stringByAppendingPathComponent:fileName];
        NSError *error;
        [[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:folderPath
                                                 error:&error];
    }
    @catch (NSException *exception) {
        NSLog(@"%@",[exception description]);
    }
    @finally {
        
    }
}

+ (nonnull NSString *)appBundleInformation {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [NSString stringWithFormat:@"%@|%@|%@|%@|%@|%@",
            infoDictionary[@"CFBundleExecutable"],
            infoDictionary[@"CFBundleIdentifier"],
            infoDictionary[@"CFBundleName"],
            infoDictionary[@"CFBundleShortVersionString"],
            infoDictionary[@"CFBundleVersion"],
            infoDictionary[@"CFBundleDisplayName"]];
}


+(void)showLoaderVProgressHUD {
    

    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeFlat];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD showWithStatus:@"Please Wait..."];

    
//    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
//    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:93./255. green:192./255. blue:229./255. alpha:1.]];
    

    
}

+(void)hideLoaderSVProgressHUD {
    [SVProgressHUD dismiss];
}


+(BOOL)isInternetConnection{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    if (internetStatus == NotReachable) {//NotReachable
        //my web-dependent code
        NSLog(@"Not reachable");
        return NO;
    }
    else if (internetStatus == ReachableViaWiFi){
        //there-is-no-connection warning
        NSLog(@"Reachable via wifi");
        return YES;
    }
    else if (internetStatus == ReachableViaWWAN){
        //there-is-no-connection warning
        NSLog(@"Reachable via WWAN");
        return YES;
    }
    
    return NO;
}




#pragma mark ---------------------------------------------------------
#pragma mark IS_ALERT_TYPE
#pragma mark ---------------------------------------------------------

+(void)ISAlertTypeError:(NSString *)title andMessage:(NSString *)message  {
    
    [ISMessages showCardAlertWithTitle:title
                               message:message
                              duration:3.f
                           hideOnSwipe:YES
                             hideOnTap:NO
                             alertType:ISAlertTypeError
                         alertPosition:@(0).integerValue
                               didHide:^(BOOL finished) {
                                   NSLog(@"Alert did hide.");
                               }];
}



+(void)ISAlertTypeSuccess:(NSString *)title andMessage:(NSString *)message  {
    
    [ISMessages showCardAlertWithTitle:title
                               message:message
                              duration:3.f
                           hideOnSwipe:YES
                             hideOnTap:NO
                             alertType:ISAlertTypeSuccess
                         alertPosition:@(0).integerValue
                               didHide:^(BOOL finished) {
                                   NSLog(@"Alert did hide.");
                               }];
}

+(void)ISAlertTypeWarning:(NSString *)title andMessage:(NSString *)message  {
    
    [ISMessages showCardAlertWithTitle:title
                               message:message
                              duration:3.f
                           hideOnSwipe:YES
                             hideOnTap:NO
                             alertType:ISAlertTypeWarning
                         alertPosition:@(0).integerValue
                               didHide:^(BOOL finished) {
                                   NSLog(@"Alert did hide.");
                               }];
}




@end
