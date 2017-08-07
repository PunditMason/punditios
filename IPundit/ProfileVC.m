//
//  ProfileVC.m
//  
//
//  Created by Deepak Kumar on 28/02/17.
//
//

#import "ProfileVC.h"
#import "ProfileHashTagCell.h"
#import "CurrentUser.h"
#import "WebServicesHelper.h"
#import "DataManager.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Additions.h"

@interface ProfileVC (){
    bool mIsPickerEnabled;
    UIImage *chosenImage;
    NSMutableDictionary *parameters;
    
}

@end


@implementation ProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backgroundImageView.image = DM.backgroundImage ;
    
    if (IS_IPHONE4) {
        self.view.frame = CGRectMake(0, 0, 320, 480);
        self.backgroundImageView.frame = CGRectMake(0, 0, 320, 480);
        self.ContentView.frame = CGRectMake(0, 0, 320, 700);
    }
    self.mCollectionView.hidden = YES ;

    parameters = [[NSMutableDictionary alloc]init];
    self.mHashTagArray = [[NSMutableArray alloc]init];
    [self.ScrollView layoutIfNeeded];
    self.ScrollView.contentSize = self.ContentView.bounds.size;
    
    [self PostData];
    
    self.mAddtagTextField.autocorrectionType = UITextAutocorrectionTypeNo;

    CALayer *imageLayer = self.mProfileImage.layer;
    [imageLayer setCornerRadius:self.mProfileImage.frame.size.width/2];
    [imageLayer setBorderColor:[[UIColor grayColor]CGColor]];
    [imageLayer setBorderWidth:1];
    [imageLayer setMasksToBounds:YES];

}

-(void)viewWillAppear:(BOOL)animated{
    
   
    [self reloadDataMHash];

    
}


-(void)PostData{
    self.mHashTagArray = [[NSMutableArray alloc]init];
    NSString * fullName = [NSString stringWithFormat:@"%@",[[Helper mGetProfileCurrentUser]objectForKey:@"first_name"] ];

    self.nameTextField.text = fullName ;
    NSString * string = [NSString stringWithFormat:@"%@%@",KServiceBaseProfileImageURL,[[Helper mGetProfileCurrentUser]objectForKey:@"avatar"]];
    NSURL *url = [NSURL URLWithString:string];
    if (url)
    {
        [self.mProfileImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"No-following-min"]];
        [self.mProfileImage sd_setImageWithURL:url completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            UIImage *img1 = [UIImage blur:image withRadius:10.0f];
            self.mProfileImageBlurView.image = img1;
        }];
    }
    self.mTwitterTextField.text = [[Helper mGetProfileCurrentUser]objectForKey:@"twitter"];
    self.mFacebookTextField.text = [[Helper mGetProfileCurrentUser]objectForKey:@"facebook"];
    self.mYoutubeTextField.text = [[Helper mGetProfileCurrentUser]objectForKey:@"youtube"];
    self.mBioTextView.text = [[Helper mGetProfileCurrentUser]objectForKey:@"user_bio"];
   
    if (DM.tagsString.length > 0)
    {
        NSArray *refArray = [[NSArray alloc]init];
        refArray = [DM.tagsString componentsSeparatedByString:@","];
        self.mHashTagArray = [refArray mutableCopy];
        self.mCollectionView.hidden = NO;
        
        if (_mHashTagArray.count == 1 || _mHashTagArray.count == 2) {
            [UIView animateWithDuration:0.5f animations:^{
                self.subView.frame = CGRectMake(0,382,320,200);
            }];
        }else{
        self.subView.frame = CGRectMake(0, 425, 320, 200);
        }
    }else{
         self.subView.frame = CGRectMake(0, 340, 320, 200);
    }
    self.mProfileFollowersLabel.text = [NSString stringWithFormat:@"%@",[[Helper mGetProfileCurrentUser]objectForKey:@"follower"]];
    self.mProfileFollowingLabel.text = [NSString stringWithFormat:@"%@",[[Helper mGetProfileCurrentUser]objectForKey:@"following"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.mHashTagArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ProfileHashTagCell *cell = [self.mCollectionView dequeueReusableCellWithReuseIdentifier:@"ProfileHashTagCell" forIndexPath:indexPath];
    self.mCollectionView.allowsMultipleSelection = NO;
    cell.mHashTagLable.text = [NSString stringWithFormat:@"%@",[self.mHashTagArray objectAtIndex:indexPath.row]];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *index_path = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    
    [self.mHashTagArray removeObjectAtIndex:indexPath.row];
    [self.mCollectionView reloadData];
    if (_mHashTagArray.count == 0) {
        self.mCollectionView.hidden = YES;
        [UIView animateWithDuration:0.5f animations:^{
            self.subView.frame = CGRectMake(0,340,320,200);
        }];
    }
    if (_mHashTagArray.count == 1 || _mHashTagArray.count == 2) {
        [UIView animateWithDuration:0.5f animations:^{
            self.subView.frame = CGRectMake(0,382,320,200);
        }];
    }

}
-(void)reloadDataMHash{
        [self.mCollectionView reloadData];
}


- (IBAction)AddTagButtonAction:(id)sender{
    NSString *string ;
    if (self.mAddtagTextField.text.length != 0) {
        if ([self.mAddtagTextField.text hasPrefix:@"#"]) {
           string  = [NSString stringWithFormat:@"%@",self.mAddtagTextField.text];
        }else{
            string  = [NSString stringWithFormat:@"#%@",self.mAddtagTextField.text];
        }
        self.mCollectionView.hidden = NO;
        [self.mHashTagArray addObject:string];
        self.mAddtagTextField.text = nil;
        
        if (_mHashTagArray.count == 1 || _mHashTagArray.count == 2) {
            [UIView animateWithDuration:0.5f animations:^{
                self.subView.frame = CGRectMake(0,382,320,200);
            }];
        }else{
            [UIView animateWithDuration:0.5f animations:^{
                self.subView.frame = CGRectMake(0,425, 320, 200);
            }];
        }

        
        [self.mCollectionView reloadData];
        

    }
    
    
}








#pragma mark ---------------------------------------------------------
#pragma mark IMAGE PICKER
#pragma mark ---------------------------------------------------------


-(IBAction)profilePicButtonAction:(id)sender {
    BOOL cameraDeviceAvailable = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    BOOL photoLibraryAvailable = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
    
    if (cameraDeviceAvailable && photoLibraryAvailable) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo", @"Choose Photo", nil];
        [actionSheet showInView:self.view];
    } else {
        [self shouldPresentPhotoCaptureController];
    }
}

