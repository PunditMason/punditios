//
//  AppDelegate.h
//  IPundit
//
//  Created by Deepak Kumar on 28/02/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"
#import <Fabric/Fabric.h>
//#import <TwitterKit/TwitterKit.h>
#import <Crashlytics/Crashlytics.h>
#import <UserNotifications/UserNotifications.h>



@interface AppDelegate : UIResponder <UIApplicationDelegate,UNUserNotificationCenterDelegate>

@property (strong, nonatomic) UIWindow *window;



@end

