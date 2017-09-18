//
//  LeaquesModel.m
//  IPundit
//
//  Created by Deepak Kumar on 07/03/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import "LeaquesModel.h"

@implementation LeaquesModel


+(JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc]initWithModelToJSONDictionary:@{
                                                                 @"id": @"id",
                                                                 @"name": @"name",
                                                                 @"mark_image": @"ios_mark_image",
                                                                 @"sport_id": @"sport_id",
                                                                 @"avatar": @"ios_icon",
                                                                 @"image_name": @"image_name",
                                                                 @"cover_image" : @"ios_cover_image",
                                                                 @"broadcaster_count" : @"broadcaster_count",
                                                                 } ];
}








@end
