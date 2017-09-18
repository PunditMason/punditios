//
//  CurrentUser.h
//  IPundit
//
//  Created by Deepak Kumar on 07/03/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CurrentUser : NSObject

@property (nonatomic,copy) NSString       *mEmail;
@property (nonatomic,copy) NSString       *mFull_Name;
@property (nonatomic,copy) NSString       *mUserName;
@property (nonatomic,copy) NSString       *mUsers_Id;
@property (nonatomic,copy) NSString       *mUserImage;
@property (nonatomic,copy) NSString       *mMobileNo;
@property (nonatomic,copy) NSString       *mCoverPhoto;
@property (nonatomic,copy) NSString       *mFacebook;
@property (nonatomic,copy) NSString       *mUserBio;
@property (nonatomic,copy) NSString       *mTwitterId;
@property (nonatomic,copy) NSString       *mYoutube;

//@property (nonatomic,copy) NSString       *mTwitterId;
//@property (nonatomic,copy) NSString       *mUserBio;
//@property (nonatomic,copy) NSString       *mTwitterId;





-(void)setupUser:(NSDictionary *)userDict;
-(void)setupCurrentUser:(NSDictionary *)userDict;

@end
