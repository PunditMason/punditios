//
//  MatchListModel.m
//  IPundit
//
//  Created by Deepak Kumar on 08/03/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import "MatchListModel.h"

@implementation MatchListModel



+(JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc]initWithModelToJSONDictionary:@{
                                                                 @"id" : @"id",
                                                                 @"match_id" : @"match_id",
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
                                                                 @"data_id" : @"data_id",
                                                                 @"team1_name" : @"team1_name",
                                                                 @"team2_name" : @"team2_name",
                                                                 @"season_name" : @"season_name",
                                                                 @"chatChannelid" : @"chatChannelid",
                                                                                                                                 } ];
}











@end
