//
//  MatchLiveFeedsModel.m
//  IPundit
//
//  Created by Gaurav Verma on 13/03/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import "ChannelListModel.h"

@implementation ChannelListModel

+(JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc]initWithModelToJSONDictionary:@{
                                                                 @"id" : @"id",
                                                                 @"name" : @"name",
                                                                 @"match_id" : @"match_id",
                                                                 @"broadcaster_id" : @"broadcaster_id",
                                                                 @"station" : @"station",
                                                                 @"live" : @"live",
                                                                 @"appName" : @"appName",
                                                                 @"streamName" : @"streamName",
                                                                 @"channel_type" : @"channel_type",
                                                                 @"time_stamp" : @"time_stamp",
                                                                 @"start_time" : @"start_time",
                                                                 @"matchStatus" : @"matchStatus",
                                                                 @"venue" : @"venue",
                                                                 @"match_start_date" : @"match_start_date",
                                                                 @"match_start_time" : @"match_start_time",
                                                                 @"periodId" : @"periodId",
                                                                 @"winner" : @"winner",
                                                                 @"matchLengthMin" : @"matchLengthMin",
                                                                 @"matchLengthSec" : @"matchLengthSec",
                                                                 @"team1_id" : @"team1_id",
                                                                 @"team2_id" : @"team2_id",
                                                                 @"team1_score" : @"team1_score",
                                                                 @"team2_score" : @"team2_score",
                                                                 @"time_now" : @"time_now",
                                                                 @"country_id" : @"country_id",
                                                                 @"season_id" : @"season_id",
                                                                 @"match_week" : @"match_week",
                                                                 @"startDate" : @"startDate",
                                                                 @"endDate" : @"endDate",
                                                                 @"tournamentCalendar" : @"tournamentCalendar",
                                                                 @"ruleset_id" : @"ruleset_id",
                                                                 @"ruleset_name" : @"ruleset_name",
                                                                 @"last_update" : @"last_update",
                                                                 @"match_date" : @"match_date",
                                                                 @"sport_id" : @"sport_id",
                                                                 @"league_id" : @"league_id",
                                                                 @"start_date" : @"start_date",
                                                                 @"end_date" : @"end_date",
                                                                 @"data_id" : @"data_id",
                                                                 @"team1_name" : @"team1_name",
                                                                 @"team2_name" : @"team2_name",
                                                                 @"season_name" : @"season_name",
                                                                 @"broadcaster_name" : @"broadcaster_name",
                                                                 @"chatChannelid" : @"chatChannelid",
                                                                 @"team1_twitter_id" : @"team1_twitter_id",
                                                                 @"team2__twitter_id" : @"team2__twitter_id",
                                                                 } ];



}



@end
