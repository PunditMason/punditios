//
//  PSignUpVC.m
//  IPundit
//
//  Created by Gaurav Verma on 22/09/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import "PSignUpVC.h"

@interface PSignUpVC (){
    
    NSString *message;

}

@end

@implementation PSignUpVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.ScrollView layoutIfNeeded];
    self.ScrollView.contentSize = self.ContentView.bounds.size;
    self.SignupbackgroundImageView.image = DM.backgroundImage ;
    
    if (IS_IPHONE4) {
        self.ScrollView.frame = CGRectMake(0, 0, 320, 480);
    }

}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
//    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
//    [[IQKeyboardManager sharedManager] setEnable:YES];
//    [[IQKeyboardManager sharedManager]setKeyboardDistanceFromTextField:80];
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)CloseButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}








- (IBAction)SignUpButtonAction:(id)sender{
    [self keyborddown];
    [self TextfieldVelidations];
    
    if (message) {
        // [DM.mAppObj.mBaseNavigation.view makeToast:message];
        
        
        [Helper ISAlertTypeWarning:@"Warning!" andMessage:message];
        
        
    }
    else{
        
        UIImage *UserImage =  [UIImage imageNamed:@"user_new"];
        
        if (UserImage == nil) {
            [Helper showAlert:@"" andMessage:@"Please select your profile picture" andButton:@"Ok"];
            return;
        }
        else{
            NSMutableDictionary *mWebDataDict = [[NSMutableDictionary alloc] init];
            [mWebDataDict setObject:self.mNameTextField.text forKey:@"name"];
            [mWebDataDict setObject:self.mEmailTextField.text forKey:@"email"];
            [mWebDataDict setObject:self.mPasswordTextField.text forKey:@"password"];
            
            NSString * deviceToken ;
            deviceToken = @"";
            if (DM.deviceTokenForPushNotification == nil || [DM.deviceTokenForPushNotification isKindOfClass:[NSNull class]]) {
                deviceToken = @"No deviceToken";
            }
            else{
                 deviceToken = DM.deviceTokenForPushNotification ;
                
            }
            
            
            
            [mWebDataDict setObject:deviceToken forKey:@"deviceToken"];
            [mWebDataDict setObject:[Helper base64EncodedStringFromImage:UserImage] forKey:@"cover_photo"];
            [mWebDataDict setObject:@"IOS" forKey:@"deviceType"];


            if (DM.mInternetStatus == false) {
                NSLog(@"No Internet Connection.");
                
                [Helper ISAlertTypeError:@"Internet Connection!!" andMessage:kNOInternet];
                
                return;
            }
            else{
                
                [self checkUserAndSignup:mWebDataDict];
                
            }
            
        }
    }
    message =  nil;
}



#pragma Mark ================================================================
#pragma Mark SIGNUP START
#pragma Mark ================================================================


-(void)checkUserAndSignup:(NSDictionary *)infoDict {
     [Helper showLoaderVProgressHUD];
    NSString *string = [NSString stringWithFormat:@"%@app/registerUser/",KServiceBaseURL];

    [DM PostRequest:string parameter:infoDict onCompletion:^(id  _Nullable dict) {
        NSError *errorJson=nil;
        
        NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:&errorJson];
        

        if ([[responseDict objectForKey:@"responsestatus"] integerValue] == 1) {
            NSLog(@"%@",[responseDict objectForKey:@"message"]);
            
          //  CurrentUser *currentUser = [[CurrentUser alloc] init];
            
          //  [currentUser setupCurrentUser:[[responseDict valueForKey:@"user"] objectAtIndex:0]];
            [Helper hideLoaderSVProgressHUD];
            //[self getProfile];
            [Helper ISAlertTypeSuccess:@"Nearly there..." andMessage:@"Check your email to confirm"];
            
         //   [self RegisterUseronApplogic:[[responseDict valueForKey:@"user"] objectAtIndex:0]];
            
            [self CloseButtonAction:self];
            
        }
        else{
            NSLog(@"%@",[responseDict objectForKey:@"message"]);
            [Helper hideLoaderSVProgressHUD];
            [Helper ISAlertTypeError:@"Error!!" andMessage:[responseDict objectForKey:@"message"]];
            
        }
        
        
    } onError:^(NSError * _Nullable Error) {
        [Helper hideLoaderSVProgressHUD];
        NSString *ErrorString = [NSString stringWithFormat:@"%@",Error];
        [Helper ISAlertTypeError:@"Error!!" andMessage:ErrorString];
    }];
    
}


