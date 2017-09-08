//
//  Constants.h
//  VermaTestFirebase
//
//  Created by Gaurav Verma on 21/10/16.
//  Copyright © 2016 Gaurav Verma. All rights reserved.
//

#ifndef Constants_h
#define Constants_h



 //Live Base Urls
 
#define KserviceBaseIconURL @"http://punditsports.com:81/pundit-ios/assets/img/"
#define kServiceBaseHomePageURL @"http://punditsports.com:81/pundit-ios/v1/Game/"
#define KServiceBaseURL @"http://punditsports.com:81/pundit-ios/v1/"
#define kServiceBaseURL @"http://punditsports.com:81/pundit-ios/v1/"
#define KServiceBaseProfileImageURL @"http://punditsports.com:81/pundit-ios/profileusrimg/"
// New url#define KServiceBaseShareUrl @"http://punditsports.com:81/play/index.php/Welcome/broadcast/"


 #define KServiceBaseShareUrl @"http://punditsports.com:81/play/broadcast/"


#define KServiceBasePushNotificationUrl @"http://punditsports.com:81/pundit-ios/v1/Cron/follow_notification/"


 //V2
 // http://punditsports.com:81/pundit-ios/v2/Search/sport_search
 #define KV2serviceBaseIconURL @"http://punditsports.com:81/pundit-ios/v2/"
/*

//Local DataBase Urls

#define KserviceBaseIconURL @"http://112.196.72.187/pundit-web/assets/img/"
#define kServiceBaseHomePageURL @"http://112.196.72.187/pundit-web/api/Game/"
#define KServiceBaseURL @"http://112.196.72.187/pundit-ios/v1/"
#define kServiceBaseURL @"http://112.196.72.187/pundit-ios/v1/"
#define KServiceBaseProfileImageURL @"http://112.196.72.187/pundit-web/profileusrimg/"

*/

/*
 //Main Urls
#define KserviceBaseIconURL @"http://punditsports.com:81/pundit-app/assets/img/"
#define kServiceBaseHomePageURL @"http://punditsports.com:81/pundit-app/v1/Game/"
#define KServiceBaseURL @"http://punditsports.com:81/pundit-app/v1/"
#define kServiceBaseURL @"http://punditsports.com:81/pundit-app/v1/"
#define KServiceBaseProfileImageURL @"http://punditsports.com:81/pundit-app/profileusrimg/"
#define KServiceBaseShareUrl @"http://punditsports.com:81/play/index.php/Welcome/broadcast/"
*/



#define IS_PHONE (UIUserInterfaceIdiomPhone == [[UIDevice currentDevice] userInterfaceIdiom])
#define IS_IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IS_IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IS_IPHONE5 ([[UIScreen mainScreen] bounds].size.width == 320 && [[UIScreen mainScreen] bounds].size.height > 480)
#define IS_IPHONE4 ([[UIScreen mainScreen] bounds].size.width == 320 && [[UIScreen mainScreen] bounds].size.height == 480)
#define USER_DEFAULTS [NSUserDefaults standardUserDefaults]
#define USERDEFAULTS(arg)[[NSUserDefaults standardUserDefaults] objectForKey:arg]

#define appDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])

#define kMyRiadRegular(size) [UIFont fontWithName:@"MyriadPro-Regular" size:size];
#define kMyRiadBold(size) [UIFont fontWithName:@"MyriadPro-Bold" size:size];
#define kMyRiadSemiBold(size) [UIFont fontWithName:@"MyriadPro-Semibold" size:size];




#define DM [DataManager sharedDataManager]
#define kNOInternet @"Network unavailable, please check."
#define CheckForNull(sourceStr) [Helper checkNull:sourceStr];



#define kLogin @"Login"
#define kregister @"register"
#define kprofile @"profile"
#define ksocial_login @"social_login"


#define kCurrentUser @"CurrentUser"
#define KGetProfileCurrentUser @"getProfileCurrentUser"

#define kInternetAlertMsg @"Your device is not connected to Internet. Please check your Internet Connection."

#define kDataVersion @"DataVersion"

#define USER_DEFAULTS [NSUserDefaults standardUserDefaults]
#define USERDEFAULTS(arg)[[NSUserDefaults standardUserDefaults] objectForKey:arg]


#define kPOST @"POST"
#define kGET @"GET"



#define kUser @"user"
#define kTeam @"team"
#define kSport @"sport"
#define kleague @"league"





#endif /* Constants_h */



/* 
 
 API's and Parameter's
 
 
 http://punditsports.com:81/pundit-web/api/Game/get_image
 http://punditsports.com:81/pundit-web/api/Game/follow/
 Get Request -parameters - follower_id,id
 http://punditsports.com:81/pundit-web/assets/img/league_mark/
 parameters -image name
 http://punditsports.com:81/pundit-web/assets/img/icons/
 parameters -image name
 
 
 Base - URL - http://punditsports.com:81/pundit-ios/v1/
 
 http://punditsports.com:81/pundit-ios/v1/Game/getMatchLiveFeed/
 Get Request -parameters - match id
 http://punditsports.com:81/pundit-ios/v1/app/mount
 Post Request - for broad cast start
 Parameters - name ->team vs team
 match_id,broadcaster_id,
 station ->:@"broadcast-%@-%@-%@",[[Helper mCurrentUser]objectForKey:@"id"],matchlist.match_id,[Helper timeStamp]
 streamName ->@"broadcast-%@-%@",[[Helper mCurrentUser]objectForKey:@"id"],matchlist.match_id
 appName -> @"live" Static
 channel_type -> team (or) match
 http://punditsports.com:81/pundit-ios/v1/Broadcast/unmount/
 Get Request -Perimeters- response of mount id
 http://punditsports.com:81/pundit-ios/v1/Game/getSportsname
 Get Request
 http://punditsports.com:81/pundit-ios/v1/App/get_profile
 Post Request - Parameters - userid -> current user id
 http://punditsports.com:81/pundit-ios/v1/app/update
 Post Request - Parameters - userbio,facebook,twitter,tags,youtube,id,avatar,email,name,countryid-> Constant in
 http://punditsports.com:81/pundit-ios/v1/app/login
 Post Request - Parameters - name,email,cover_photo,facebookId (Data of facebook given to us )
 
 http://punditsports.com:81/pundit-ios/v1/Game/get_match_list_filter/
 Get Request -parameters - leaquesmodel.sport_id,leaquesmodel.id,date
 http://punditsports.com:81/pundit-ios/v1/Game/get_channel_list/
 Get Request -parameters - leaquesmodel.sport_id,leaquesmodel.id,date
 http://punditsports.com:81/pundit-ios/v1/Game/leaguestat/
 Get Request -parameters - sport_id,leaque.id
 http://punditsports.com:81/pundit-web/profileusrimg/
 Parameter - avatar
 
 
 
 */

