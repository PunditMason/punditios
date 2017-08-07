//
//  CurrentUser.m
//  IPundit
//
//  Created by Deepak Kumar on 07/03/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//




#import "CurrentUser.h"

#define kEmail          @"email"
#define kFull_name      @"first_name"
#define kUsername       @"last_name"
#define kUserId         @"id"
#define kUserImage      @"avatar"
#define kMobileNo       @"mobileNo"
#define kcover_photo    @"cover_photo"
#define kFacebook       @"facebook"
#define kuser_bio       @"user_bio"
#define kTwitter        @"twitter"
#define kYoutube        @"youtube"

@implementation CurrentUser
@synthesize mEmail,mFull_Name,mUserName,mUsers_Id,mUserImage,mMobileNo,mCoverPhoto,mFacebook,mUserBio,mTwitterId,mYoutube;



-(void)setupUser:(NSDictionary *)userDict {
    if ([userDict objectForKey:kEmail]) {
        self.mEmail = [userDict objectForKey:kEmail];
    }
    else {
        self.mEmail = @"";
    }
    
    if ([userDict objectForKey:kFull_name]) {
        self.mFull_Name = [userDict objectForKey:kFull_name];
    }
    else {
        self.mFull_Name = @"";
    }
    
    if ([userDict objectForKey:kUsername]) {
        self.mUserName = [userDict objectForKey:kUsername];
    }
    else {
        self.mUserName = @"";
    }
    
    if ([userDict objectForKey:kUserId]) {
        self.mUsers_Id = [userDict objectForKey:kUserId];
    }
    else {
        self.mUsers_Id = @"";
    }
    
    if ([userDict objectForKey:kUserImage]) {
        self.mUserImage = [userDict objectForKey:kUserImage];
    }
    else {
        self.mUserImage = @"";
    }
    if ([userDict objectForKey:kMobileNo]) {
        self.mMobileNo = [userDict objectForKey:kMobileNo];
    }
    else {
        self.mMobileNo = @"";
    }
    if ([userDict objectForKey:kcover_photo]) {
        self.mCoverPhoto = [userDict objectForKey:kcover_photo];
    }
    else {
        self.mCoverPhoto = @"";
    }
    
    if ([userDict objectForKey:kFacebook]) {
        self.mFacebook = [userDict objectForKey:kFacebook];
    }
    else {
        self.mFacebook = @"";
    }
    if ([userDict objectForKey:kuser_bio]) {
        self.mUserBio = [userDict objectForKey:kuser_bio];
    }
    else {
        self.mUserBio = @"";
    }
    if ([userDict objectForKey:kTwitter]) {
        self.mTwitterId = [userDict objectForKey:kTwitter];
    }
    else {
        self.mTwitterId = @"";
    }
    
    if ([userDict objectForKey:kFacebook]) {
        self.mFacebook = [userDict objectForKey:kFacebook];
    }
    else {
        self.mFacebook = @"";
    }
    if ([userDict objectForKey:kuser_bio]) {
        self.mUserBio = [userDict objectForKey:kuser_bio];
    }
    else {
        self.mUserBio = @"";
    }
    if ([userDict objectForKey:kYoutube]) {
        self.mYoutube = [userDict objectForKey:kYoutube];
    }
    else {
        self.mYoutube = @"";
    }
}




-(void)setupCurrentUser:(NSDictionary *)userDict{
    CurrentUser *currentUser = [[CurrentUser alloc] init];
    [currentUser setupUser:userDict];
    
    NSMutableDictionary *mCurrentUserDict = [[NSMutableDictionary alloc] init];
    [mCurrentUserDict setObject:currentUser.mEmail forKey:kEmail];
    [mCurrentUserDict setObject:currentUser.mFull_Name forKey:kFull_name];
    [mCurrentUserDict setObject:currentUser.mUserName forKey:kUsername];
    [mCurrentUserDict setObject:currentUser.mUsers_Id forKey:kUserId];
    [mCurrentUserDict setObject:currentUser.mUserImage forKey:kUserImage];
    [mCurrentUserDict setObject:currentUser.mMobileNo forKey:kMobileNo];
    [mCurrentUserDict setObject:currentUser.mCoverPhoto forKey:kcover_photo];
    [mCurrentUserDict setObject:currentUser.mFacebook forKey:kFacebook];
    [mCurrentUserDict setObject:currentUser.mUserBio forKey:kuser_bio];
    [mCurrentUserDict setObject:currentUser.mTwitterId forKey:kTwitter];
    [mCurrentUserDict setObject:currentUser.mYoutube forKey:kYoutube];
    

    
    
    
    
    
    
    
    NSUserDefaults *Settings = [NSUserDefaults standardUserDefaults];
    NSData *dataSave = [NSKeyedArchiver archivedDataWithRootObject:mCurrentUserDict];
    [Settings setObject:dataSave forKey:@"CurrentUser"];
    [Settings synchronize];
    NSLog(@"Save Current User = %@",mCurrentUserDict);
    
}



@end