-(void)getProfile{
    NSMutableDictionary *parametersGetProfile = [[NSMutableDictionary alloc]init];
    [parametersGetProfile setValue:[[Helper mCurrentUser]objectForKey:@"id"] forKey:@"userid"];
    NSString *path = [NSString stringWithFormat:@"%@App/get_profile",KServiceBaseURL];
    
    [DM PostRequest:path parameter:parametersGetProfile onCompletion:^(id  _Nullable dict) {
        NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
        
        if ([responseDict objectForKey:@"tags"] != [NSNull null]  ) {
            NSString *tags = [[responseDict objectForKey:@"tags"]objectForKey:@"tags"];
            DM.tags = [tags componentsSeparatedByString:@","];
            DM.tagsString = tags ;
        }
        getProfileCurrentUser *currentUser = [[getProfileCurrentUser alloc] init];
        [currentUser setupCurrentUser:[responseDict objectForKey:@"message"]];
        [Helper hideLoaderSVProgressHUD];

    } onError:^(NSError * _Nullable Error) {
        NSLog(@"%@",Error);
        [Helper hideLoaderSVProgressHUD];
    }];
    
    
}

-(void)RegisterUseronApplogic :(NSDictionary*)User{
    ALUser *user = [ALUser new];
    user.userId = [User valueForKey:@"fb_id"];
    user.password = APPLICATION_ID;
    user.email = [User valueForKey:@"email"];
    user.displayName = [User valueForKey:@"first_name"];
     NSString * string = [NSString stringWithFormat:@"%@%@",KServiceBaseProfileImageURL,[ User valueForKey:@"avatar"]];

    user.imageLink = string;
    [user setAuthenticationTypeId:(short)CLIENT];
    
    [ALUserDefaultsHandler setUserId:user.userId];
    [ALUserDefaultsHandler setPassword:user.password];
    [ALUserDefaultsHandler setEmailId:user.email];
    [ALUserDefaultsHandler setDisplayName:user.displayName];
    [ALUserDefaultsHandler setProfileImageLink:user.imageLink];
    [ALUserDefaultsHandler setUserAuthenticationTypeId:(short)CLIENT];
    ALChatManager *manager = [[ALChatManager alloc] initWithApplicationKey:APPLICATION_ID]; // SET APPLICATION ID
    [manager registerUserWithCompletion:user withHandler:^(ALRegistrationResponse *rResponse, NSError *error) {
        if (rResponse) {
            NSLog(@"%@",rResponse);
        }
        else{
            NSLog(@"%@",error);
            //[ALUtilityClass showAlertMessage:@"ERROR!!" andTitle:@"Oops!!!"];
        }
        
    }];
}





-(void)TextfieldVelidations{
    
    
    if ([self.mEmailTextField.text length ] == 0  || [self.mPasswordTextField.text length] == 0  || [self.mConfPasswordTextField.text length] == 0  || [self.mNameTextField.text length] == 0 ) {
        
        message = @"Fields can not be empty";
    }
    
    else{
        if (self.mEmailTextField.text != nil)
        {
            NSString *emailString = self.mEmailTextField.text;
            
            NSString *emailReg = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
            NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailReg];
            if (([emailTest evaluateWithObject:emailString] != YES) || [emailString isEqualToString:@""])
            {
                message = @" Enter Valid Email";
                
                self.mEmailTextField.text = nil;
            }
            
            else{
                if([self.mPasswordTextField.text isEqualToString:self.mConfPasswordTextField.text]){
                }
                else{
                    self.mPasswordTextField.text = @"" ;
                    self.mConfPasswordTextField.text = @"";
                    
                    message = @"Oops! Password does not match";
                }
            }
        }
    }
    
    
    
}





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
    int txtPosition = (textField.frame.origin.y - 200);
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
    [theTextField resignFirstResponder];
    return YES;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
