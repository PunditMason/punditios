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


@interface ProfileVC (){
    bool mIsPickerEnabled;
    UIImage *chosenImage;
    NSMutableDictionary *parameters;
    
}

@end


@implementation ProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    parameters = [[NSMutableDictionary alloc]init];
    self.mHashTagArray = [[NSMutableArray alloc]init];
    [self.ScrollView layoutIfNeeded];
    self.ScrollView.contentSize = self.ContentView.bounds.size;
    
    [self PostData];

    
    CALayer *imageLayer = self.mProfileImage.layer;
    [imageLayer setCornerRadius:self.mProfileImage.frame.size.width/2];
    [imageLayer setBorderColor:[[UIColor lightGrayColor]CGColor]];
    [imageLayer setBorderWidth:1];
    [imageLayer setMasksToBounds:YES];

}

-(void)viewWillAppear:(BOOL)animated{
    
   
    [self reloadDataMHash];

    
}


-(void)PostData{
    self.mHashTagArray = [[NSMutableArray alloc]init];

    NSString * firstName = [[Helper mCurrentUser]objectForKey:@"first_name"];
    NSString * lastName = [[Helper mCurrentUser]objectForKey:@"last_name"];
    NSString * fullName = [NSString stringWithFormat:@"%@ %@",firstName,lastName];
    self.mProfileName.text = fullName ;
    NSString * string = [NSString stringWithFormat:@"%@%@",KServiceBaseProfileImageURL,[[Helper mGetProfileCurrentUser]objectForKey:@"avatar"]];
    NSURL *url = [NSURL URLWithString:string];
    if (url) {
        [self.mProfileImage sd_setImageWithURL:url];
    }
    self.mTwitterTextField.text = [[Helper mGetProfileCurrentUser]objectForKey:@"twitter"];
    self.mFacebookTextField.text = [[Helper mGetProfileCurrentUser]objectForKey:@"facebook"];
    self.mYoutubeTextField.text = [[Helper mGetProfileCurrentUser]objectForKey:@"youtube"];
    self.mBioTextView.text = [[Helper mGetProfileCurrentUser]objectForKey:@"user_bio"];    
    if (DM.tags.count != 0) {
        self.mHashTagArray = [DM.tags mutableCopy] ;
    }
    NSLog(@"%@",self.mHashTagArray);
    
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
    //self.mBuyerCollectionView.allowsSelection = YES;
    
    cell.mHashTagLable.text = [NSString stringWithFormat:@"#%@",[self.mHashTagArray objectAtIndex:indexPath.row]];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *index_path = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    NSLog(@"Selected INDEX = %@",index_path);
    
    [self.mHashTagArray removeObjectAtIndex:indexPath.row];
    [self.mCollectionView reloadData];
   
}
-(void)reloadDataMHash{
        [self.mCollectionView reloadData];
}


- (IBAction)AddTagButtonAction:(id)sender{
    
    if (self.mAddtagTextField.text.length != 0) {
        [self.mHashTagArray addObject:self.mAddtagTextField.text];
        NSLog(@"%@  %lu",self.mHashTagArray,(unsigned long)self.mHashTagArray.count);
        self.mAddtagTextField.text = nil;
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

    
  
    
   UIImage *imgobj = self.mProfileImage.image;
   NSString *string = [self.mHashTagArray componentsJoinedByString:@","];
   
    [parameters setValue:self.mBioTextView.text forKey:@"userbio"];
    [parameters setValue:self.mFacebookTextField.text forKey:@"facebook"];
    [parameters setValue:self.mTwitterTextField.text forKey:@"twitter"];
    [parameters setValue:string forKey:@"tags"];
    [parameters setValue:self.mYoutubeTextField.text forKey:@"youtube"];
    [parameters setValue:[[Helper mCurrentUser]objectForKey:@"id"] forKey:@"id"];
    [parameters setValue:[Helper base64EncodedStringFromImage:imgobj] forKey:@"coverphoto"];
    [parameters setValue:[[Helper mCurrentUser]objectForKey:@"email"] forKey:@"email"];
    [parameters setValue:[[Helper mCurrentUser]objectForKey:@"first_name"] forKey:@"name"];
    [parameters  setValue:@"in" forKey:@"countryid"];
    
    NSString *api =[NSString stringWithFormat:@"%@app/update",KServiceBaseURL];
    [DM PostRequest:api parameter:parameters onCompletion:^(id  _Nullable dict) {
        
        [Helper ISAlertTypeSuccess:@"Success" andMessage:@"Profile Updated"];
        DM.tags = [[NSArray alloc]init];
        [DM getProfile];
        
    } onError:^(NSError * _Nullable Error) {
    
        NSLog(@"Error %@",Error);
        [Helper ISAlertTypeError:@"Error" andMessage:@"Error in updating Profile"];
    }];
    
    
    
    
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
    }
}

#pragma mark ---------------------------------------------------------
#pragma mark UIIMAGEPICKER METHODS
#pragma mark ---------------------------------------------------------

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    chosenImage = info[UIImagePickerControllerEditedImage];
    chosenImage = [chosenImage scaledToSize:CGSizeMake(320 ,320)];
    self.mProfileImage.image = chosenImage;
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


- (void) animateTextView: (UITextView*) textView up: (BOOL) up{
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
