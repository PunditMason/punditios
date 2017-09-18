//
//  MatchListModel.h
//  IPundit
//
//  Created by Deepak Kumar on 08/03/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

@interface MatchListModel : JSONModel
@property (nonatomic) NSString <Optional> *id;
@property (nonatomic) NSString <Optional> *match_id;
@property (nonatomic) NSString <Optional> *matchStatus;
@property (nonatomic) NSString <Optional> *venue;
@property (nonatomic) NSString <Optional> *match_start_date;
@property (nonatomic) NSString <Optional> *match_start_time;
@property (nonatomic) NSString <Optional> *periodId;
@property (nonatomic) NSString <Optional> *winner;
@property (nonatomic) NSString <Optional> *matchLengthMin;
@property (nonatomic) NSString <Optional> *matchLengthSec;
@property (nonatomic) NSString <Optional> *team1_id;
@property (nonatomic) NSString <Optional> *team2_id;
@property (nonatomic) NSString <Optional> *team1_score;
@property (nonatomic) NSString <Optional> *team2_score;
@property (nonatomic) NSString <Optional> *time_now;
@property (nonatomic) NSString <Optional> *country_id;
@property (nonatomic) NSString <Optional> *season_id;
@property (nonatomic) NSString <Optional> *match_week;
@property (nonatomic) NSString <Optional> *startDate;
@property (nonatomic) NSString <Optional> *endDate;
@property (nonatomic) NSString <Optional> *tournamentCalendar;
@property (nonatomic) NSString <Optional> *ruleset_id;
@property (nonatomic) NSString <Optional> *ruleset_name;
@property (nonatomic) NSString <Optional> *last_update;
@property (nonatomic) NSString <Optional> *match_date;
@property (nonatomic) NSString <Optional> *data_id;
@property (nonatomic) NSString <Optional> *team1_name;
@property (nonatomic) NSString <Optional> *team2_name;
@property (nonatomic) NSString <Optional> *season_name;
@property (nonatomic) NSString <Optional> *chatChannelid;




@end
