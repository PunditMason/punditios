//
//  SportsModel.m
//  IPundit
//
//  Created by Deepak Kumar on 07/03/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import "SportsModel.h"

@implementation SportsModel
@synthesize league;

+(JSONKeyMapper *)keyMapper
{
    
    
    return [[JSONKeyMapper alloc]initWithModelToJSONDictionary:@{
                                                                 @"id": @"id",
                                                                 @"name": @"name",
                                                                 @"avatar": @"ios_icon",
                                                                 @"image_name": @"image_name",
                                                                 @"league": @"league",
                                                                 @"cover_image" : @"ios_cover_image",
                                                                 @"mark_image" : @"ios_mark_image",
                                                                 @"broadcaster_count" : @"broadcaster_count",
                                                                 } ];
}





//@"league": @{@"id": @"id",
//@"name": @"name",
//@"mark_image": @"mark_image",
//@"sport_id": @"sport_id",
//@"image": @"image",
//@"image_name": @"image_name",
//}


@end
