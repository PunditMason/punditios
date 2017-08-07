//
//  BroadcasterModel.m
//  IPundit
//
//  Created by Deepak  on 28/07/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import "BroadcasterModel.h"

@implementation BroadcasterModel


+(JSONKeyMapper *)keyMapper
{
    
    return [[JSONKeyMapper alloc]initWithModelToJSONDictionary:@{
                                        @"id": @"id",
                                        @"name": @"name",
                                        @"match_id": @"match_id",
                                        @"broadcaster_id": @"broadcaster_id",
                                        @"broadcaster_name": @"broadcaster_name",
                                        @"station" : @"station",
                                        @"live" : @"live",
                                        @"appName" : @"appName",
                                        @"streamName": @"streamName",
                                        @"channel_type": @"channel_type",
                                        @"time_stamp": @"time_stamp",
                                        @"start_time": @"start_time",
                                        @"last_update": @"last_update",
                                        @"league_id" : @"league_id",
                                        @"sport_id" : @"sport_id",} ];
}

@end
/*
 
 id: "321",
 name: "Henan Jianye Vs Beijing Guoan-Nav Singh ",
 match_id: "1k4owoe38c1k045c85rhqvmcp",
 broadcaster_id: "443",
 broadcaster_name: "Nav Singh ",
 station: "443-1k4owoe38c1k045c85rhqvmcp-z81lV",
 live: "1",
 appName: "live",
 streamName: "443-1k4owoe38c1k045c85rhqvmcp-z81lV",
 channel_type: "match",
 time_stamp: "2017-07-28 09:58:13",
 start_time: "09:58:13",
 last_update: "0000-00-00 00:00:00",
 league_id: "bo69dtzfanugqk3w278gppxwp",
 sport_id: "289u5typ3vp4ifwh5thalohmq"
 
 */
