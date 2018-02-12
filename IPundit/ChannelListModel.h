//
//  MatchLiveFeedsModel.h
//  IPundit
//
//  Created by Gaurav Verma on 13/03/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

@interface ChannelListModel : JSONModel


@property (nonatomic) NSString <Optional> * id;
@property (nonatomic) NSString <Optional> * name;
@property (nonatomic) NSString <Optional> * match_id;
@property (nonatomic) NSString <Optional> * broadcaster_id;
@property (nonatomic) NSString <Optional> * station;
@property (nonatomic) NSString <Optional> * live;
@property (nonatomic) NSString <Optional> * appName;
@property (nonatomic) NSString <Optional> * streamName;
@property (nonatomic) NSString <Optional> * channel_type;
@property (nonatomic) NSString <Optional> * time_stamp;
@property (nonatomic) NSString <Optional> * start_time;
@property (nonatomic) NSString <Optional> * matchStatus;
@property (nonatomic) NSString <Optional> * venue;
@property (nonatomic) NSString <Optional> * match_start_date;
@property (nonatomic) NSString <Optional> * match_start_time;
@property (nonatomic) NSString <Optional> * periodId;
@property (nonatomic) NSString <Optional> * winner;
@property (nonatomic) NSString <Optional> * matchLengthMin;
@property (nonatomic) NSString <Optional> * matchLengthSec;
@property (nonatomic) NSString <Optional> * team1_id;
@property (nonatomic) NSString <Optional> * team2_id;
@property (nonatomic) NSString <Optional> * team1_score;
@property (nonatomic) NSString <Optional> * team2_score;
@property (nonatomic) NSString <Optional> * time_now;
@property (nonatomic) NSString <Optional> * country_id;
@property (nonatomic) NSString <Optional> * season_id;
@property (nonatomic) NSString <Optional> * match_week;
@property (nonatomic) NSString <Optional> * startDate;
@property (nonatomic) NSString <Optional> * endDate;
@property (nonatomic) NSString <Optional> * tournamentCalendar;
@property (nonatomic) NSString <Optional> * ruleset_id;
@property (nonatomic) NSString <Optional> * ruleset_name;
@property (nonatomic) NSString <Optional> * last_update;
@property (nonatomic) NSString <Optional> * match_date;
@property (nonatomic) NSString <Optional> * sport_id;
@property (nonatomic) NSString <Optional> * league_id;
@property (nonatomic) NSString <Optional> * start_date;
@property (nonatomic) NSString <Optional> * end_date;
@property (nonatomic) NSString <Optional> * data_id;
@property (nonatomic) NSString <Optional> * team1_name;
@property (nonatomic) NSString <Optional> * team2_name;
@property (nonatomic) NSString <Optional> * season_name;
@property (nonatomic) NSString <Optional> * broadcaster_name;
@property (nonatomic) NSString <Optional> *chatChannelid;
@property (nonatomic) NSString <Optional> *team1_twitter_id;
@property (nonatomic) NSString <Optional> *team2__twitter_id;
@end

