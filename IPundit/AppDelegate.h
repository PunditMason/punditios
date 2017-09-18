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


#pragma mark ====================================================================
#pragma mark ============================IMPORT==================================
#pragma mark ====================================================================
#import <CoreData/CoreData.h>

#import <Applozic/ALUserDefaultsHandler.h>
#import <Applozic/ALRegisterUserClientService.h>
#import <Applozic/ALPushNotificationService.h>
#import <Applozic/ALUtilityClass.h>
//#import "ChannelVC.h"
#import "Applozic/ALDBHandler.h"
#import "Applozic/ALMessagesViewController.h"
#import "Applozic/ALPushAssist.h"
#import "Applozic/ALMessageService.h"
#import <UserNotifications/UserNotifications.h>
#import "Applozic/ALAppLocalNotifications.h"


#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

#pragma mark ====================================================================
#pragma mark ====================================================================
#pragma mark ====================================================================



@interface AppDelegate : UIResponder <UIApplicationDelegate,UNUserNotificationCenterDelegate,CLLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) CLLocationManager *location;



#pragma mark ====================================================================
#pragma mark ==========================CORE DATA=================================
#pragma mark ====================================================================

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;





#pragma mark ====================================================================
#pragma mark ====================================================================
#pragma mark ====================================================================



@end