- (IBAction)saveButtonAction:(id)sender {

   [Helper showLoaderVProgressHUD];
  
   UIImage *imgobj = self.mProfileImage.image;
   NSString *string = [self.mHashTagArray componentsJoinedByString:@","];
   
    [parameters setValue:self.mBioTextView.text forKey:@"userbio"];
    [parameters setValue:self.mFacebookTextField.text forKey:@"facebook"];
    [parameters setValue:self.mTwitterTextField.text forKey:@"twitter"];
    [parameters setValue:string forKey:@"tags"];
    [parameters setValue:self.mYoutubeTextField.text forKey:@"youtube"];
    [parameters setValue:[[Helper mCurrentUser]objectForKey:@"id"] forKey:@"id"];
    [parameters setValue:[Helper base64EncodedStringFromImage:imgobj] forKey:@"avatar"];
    [parameters setValue:[[Helper mCurrentUser]objectForKey:@"email"] forKey:@"email"];
    [parameters setValue:self.nameTextField.text forKey:@"name"];
    NSLocale *currentLocale = [NSLocale currentLocale];
    NSString *countryCode = [currentLocale objectForKey:NSLocaleCountryCode];
    [parameters setValue:countryCode forKey:@"countryid"];
    
    NSString *api =[NSString stringWithFormat:@"%@app/update",KServiceBaseURL];
        [DM PostRequest:api parameter:parameters onCompletion:^(id  _Nullable dict) {
        [Helper hideLoaderSVProgressHUD];
        [Helper ISAlertTypeSuccess:@"Success" andMessage:@"Profile Updated"];
         DM.tags = [[NSArray alloc]init];
        [DM getProfile];
        
    } onError:^(NSError * _Nullable Error) {
    
        [Helper hideLoaderSVProgressHUD];
        [Helper ISAlertTypeError:@"Error" andMessage:@"Error in updating Profile"];
    }];
}

- (IBAction)deleteButtonTap:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                    message:@"Do you want to delete this image"
                                                   delegate:self
                                          cancelButtonTitle:@"Yes"
                                          otherButtonTitles:@"No", nil];
    [alert show];
    }

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    // the user clicked OK
    if (buttonIndex == 0) {
        self.mProfileImage.image = [UIImage imageNamed:@"funky-circle"];
        UIImage *img1 = [UIImage blur:[UIImage imageNamed:@"funky-circle"] withRadius:10.0f];
        self.mProfileImageBlurView.image =img1 ;

    }
}


