//
//  getProfileCurrentUser.m
//  IPundit
//
//  Created by Deepak  on 06/05/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import "getProfileCurrentUser.h"

#define KAvatar          @"avatar"
#define kEmail           @"email"
#define kFacebook        @"facebook"
#define kFirst_name      @"first_name"
#define kFollower        @"follower"
#define kFollower_id     @"follower_id"
#define kFollowing       @"following"
#define kLast_name       @"last_name"
#define kPassword        @"password"
#define kTwitter         @"twitter"
#define kUser_bio        @"user_bio"
#define kYoutube         @"youtube"
#define kTags            @"tags"


@implementation getProfileCurrentUser
@synthesize mAvatar,mEmail,mFacebook,mFirst_name,mFollower,mFollower_id,mFollowing,mLast_name,mPassword,mTwitter,mUser_bio,mYoutube,mTags ;







-(void)setupUser:(NSDictionary *)userDict {
    if ([userDict objectForKey:KAvatar]) {
    if ([userDict objectForKey:KAvatar] == (id) [NSNull null] || [[userDict objectForKey:KAvatar] length]==0 || [[userDict objectForKey:KAvatar] isEqualToString:@""]) {
        self.mAvatar = @"";
        }else{
        self.mAvatar = [userDict objectForKey:KAvatar];
    }
    }
    
    if ([userDict objectForKey:kEmail]) {
        if ([userDict objectForKey:kEmail] == (id) [NSNull null] || [[userDict objectForKey:kEmail] length]==0 || [[userDict objectForKey:kEmail] isEqualToString:@""]) {
            self.mEmail = @"";
        }else{
            self.mEmail = [userDict objectForKey:kEmail];
        }

    }
    
    if ([userDict objectForKey:kFacebook]) {
        if ([userDict objectForKey:kFacebook] == (id) [NSNull null] || [[userDict objectForKey:kFacebook] length]==0 || [[userDict objectForKey:kFacebook] isEqualToString:@""]) {
            self.mFacebook = @"";
        }else{
            self.mFacebook = [userDict objectForKey:kFacebook];
        }
    }
    
    if ([userDict objectForKey:kFirst_name]) {
        if ([userDict objectForKey:kFirst_name] == (id) [NSNull null] || [[userDict objectForKey:kFirst_name] length]==0 || [[userDict objectForKey:kFirst_name] isEqualToString:@""]) {
            self.mFirst_name = @"";
        }else{
            self.mFirst_name = [userDict objectForKey:kFirst_name];
        }

    }
    
    if ([userDict objectForKey:kFollower]) {
        self.mFollower = [userDict objectForKey:kFollower];
    }
    else {
        self.mFollower = @"";


    }
    if ([userDict objectForKey:kFollower_id]) {
        if ([userDict objectForKey:kFollower_id] == (id) [NSNull null] || [[userDict objectForKey:kFollower_id] length]==0 || [[userDict objectForKey:kFollower_id] isEqualToString:@""]) {
            self.mFollower_id = @"";
        }else{
            self.mFollower_id = [userDict objectForKey:kFollower_id];
        }

    }
    if ([userDict objectForKey:kFollowing]) {
        self.mFollowing = [userDict objectForKey:kFollowing];
    }
    else {
        self.mFollowing = @"";

    }
    
    if ([userDict objectForKey:kFacebook]) {
        if ([userDict objectForKey:kFacebook] == (id) [NSNull null] || [[userDict objectForKey:kFacebook] length]==0 || [[userDict objectForKey:kFacebook] isEqualToString:@""]) {
            self.mFacebook = @"";
        }else{
            self.mFacebook = [userDict objectForKey:kFacebook];
        }
    }
    if ([userDict objectForKey:kLast_name]) {
        if ([userDict objectForKey:kLast_name] == (id) [NSNull null] || [[userDict objectForKey:kLast_name] length]==0 || [[userDict objectForKey:kLast_name] isEqualToString:@""]) {
            self.mLast_name = @"";
        }else{
            self.mLast_name = [userDict objectForKey:kLast_name];
        }
    }
    if ([userDict objectForKey:kPassword]) {
        if ([userDict objectForKey:kPassword] == (id) [NSNull null] || [[userDict objectForKey:kPassword] length]==0 || [[userDict objectForKey:kPassword] isEqualToString:@""]) {
            self.mPassword = @"";
        }else{
            self.mPassword = [userDict objectForKey:kPassword];
        }
    }
    
    if ([userDict objectForKey:kTwitter]) {
        if ([userDict objectForKey:kTwitter] == (id) [NSNull null] || [[userDict objectForKey:kTwitter] length]==0 || [[userDict objectForKey:kTwitter] isEqualToString:@""]) {
            self.mTwitter = @"";
        }else{
            self.mTwitter = [userDict objectForKey:kTwitter];
        }
    }
    if ([userDict objectForKey:kUser_bio]) {
        if ([userDict objectForKey:kUser_bio] == (id) [NSNull null] || [[userDict objectForKey:kUser_bio] length]==0 || [[userDict objectForKey:kUser_bio] isEqualToString:@""]) {
            self.mUser_bio = @"";
        }else{
            self.mUser_bio = [userDict objectForKey:kUser_bio];
        }
    }
    if ([userDict objectForKey:kYoutube]) {
        if ([userDict objectForKey:kYoutube] == (id) [NSNull null] || [[userDict objectForKey:kYoutube] length]==0 || [[userDict objectForKey:kYoutube] isEqualToString:@""]) {
            self.mYoutube = @"";
        }else{
            self.mYoutube = [userDict objectForKey:kYoutube];
        }
    }
    if ([userDict objectForKey:kTags]) {
        if ([userDict objectForKey:kTags] == (id) [NSNull null] || [[userDict objectForKey:kTags] length]==0 || [[userDict objectForKey:kTags] isEqualToString:@""]) {
            self.mTags = @"";
        }else{
            self.mTags = [userDict objectForKey:kTags];
        }
    }
}



