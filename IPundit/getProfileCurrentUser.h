//
//  getProfileCurrentUser.h
//  IPundit
//
//  Created by Deepak  on 06/05/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface getProfileCurrentUser : NSObject

@property (nonatomic,copy) NSString       *mAvatar;
@property (nonatomic,copy) NSString       *mEmail;
@property (nonatomic,copy) NSString       *mFacebook;
@property (nonatomic,copy) NSString       *mFirst_name;
@property (nonatomic,copy) NSString       *mFollower;
@property (nonatomic,copy) NSString       *mFollower_id;
@property (nonatomic,copy) NSString       *mFollowing;
@property (nonatomic,copy) NSString       *mLast_name;
@property (nonatomic,copy) NSString       *mPassword;
@property (nonatomic,copy) NSString       *mTwitter;
@property (nonatomic,copy) NSString       *mUser_bio;
@property (nonatomic,copy) NSString       *mYoutube;
@property (nonatomic,copy) NSString       *mTags;




-(void)setupUser:(NSDictionary *)getProfileUserDict;

-(void)setupCurrentUser:(NSDictionary *)getProfileUserDict;

@end
