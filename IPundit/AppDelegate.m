//
//  AppDelegate.m
//  IPundit
//
//  Created by Deepak Kumar on 28/02/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import "AppDelegate.h"
#import "SCFacebook.h"
#import "Helper.h"
#import "BroadcastMatchDetailVC.h"
#import "ListenMatchDetailVC.h"
#import "CurrentUser.h"


#define SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    

#pragma mark ====================================================================
#pragma mark ======================PUSH NOTIFICATION=============================
#pragma mark ====================================================================
    
    [self registerForNotification];
    // checks wheather app version is updated/changed then makes server call setting VERSION_CODE
    [ALRegisterUserClientService isAppUpdated];
    
    
    
    ALAppLocalNotifications *localNotification = [ALAppLocalNotifications appLocalNotificationHandler];
    [localNotification dataConnectionNotificationHandler];
    
    if ([ALUserDefaultsHandler isLoggedIn])
    {
        [ALPushNotificationService userSync];
      
    }
    
    NSLog(@"launchOptions: %@", launchOptions);
    
    if (launchOptions != nil)
    {
        NSDictionary *dictionary = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        if (dictionary != nil)
        {
            NSLog(@"Launched from push notification: %@", dictionary);
            ALPushNotificationService *pushNotificationService = [[ALPushNotificationService alloc] init];
            BOOL applozicProcessed = [pushNotificationService processPushNotification:dictionary
                                                                             updateUI:[NSNumber numberWithInt:APP_STATE_INACTIVE]];
            
            if (!applozicProcessed) {
                //Note: notification for app
            }
        }
    }
    
#pragma mark ====================================================================
#pragma mark ====================================================================
#pragma mark ====================================================================
    
    self.location = [[CLLocationManager alloc] init];
    self.location.delegate = self ;
    [self.location requestAlwaysAuthorization];
    
    

    [DataManager sharedDataManager];
    DM.tags = [[NSArray alloc]init];
    
//    [[Twitter sharedInstance] startWithConsumerKey:@"sznBzyRVILiVwQEoDGxDrMqRP" consumerSecret:@"ffCEffj2K7YVVgIHx5IrmJ2sQx1EehYEkWqqJ16ogOYB19GHQ5"];
//    [Fabric with:@[[Twitter class],[Crashlytics class]]];

    [Fabric with:@[[Crashlytics class]]];

    
    [self initfacebook];
    [self logUser];
    //[DM GetSportsList];
    
    

    
    [NSTimer scheduledTimerWithTimeInterval:30.0 target: self selector: @selector(getBreakingNews) userInfo: nil repeats: YES];
    //[self registerForRemoteNotifications];

    return [[FBSDKApplicationDelegate sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
}



#pragma mark ====================================================================
#pragma mark ====================================================================
#pragma mark ====================================================================
- (void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary*)dictionary {
    
    NSLog(@"RECEIVED_NOTIFICATION :: %@", dictionary);
    ALPushNotificationService *pushNotificationService = [[ALPushNotificationService alloc] init];
    //    [pushNotificationService processPushNotification:dictionary updateUI:[NSNumber numberWithInt:APP_STATE_INACTIVE]];
    [pushNotificationService notificationArrivedToApplication:application withDictionary:dictionary];
}
#pragma mark ====================================================================

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(nonnull void (^)(UIBackgroundFetchResult))completionHandler{
    
    NSLog(@"RECEIVED_NOTIFICATION_WITH_COMPLETION :: %@", userInfo);
    ALPushNotificationService *pushNotificationService = [[ALPushNotificationService alloc] init];
    //    [pushNotificationService processPushNotification:userInfo updateUI:[NSNumber numberWithInt:APP_STATE_BACKGROUND]];
    [pushNotificationService notificationArrivedToApplication:application withDictionary:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}


#pragma mark ====================================================================


- (void)applicationDidEnterBackground:(UIApplication *)application
{
    __block UIBackgroundTaskIdentifier task = 0;
    task=[application beginBackgroundTaskWithExpirationHandler:^{
        NSLog(@"Expiration handler called %f",[application backgroundTimeRemaining]);
        [application endBackgroundTask:task];
        task=UIBackgroundTaskInvalid;
    }];
}

#pragma mark ====================================================================

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    
    [ALPushNotificationService applicationEntersForeground];
    
    NSLog(@"APP_ENTER_IN_FOREGROUND");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"APP_ENTER_IN_FOREGROUND" object:nil];
    [application setApplicationIconBadgeNumber:0];
}




- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"Device token: %@", deviceToken.description);
    NSString * deviceTokenString = [[[[deviceToken description]
                                      stringByReplacingOccurrencesOfString: @"<" withString: @""]
                                     stringByReplacingOccurrencesOfString: @">" withString: @""]
                                    stringByReplacingOccurrencesOfString: @" " withString: @""];
    
    NSLog(@"The generated device token string is : %@",deviceTokenString);
    
    
