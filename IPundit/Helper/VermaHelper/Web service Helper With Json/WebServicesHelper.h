//
//  WebServicesHelper.h
//  Coupon
//
//  Created by Gaurav Verma on 24/08/15.
//  Copyright (c) 2015 Gaurav Verma. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol WebserviceControllerDelegate <NSObject>   //define delegate protocol
- (void)serviceResponseReceived: (NSDictionary *) mdict;  //define delegate method to be implemented within another class
- (void)webserviceError:(NSString *)errorStr;  //define delegate method to be implemented within another class
@end //end protocol



@interface WebServicesHelper : NSObject <NSURLConnectionDelegate>{
    NSMutableData *_responseData;

}
@property (nonatomic, strong) id <WebserviceControllerDelegate> serviceDelegate;

-(void)sendServerRequest:(NSDictionary *)dct andAPI:(NSString *)api andMethod:(NSString *)GET_POST_Method;
/*
 =========.h===========
 #import "WebServicesHelper.h"

 <WebserviceControllerDelegate> {
 WebServicesHelper *mWebEngineObj;
 
 =========.m===========
 mWebEngineObj = [[WebServicesHelper alloc] init];
 mWebEngineObj.serviceDelegate = self;
 
 
 mWebDataDict = [[NSMutableDictionary alloc] init];
 [mWebDataDict setObject:@"Value" forKey:@"Key"];
 [mWebEngineObj sendServerRequest:mWebDataDict andAPI:@"Service Name"];

 
 - (void)serviceResponseReceived: (NSDictionary *) mdict {
 NSLog(@"%@",mdict);
 
 }
 
 
*/



@end
