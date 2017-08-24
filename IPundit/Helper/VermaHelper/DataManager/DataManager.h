//
//  DataManager.h
//  VermaTestFirebase
//
//  Created by Gaurav Verma on 21/10/16.
//  Copyright © 2016 Gaurav Verma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <R5Streaming/R5Streaming.h>
#import "Reachability.h"
#import "Constants.h"
#import "SVProgressHUD.h"
#import "Helper.h"
#import "AFNetworking.h"
#import "MarqueeLabel.h"
#import "ListenVC.h"
#import "getProfileCurrentUser.h"
#import "JTCalendarManager.h"
#import "ALToastView.h"

#pragma mark - Block Definitions

typedef void(^JSonRepresentation)(id __nullable dict);
typedef void(^errorBlock)(NSError *__nullable Error);


typedef void (^SKCompletionBlock)(NSArray *__nullable result, NSError *__nullable error);
typedef void (^SKCompletionBlock1)(NSURL *__nullable result, NSError *__nullable error);
typedef void (^SKCompletionQueryBlock)(NSArray *__nullable result, NSError *__nullable error);

@class AppDelegate;


@interface DataManager : NSObject<NSURLSessionDelegate,R5StreamDelegate>

//============================ Reachability ===============================

@property(strong) Reachability *__nullable mReachability;
@property(strong) Reachability *__nullable mLocalWiFiReach;
@property(strong) Reachability *__nullable mInternetConnectionReach;
@property (nonatomic,assign)BOOL mInternetStatus;
@property (nonatomic,retain)AppDelegate *__nullable mAppObj;

@property (nonatomic,strong)NSString *__nullable breakingNewsString ;
@property (nonatomic,strong)NSString *__nullable listenersCount ;
@property (nonatomic,strong)NSString *__nullable leaqueNameForTrophyViewController ;
@property (nonatomic,strong)NSMutableDictionary *__nullable aboutPageContent;
@property (nonatomic,strong)NSString *__nullable backgroundImagePath ;
@property (nonatomic,strong)NSString *__nullable channelType ;
@property (nonatomic,strong)NSArray *__nullable tags ;
@property (nonatomic,strong)NSMutableArray *__nullable liveBroadcastersArray;
@property (nonatomic,strong)NSString *__nullable refreshRefStringForBroadCast;
@property (nonatomic,strong)NSString *__nullable refreshRefStringForListener;
@property (nonatomic,strong)NSString *__nullable tagsString ;
@property (nonatomic,strong)NSMutableDictionary *__nullable trophyViewControllerData ;
@property (nonatomic,strong)NSString *__nullable sportsIdForTrophyVC ;
@property (nonatomic,strong)NSString *__nullable leaqueIdForTrophyVC ;
@property (nonatomic,strong)NSMutableDictionary *__nullable broadCastPresentData ;
@property (nonatomic,strong)NSMutableDictionary *__nullable listenerPresentData ;
@property (nonatomic,strong)NSString *__nullable listenerPresentIcon ;
@property (nonatomic,strong)UIImage *__nullable backgroundImage;
@property (nonatomic,strong)NSString *__nullable appFlowRef ;
@property (nonatomic,strong)UIView * _Nonnull refView ;
@property (nonatomic,strong)NSString *__nullable deviceTokenForPushNotification ;



-(void)GetRequest:(NSString*__nullable)url parameter:(id __nullable)parameter onCompletion:(JSonRepresentation __nullable)completion onError:(errorBlock __nullable)Error;
-(void)PostRequest:(NSString*__nullable)url parameter:(id __nullable)parameter onCompletion: (JSonRepresentation __nullable)completion onError:(errorBlock __nullable)Error;
-(void)UploadImage:(NSString*__nullable)url image:(UIImage*__nullable)image parameter:(NSDictionary*__nullable)parameter onCompletion:(JSonRepresentation __nullable)completion onError:(errorBlock __nullable)Error;
-(void)UploadFile:(NSString*__nullable)url image:(UIImage*__nullable)image filename:(NSString*__nullable)filename parameter:(NSDictionary*__nullable)parameter fileurl:(NSURL*__nullable)fileurl onCompletion:(JSonRepresentation __nullable)completion onError:(errorBlock __nullable)Error;


@property R5VideoViewController* _Nonnull currentView;
@property R5Stream* _Nonnull publishStream;
@property R5Stream* _Nonnull subscribeStream;
@property R5Stream* _Nonnull stream;


-(void) closeTest;
-(R5Configuration*_Nonnull) getConfig;
-(void) setupPublisher:(R5Connection*_Nonnull)connection;





+(DataManager *__nullable)sharedDataManager;
-(void)startReachability;

@property (nonatomic,retain) AFHTTPSessionManager *__nullable manager;

-(void)marqueLabel:(MarqueeLabel*_Nullable)_marqueLabel ;
-(void)getProfile ;
@end
