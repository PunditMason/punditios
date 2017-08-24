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
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    
    [DataManager sharedDataManager];
    DM.tags = [[NSArray alloc]init];
    
//    [[Twitter sharedInstance] startWithConsumerKey:@"sznBzyRVILiVwQEoDGxDrMqRP" consumerSecret:@"ffCEffj2K7YVVgIHx5IrmJ2sQx1EehYEkWqqJ16ogOYB19GHQ5"];
//    [Fabric with:@[[Twitter class],[Crashlytics class]]];

    [Fabric with:@[[Crashlytics class]]];

    
    [self initfacebook];
    [self logUser];
    //[DM GetSportsList];
    
    

    
    [NSTimer scheduledTimerWithTimeInterval:30.0 target: self
                                                      selector: @selector(getBreakingNews) userInfo: nil repeats: YES];
    [self registerForRemoteNotifications];

    return [[FBSDKApplicationDelegate sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
}



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


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    
    
    ////background
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotification:[NSNotification notificationWithName:@"appDidEnterForeground" object:nil]];
    
   
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    
    // again coming back
    
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


- (void)application:(UIApplication* )application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken {
    NSLog(@"Device token: %@", deviceToken.description);
    NSString * deviceTokenString = [[[[deviceToken description]
                                      stringByReplacingOccurrencesOfString: @"<" withString: @""]
                                     stringByReplacingOccurrencesOfString: @">" withString: @""]
                                    stringByReplacingOccurrencesOfString: @" " withString: @""];
    
    NSLog(@"The generated device token string is : %@",deviceTokenString);
    DM.deviceTokenForPushNotification = deviceTokenString ;
   
}

@end