//    if (deviceTokenString == nil || [deviceTokenString isKindOfClass:[NSNull class]]) {
//        DM.deviceTokenForPushNotification = @"No Device Token";
//    }
//    else{
//        DM.deviceTokenForPushNotification =  deviceTokenString;
//
//    }
    
    
    DM.deviceTokenForPushNotification = deviceTokenString ;
    
    
    
    NSLog(@"DEVICE_TOKEN :: %@", deviceToken);
    
    const unsigned *tokenBytes = [deviceToken bytes];
    NSString *hexToken = [NSString stringWithFormat:@"%08x%08x%08x%08x%08x%08x%08x%08x",
                          ntohl(tokenBytes[0]), ntohl(tokenBytes[1]), ntohl(tokenBytes[2]),
                          ntohl(tokenBytes[3]), ntohl(tokenBytes[4]), ntohl(tokenBytes[5]),
                          ntohl(tokenBytes[6]), ntohl(tokenBytes[7])];
    
    NSString *apnDeviceToken = hexToken;
    NSLog(@"APN_DEVICE_TOKEN :: %@", hexToken);
    
    if ([[ALUserDefaultsHandler getApnDeviceToken] isEqualToString:apnDeviceToken])
    {
        return;
    }
    
    ALRegisterUserClientService *registerUserClientService = [[ALRegisterUserClientService alloc] init];
    [registerUserClientService updateApnDeviceTokenWithCompletion:apnDeviceToken withCompletion:^(ALRegistrationResponse *rResponse, NSError *error) {
        
        if (error)
        {
            NSLog(@"REGISTRATION ERROR :: %@",error.description);
            return;
        }
        
        NSLog(@"Registration response from server : %@", rResponse);
    }];
}


#pragma mark ====================================================================


- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{

        DM.deviceTokenForPushNotification = @"";
    
    
    
    NSLog(@"Failed to get token, error: %@", error);
}

#pragma mark ====================================================================

-(void)registerForNotification
{
    if(SYSTEM_VERSION_LESS_THAN(@"10.0"))
    {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound |    UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else
    {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error)
         {
             if(!error)
             {
                 [[UIApplication sharedApplication] registerForRemoteNotifications];  // required to get the app to do anything at all about push notifications
                 NSLog(@"Push registration success." );
             }
             else
             {
                 NSLog(@"Push registration FAILED" );
                 NSLog(@"ERROR: %@ - %@", error.localizedFailureReason, error.localizedDescription );
                 NSLog(@"SUGGESTIONS: %@ - %@", error.localizedRecoveryOptions, error.localizedRecoverySuggestion );
             }
         }];
    }
}

#pragma mark ====================================================================
#pragma mark ====================================================================
#pragma mark ====================================================================




- (void)registerForRemoteNotifications {
    if(SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(@"10.0")){
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error){
            if(!error){
                [[UIApplication sharedApplication] registerForRemoteNotifications];
            }
        }];
    }
    else {
        // Code for old versions
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    
    
    ////background active
    
    
    
}








- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    [FBSDKAppEvents activateApp];
    
    // Do the following if you use Mobile App Engagement Ads to get the deferred
    // app link after your app is installed.
    [FBSDKAppLinkUtility fetchDeferredAppLink:^(NSURL *url, NSError *error) {
        if (error) {
            NSLog(@"Received error while fetching deferred app link %@", error);
        }
        if (url) {
            [[UIApplication sharedApplication] openURL:url];
        }
    }];
    

}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    // terminate
}

-(void)initfacebook{
    //Init SCFacebook
    [SCFacebook initWithReadPermissions:@[/*@"user_about_me",
                                          @"user_birthday",*/
                                          @"email"/*,
                                                   @"user_photos",
                                                   @"user_events",
                                                   @"user_friends",
                                                   @"user_videos",
                                                   @"public_profile"*/]
                     publishPermissions:@[/*@"manage_pages",*/
                                           @"publish_actions"
                                          /* @"publish_pages"*/]
     ];
    [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
    
}

#pragma mark -
#pragma mark - SCFacebook Handle

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}

-(void)LoadDataFromBundle{
    
    
    [Helper saveImage:[UIImage imageNamed:@""] withName:@"Broadcast"];
    [Helper saveImage:[UIImage imageNamed:@""] withName:@"Listen"];
    [Helper saveImage:[UIImage imageNamed:@""] withName:@"Background"];

    
    
}

- (void)logUser {
    CurrentUser * currentUser = [[CurrentUser alloc] init];
    [currentUser setupUser:[Helper mCurrentUser]];
    
    if ([currentUser.mUsers_Id length] != 0) {
        [CrashlyticsKit setUserIdentifier:currentUser.mUsers_Id];
        [CrashlyticsKit setUserEmail:currentUser.mEmail];
        [CrashlyticsKit setUserName:currentUser.mUserName];
    }
}

-(void)getBreakingNews{
    
    NSString * string = [NSString stringWithFormat:@"%@news",kServiceBaseHomePageURL];
    
    
    [DM GetRequest:string parameter:nil onCompletion:^(id  _Nullable dict) {
        NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
        NSMutableArray *breakingNews =[[NSMutableArray alloc]init];
        NSMutableArray *breakingNewsText =[[NSMutableArray alloc]init];

        breakingNews = [responseDict objectForKey:@"data"];
        for (int i = 0; i < breakingNews.count; i++) {
            [breakingNewsText addObject:[[breakingNews objectAtIndex:i]objectForKey:@"title"]];
        }
        DM.breakingNewsString = [breakingNewsText componentsJoinedByString:@" || "];
    } onError:^(NSError * _Nullable Error) {
    }];
}

//Called when a notification is delivered to a foreground app.
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler{
    NSLog(@"User Info : %@",notification.request.content.userInfo);
    completionHandler(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge);
}

//Called to let your app know which action was selected by the user for a given notification.
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler{
    NSLog(@"User Info : %@",response.notification.request.content.userInfo);
    completionHandler();
}




@end
