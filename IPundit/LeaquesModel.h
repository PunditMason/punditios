//
//  LeaquesModel.h
//  IPundit
//
//  Created by Deepak Kumar on 07/03/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>


@interface LeaquesModel : JSONModel

@property (nonatomic) NSString<Optional> *id;
@property (nonatomic) NSString<Optional> *name;
@property (nonatomic) NSString<Optional> *mark_image;
@property (nonatomic) NSString<Optional> *image_name;
@property (nonatomic) NSString<Optional> *image;
@property (nonatomic) NSString<Optional> *sport_id;
@property (nonatomic) NSString<Optional> *avatar;
@property (nonatomic) NSString<Optional> *cover_image;
@property (nonatomic) NSString<Optional> *broadcaster_count;
//@property (nonatomic) NSString<Optional> *selected_league;




@end
