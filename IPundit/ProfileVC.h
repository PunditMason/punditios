//
//  ProfileVC.h
//  
//
//  Created by Deepak Kumar on 28/02/17.
//
//

#import <UIKit/UIKit.h>
#import "UIImage+Additions.h"

@interface ProfileVC : UIViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate>{
    UIImagePickerController *cameraUI;
}
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;

- (IBAction)BackButtonAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *subView;

@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;
@property (weak, nonatomic) IBOutlet UIView *ContentView;

@property (nonatomic,strong) NSMutableArray *mHashTagArray;
@property (nonatomic,weak)IBOutlet UICollectionView *mCollectionView;

@property (nonatomic,weak)IBOutlet UITextField *mAddtagTextField;
@property (nonatomic,weak)IBOutlet UITextField *mYoutubeTextField;
@property (nonatomic,weak)IBOutlet UITextField *mFacebookTextField;
@property (nonatomic,weak)IBOutlet UITextField *mTwitterTextField;
@property (nonatomic,weak)IBOutlet UITextView *mBioTextView;
@property (weak, nonatomic) IBOutlet UILabel *mProfileName;
@property (weak, nonatomic) IBOutlet UILabel *mProfileFollowingLabel;
@property (weak, nonatomic) IBOutlet UILabel *mProfileFollowersLabel;


@property (nonatomic,weak)IBOutlet UIImageView *mProfileImage;
@property (weak, nonatomic) IBOutlet UIImageView *mProfileImageBlurView;

- (IBAction)AddTagButtonAction:(id)sender;
-(IBAction)profilePicButtonAction:(id)sender;
- (IBAction)saveButtonAction:(id)sender;
- (IBAction)deleteButtonTap:(id)sender;
- (IBAction)nameTextFieldTap:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UIImageView *deleteButtonImageView;
@property (strong, nonatomic) IBOutlet UIImageView *editProfileImageView;

@end