-(void)setupCurrentUser:(NSDictionary *)userDict{
    getProfileCurrentUser *currentUser = [[getProfileCurrentUser alloc] init];
    [currentUser setupUser:userDict];
    
    NSMutableDictionary *mCurrentUserDict = [[NSMutableDictionary alloc] init];
    [mCurrentUserDict setObject:currentUser.mAvatar forKey:KAvatar];
    [mCurrentUserDict setObject:currentUser.mEmail forKey:kEmail];
    [mCurrentUserDict setObject:currentUser.mFacebook forKey:kFacebook];
    [mCurrentUserDict setObject:currentUser.mFirst_name forKey:kFirst_name];
    [mCurrentUserDict setObject:currentUser.mFollower forKey:kFollower];
    [mCurrentUserDict setObject:currentUser.mFollower_id forKey:kFollower_id];
    [mCurrentUserDict setObject:currentUser.mFollowing forKey:kFollowing];
    [mCurrentUserDict setObject:currentUser.mLast_name forKey:kLast_name];
    [mCurrentUserDict setObject:currentUser.mPassword forKey:kPassword];
    [mCurrentUserDict setObject:currentUser.mTwitter forKey:kTwitter];
    [mCurrentUserDict setObject:currentUser.mUser_bio forKey:kUser_bio];
    [mCurrentUserDict setObject:currentUser.mYoutube forKey:kYoutube];
    //[mCurrentUserDict setObject:currentUser.mTags forKey:kTags];

    
    NSUserDefaults *getProfileSettings = [NSUserDefaults standardUserDefaults];
    NSData *dataSave = [NSKeyedArchiver archivedDataWithRootObject:mCurrentUserDict];
    [getProfileSettings setObject:dataSave forKey:@"getProfileCurrentUser"];
    [getProfileSettings synchronize];
    NSLog(@"Save get Profile Current User = %@",mCurrentUserDict);
    
}









@end