- (IBAction)nameTextFieldTap:(id)sender {
}



- (BOOL)shouldPresentPhotoCaptureController {
    BOOL presentedPhotoCaptureController = [self shouldStartCameraController];
    
    if (!presentedPhotoCaptureController) {
        presentedPhotoCaptureController = [self shouldStartPhotoLibraryPickerController];
    }
    
    return presentedPhotoCaptureController;
}

- (BOOL)shouldStartCameraController {
    mIsPickerEnabled  = true;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] == NO) {
        return NO;
    }
    
    cameraUI = [[UIImagePickerController alloc] init];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]) {
            cameraUI.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        } else if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]) {
            cameraUI.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        }
        
    } else {
        return NO;
    }
    
    cameraUI.allowsEditing = YES;
    cameraUI.showsCameraControls = YES;
    cameraUI.delegate = self;
    
    [self presentViewController:cameraUI animated:YES completion:nil];
    
    return YES;
    }

- (BOOL)shouldStartPhotoLibraryPickerController {

     mIsPickerEnabled  = true;
    if (([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary] == NO
         && [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum] == NO)) {
        return NO;
    }
    cameraUI = [[UIImagePickerController alloc] init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        cameraUI.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
    } else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
        
        cameraUI.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        
    } else {
        return NO;
    }
    cameraUI.allowsEditing = YES;
    cameraUI.delegate = self;
    [self presentViewController:cameraUI animated:YES completion:nil];
    return YES;
}



#pragma mark ---------------------------------------------------------
#pragma mark UIACTIONSHEET DELEGATE METHODS
#pragma mark ---------------------------------------------------------

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    
    if (buttonIndex == 0) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            [self shouldStartCameraController];
        }];
    } else if (buttonIndex == 1) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            [self shouldStartPhotoLibraryPickerController];
        }];
    }else if (buttonIndex == 2){
       
    }
    
}

#pragma mark ---------------------------------------------------------
#pragma mark UIIMAGEPICKER METHODS
#pragma mark ---------------------------------------------------------

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    chosenImage = info[UIImagePickerControllerEditedImage];
    chosenImage = [chosenImage scaledToSize:CGSizeMake(320 ,320)];
    self.mProfileImage.image = chosenImage;
    UIImage *img1 = [UIImage blur:chosenImage withRadius:10.0f];
    self.mProfileImageBlurView.image =img1 ;
    
       [picker dismissViewControllerAnimated:YES completion:NULL];
}




- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    mIsPickerEnabled  = false;
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    
}








#pragma mark ---------------------------------------------------------
#pragma mark KEYBORD AUTO MOVE VIEW START
#pragma mark ---------------------------------------------------------

-(void)keyborddown{
    
    [self.view endEditing:YES];
}



- (IBAction)textFieldDoneEditing:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)backgroundTap:(id)sender {
    [self keyborddown];
    
}





- (void) animateTextField: (UITextField*) textField up: (BOOL) up{
    int txtPosition = (textField.frame.origin.y - 110);
    const int movementDistance = (txtPosition < 0 ? 0 : txtPosition); // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.ContentView.frame = CGRectOffset(self.ContentView.frame, 0, movement);
    [UIView commitAnimations];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [self animateTextField: textField up: YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self animateTextField: textField up: NO];
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    NSInteger nextTag = theTextField.tag + 1;
    UIResponder* nextResponder = [theTextField.superview viewWithTag:nextTag];
    if (nextResponder) {
        [nextResponder becomeFirstResponder];
    } else {
        [theTextField resignFirstResponder];
    }
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == self.mAddtagTextField) {
        if ([string isEqualToString:@" "]||[string isEqualToString:@"#"]){
            return NO;
        }
        else {
            return YES;
        }
        
    }
    return YES;
}

- (void) animateTextView:(UITextView*) textView up: (BOOL) up{
    int txtPosition = (textView.frame.origin.y - 110);
    const int movementDistance = (txtPosition < 0 ? 0 : txtPosition); // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.ContentView.frame = CGRectOffset(self.ContentView.frame, 0, movement);
    [UIView commitAnimations];
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    [self animateTextView: textView up: YES];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    [self animateTextView: textView up: NO];
}





#pragma mark ---------------------------------------------------------
#pragma mark  KEYBORD AUTO MOVE VIEW END
#pragma mark ---------------------------------------------------------







/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)BackButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}


@end
