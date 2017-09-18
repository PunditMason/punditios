//
//  BroadcasterModel.h
//  IPundit
//
//  Created by Deepak  on 28/07/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

@interface BroadcasterModel : JSONModel


@property (nonatomic) NSString<Optional> *id;
@property (nonatomic) NSString<Optional> *name;
@property (nonatomic) NSString<Optional> *match_id;
@property (nonatomic) NSString<Optional> *broadcaster_id;
@property (nonatomic) NSString<Optional> *broadcaster_name;
@property (nonatomic) NSString<Optional> *station;
@property (nonatomic) NSString<Optional> *live;
@property (nonatomic) NSString<Optional> *appName;
@property (nonatomic) NSString<Optional> *streamName;
@property (nonatomic) NSString<Optional> *channel_type;
@property (nonatomic) NSString<Optional> *time_stamp;
@property (nonatomic) NSString<Optional> *start_time;
@property (nonatomic) NSString<Optional> *last_update;
@property (nonatomic) NSString<Optional> *league_id;
@property (nonatomic) NSString<Optional> *sport_id;


@end


