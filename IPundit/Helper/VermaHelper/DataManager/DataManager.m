//
//  DataManager.m
//  VermaTestFirebase
//
//  Created by Gaurav Verma on 21/10/16.
//  Copyright © 2016 Gaurav Verma. All rights reserved.
//

#import "DataManager.h"



static DataManager *sharedDataManager = nil;



@implementation DataManager
@synthesize mInternetStatus,mAppObj;



#pragma Mark ================================================================
#pragma Mark INITIALIZE SINGLETON OBJECT START
#pragma Mark ================================================================


+(DataManager *)sharedDataManager {
    /*
    if (!sharedDataManager) {
        sharedDataManager = [[DataManager alloc] init];
        sharedDataManager.mAppObj =  (AppDelegate *)appDelegate;
        [sharedDataManager startReachability];
        
    }
    return sharedDataManager;
    */
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedDataManager = [[DataManager alloc] init];
        sharedDataManager.mAppObj =  (AppDelegate *)appDelegate;
        [sharedDataManager startReachability];
       
    });return sharedDataManager;
    
}
#pragma Mark ================================================================
#pragma Mark INITIALIZE SINGLETON OBJECT END
#pragma Mark ================================================================










#pragma Mark ================================================================
#pragma MarkINITIALIZE AFNETWORKING OBJECT START
#pragma Mark ================================================================

-(id)init {
    if (sharedDataManager) {
        self=sharedDataManager;
    } else if (self=[super init]) {
        sharedDataManager=self;
        self.manager=[AFHTTPSessionManager manager];
    }
    return  self;
}


#pragma Mark ================================================================
#pragma Mark INITIALIZE AFNETWORKING OBJECT START
#pragma Mark ================================================================











#pragma Mark ================================================================
#pragma Mark REACHABILITY START
#pragma Mark ================================================================



-(void)startReachability {
    self.mReachability = [Reachability reachabilityWithHostname:@"www.google.com"];
    self.mReachability.reachableBlock = ^(Reachability * reachability) {
        self.mInternetStatus = true;
    };
    
    self.mReachability.unreachableBlock = ^(Reachability * reachability)
    {
        self.mInternetStatus = false;
    };
    
    [self.mReachability startNotifier];
    
    self.mLocalWiFiReach = [Reachability reachabilityForLocalWiFi];
    
    // we ONLY want to be reachable on WIFI - cellular is NOT an acceptable connectivity
    
    self.mLocalWiFiReach.reachableOnWWAN = NO;
    
    self.mLocalWiFiReach.reachableBlock = ^(Reachability * reachability)
    {
        self.mInternetStatus = true;
    };
    
    self.mLocalWiFiReach.unreachableBlock = ^(Reachability * reachability)
    {
        self.mInternetStatus = false;
    };
    
    [self.mLocalWiFiReach startNotifier];
    
    
    
    // create a Reachability object for the internet
    
    self.mInternetConnectionReach = [Reachability reachabilityForInternetConnection];
    
    self.mInternetConnectionReach.reachableBlock = ^(Reachability * reachability) {
        self.mInternetStatus = true;
    };
    
    self.mInternetConnectionReach.unreachableBlock = ^(Reachability * reachability) {
        self.mInternetStatus = false;
    };
    [self.mInternetConnectionReach startNotifier];
}


#pragma Mark ================================================================
#pragma Mark REACHABILITY END
#pragma Mark ================================================================














#pragma Mark ================================================================
#pragma Mark GET REQUEST START
#pragma Mark ================================================================


-(void)GetRequest:(NSString*)url parameter:(id)parameter onCompletion:(JSonRepresentation)completion onError:(errorBlock)Error
{
    /*
      AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
     manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
     manager.requestSerializer = [AFJSONRequestSerializer serializer];
     [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
     [self.manager.requestSerializer setTimeoutInterval:900];

    */
    
    if (DM.mInternetStatus == false) {
        NSLog(@"No Internet Connection.");
        [Helper ISAlertTypeError:@"Internet Connection!!" andMessage:kNOInternet];
        return;
    }

    
    self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [self.manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [self.manager GET:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(responseObject) {
            [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
            completion(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        Error(error);
    }];
}


#pragma Mark ================================================================
#pragma Mark GET REQUEST END
#pragma Mark ================================================================











#pragma Mark ================================================================
#pragma Mark POST REQUEST START
#pragma Mark ================================================================

-(void)PostRequest:(NSString*)url parameter:(id)parameter onCompletion:(JSonRepresentation)completion onError:(errorBlock)Error
{
    /*
     AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
     manager.requestSerializer = [AFJSONRequestSerializer serializer];
       manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
     [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
     */
    
    if (DM.mInternetStatus == false) {
        NSLog(@"No Internet Connection.");
        [Helper ISAlertTypeError:@"Internet Connection!!" andMessage:kNOInternet];
        return;
    }
    self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [self.manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"accept"];
    [self.manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    
    self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [self.manager POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSString *myString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];

         NSLog(@"%@",myString);
         if(responseObject)
         {
             completion(responseObject);
         }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         Error(error);
         NSLog(@"error: %@", error);
         
     }];
}


#pragma Mark ================================================================
#pragma Mark POST REQUEST END
#pragma Mark ================================================================













#pragma Mark ================================================================
#pragma Mark UPLOAd IMAGE END
#pragma Mark ================================================================


-(void)UploadImage:(NSString*)url image:(UIImage*)image parameter:(NSDictionary*)parameter onCompletion:(JSonRepresentation)completion onError:(errorBlock)Error
{
    if (DM.mInternetStatus == false) {
        NSLog(@"No Internet Connection.");
        [Helper ISAlertTypeError:@"Internet Connection!!" andMessage:kNOInternet];
        return;
    }

    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:url parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
                                    {
                                        NSData *imageData = UIImageJPEGRepresentation(image,0.5);
                                        [formData appendPartWithFileData:imageData name:@"image" fileName:[NSString stringWithFormat:@"_%@.jpg",[Helper date_Time_String] ]mimeType:@"image/jpg"];
                                    } error:nil];
    [self.manager setResponseSerializer:[AFJSONResponseSerializer serializer]];
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [_manager
                  uploadTaskWithStreamedRequest:request
                  progress:^(NSProgress * _Nonnull uploadProgress) {
                      // This is not called back on the main queue.
                      // You are responsible for dispatching to the main queue for UI updates
                      dispatch_async(dispatch_get_main_queue(), ^{
                          //Update the progress view
                          // [progressView setProgress:uploadProgress.fractionCompleted];
                      });
                  }
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
                      if (error)
                      {
                          Error(error);
                      } else
                      {
                          NSLog(@"%@",response);
                          completion(responseObject);
                      }
                  }];
    [uploadTask resume];
}

#pragma Mark ================================================================
#pragma Mark UPLOAd IMAGE END
#pragma Mark ================================================================














#pragma Mark ================================================================
#pragma Mark UPLOAd FILE START
#pragma Mark ================================================================

-(void)UploadFile:(NSString*)url image:(UIImage*)image filename:(NSString*)filename parameter:(NSDictionary*)parameter fileurl:(NSURL*)fileurl onCompletion:(JSonRepresentation)completion onError:(errorBlock)Error
{
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:url parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
                                    {
                                        if (image)
                                        {
                                            NSData *imageData = UIImageJPEGRepresentation(image,0.5);
                                            [formData appendPartWithFileData:imageData name:filename fileName:[NSString stringWithFormat:@"file%@.jpg",[Helper date_Time_String] ]mimeType:@"image/jpg"];
                                        }
                                        if(fileurl)
                                        {
                                            [formData appendPartWithFileURL:fileurl name:filename fileName:@"file.mp4" mimeType:@"video/mp4" error:nil];
                                        }
                                    } error:nil];
    [_manager setResponseSerializer:[AFJSONResponseSerializer serializer]];
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [_manager
                  uploadTaskWithStreamedRequest:request
                  progress:^(NSProgress * _Nonnull uploadProgress) {
                      // This is not called back on the main queue.
                      // You are responsible for dispatching to the main queue for UI updates
                      dispatch_async(dispatch_get_main_queue(), ^{
                          //Update the progress view
                          // [progressView setProgress:uploadProgress.fractionCompleted];
                      });
                  }
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
                      
                      if (error)
                      {
                          Error(error);
                      } else
                      {
                        NSLog(@"%@",response);
                        completion(responseObject);
                      }
                  }];
    [uploadTask resume];
}

#pragma Mark ================================================================
#pragma Mark UPLOAd FILE END
#pragma Mark ================================================================













#pragma Mark ================================================================
#pragma Mark ENCODE BASE64 START
#pragma Mark ================================================================

- (NSString *)EncodeToBase64String:(UIImage *)image {
    return [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

#pragma Mark ================================================================
#pragma Mark ENCODE BASE64 END
#pragma Mark ================================================================








#pragma Mark ================================================================
#pragma Mark TEST FUNCTIONS START
#pragma Mark ================================================================

- (void)TestGetAPIButtonPressed{
    NSMutableDictionary *mWebDataDict = [[NSMutableDictionary alloc] init];
    [mWebDataDict setObject:@"Gaurav Verma" forKey:@"name"];
    [mWebDataDict setObject:@"g@gmail.com" forKey:@"email"];
    NSString *path=[NSString stringWithFormat:@"http://ec2-54-194-200-74.eu-west-1.compute.amazonaws.com/pundit-web/api/Users/login/"];
    
    [DM GetRequest:path parameter:mWebDataDict onCompletion:^(id dict) {
        NSError *errorJson=nil;
        NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:&errorJson];
        NSLog(@"%@",responseDict);
    } onError:^(NSError *Error) {
        NSLog(@"%@",Error);
        NSString *ErrorString = [NSString stringWithFormat:@"%@",Error];
        [Helper ISAlertTypeError:ErrorString andMessage:kNOInternet];
    }];
    
    
}





- (void)TestPostAPIButtonPressed{
    
    NSMutableDictionary *mWebDataDict = [[NSMutableDictionary alloc] init];
    [mWebDataDict setObject:@"Gaurav Verma" forKey:@"name"];
    [mWebDataDict setObject:@"g@gmail.com" forKey:@"email"];
    NSString *path=[NSString stringWithFormat:@"http://ec2-54-194-200-74.eu-west-1.compute.amazonaws.com/pundit-web/api/Users/login/"];
    
    [DM PostRequest:path parameter:mWebDataDict onCompletion:^(id dict) {
        NSError *errorJson=nil;
        NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:&errorJson];
        NSLog(@"%@",responseDict);
    } onError:^(NSError *Error) {
        NSLog(@"%@",Error);
        NSString *ErrorString = [NSString stringWithFormat:@"%@",Error];
        [Helper ISAlertTypeError:ErrorString andMessage:kNOInternet];
        
    }];
    
}

#pragma Mark ================================================================
#pragma Mark TEST FUNCTIONS START
#pragma Mark ================================================================



-(void)marqueLabel:(MarqueeLabel*)_marqueLabel {
    
    CGFloat mScrollDuration = 0.0f;
    
    if (_marqueLabel) {
        CGSize textSize = [[_marqueLabel text] sizeWithAttributes:@{NSFontAttributeName:[_marqueLabel font]}];
        
        mScrollDuration = textSize.width;
        
        if (mScrollDuration > 100000 ) {

            mScrollDuration = mScrollDuration/20;
        }
        
        NSLog(@"%f",mScrollDuration);
    }
    
    
    


    _marqueLabel.marqueeType = MLContinuous;
    _marqueLabel.scrollDuration = mScrollDuration/210+10 ;
    _marqueLabel.animationCurve = UIViewAnimationOptionCurveEaseInOut;
    _marqueLabel.fadeLength = 10.0f;
   // _marqueLabel.leadingBuffer = 5.0f;
    //_marqueLabel.trailingBuffer = 5.0f;
    
    
  
    
}

- (CGFloat)getLabelwidth:(UILabel*)label
{
    CGSize constraint = CGSizeMake(label.frame.size.width, CGFLOAT_MAX);
    CGSize size;
    
    NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
    CGSize boundingBox = [label.text boundingRectWithSize:constraint
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:@{NSFontAttributeName:label.font}
                                                  context:context].size;
    
    size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.width));
    
    return size.height;
}

-(void)getProfile{
    NSMutableDictionary *parametersGetProfile = [[NSMutableDictionary alloc]init];
    [parametersGetProfile setValue:[[Helper mCurrentUser]objectForKey:@"id"] forKey:@"userid"];
    
    
    NSString *path = [NSString stringWithFormat:@"%@App/get_profile",KServiceBaseURL];
    
    [self PostRequest:path parameter:parametersGetProfile onCompletion:^(id  _Nullable dict) {
        NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
        NSLog(@"%@",responseDict);
                
        
      if ([responseDict objectForKey:@"tags"] != [NSNull null]  ) {
            NSString *tags = [[responseDict objectForKey:@"tags"]objectForKey:@"tags"];
          self.tagsString = tags;
       }
        getProfileCurrentUser *currentUser = [[getProfileCurrentUser alloc] init];
        
        [currentUser setupCurrentUser:[responseDict objectForKey:@"message"]];

    } onError:^(NSError * _Nullable Error) {
        NSLog(@"%@",Error);
    }];
    
}

- (UIImage *)blurredImageWithImage:(UIImage *)sourceImage{
    
    //  Create our blurred image
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [CIImage imageWithCGImage:sourceImage.CGImage];
    
    //  Setting up Gaussian Blur
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:[NSNumber numberWithFloat:15.0f] forKey:@"inputRadius"];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    
    /*  CIGaussianBlur has a tendency to shrink the image a little, this ensures it matches
     *  up exactly to the bounds of our original image */
    CGImageRef cgImage = [context createCGImage:result fromRect:[inputImage extent]];
    
    UIImage *retVal = [UIImage imageWithCGImage:cgImage];
    
    if (cgImage) {
        CGImageRelease(cgImage);
    }
    
    return retVal;
}


#pragma Mark ================================================================
#pragma Mark RED 5 PRO  BASE CODE STARTS
#pragma Mark ================================================================


-(void) onR5StreamStatus:(R5Stream *)stream withStatus:(int)statusCode withMessage:(NSString *)msg{
    NSLog(@"Status: %s", r5_string_for_status(statusCode));
    NSString* s = [NSString stringWithFormat:@"%s (%@)", r5_string_for_status(statusCode), msg];
    NSLog(@"%@",s);
    if ([s isEqualToString:@"Connected"]) {
        [ALToastView toastInView:self.refView withText:@"Streaming Started"];
    }
}


-(void) closeTest{
    
    NSLog(@"closing view");
    
    if( _publishStream != nil ){
        [_publishStream stop];
    }
    
    if( _subscribeStream != nil ){
        [_subscribeStream stop];
    }
}

-(R5Configuration*) getConfig :(NSString *)hostAddress  bufferTime:(NSString*)time
{
    
    R5Configuration* config = [[R5Configuration alloc] init];
    // config.host = @"34.253.228.132";
    //  config.host = @"54.76.147.237"; // Red 5 Pro Team Server
    //config.host = @"54.246.160.189";
    //config.host = @"34.252.62.96" 34.253.215.171
   // 34.253.213.222
    // Pundit Server Old
    if (hostAddress) {
        config.host = hostAddress;
    }
    else{
        config.host = @"34.249.129.146";
    }
    
    if (time) {
        config.buffer_time = 5 ;
        config.stream_buffer_time = 5 ;
    }else
    {
        config.buffer_time = 0.1 ;
    }
    
    config.port = 8554;
    config.contextName = @"live";
    config.protocol = 1;
    config.licenseKey = @"KWAU-2V3K-VFOJ-JXIN" ;
  /*
    config.host = @"54.76.147.237";
    config.port = 8554;
    config.contextName = @"live";
    config.protocol = 1;
    config.buffer_time = 0.1 ;
    config.licenseKey = @"KWAU-2V3K-VFOJ-JXIN" ;
 */
    return config;


}


-(void) setupPublisher:(R5Connection*)connection

{
    _publishStream = [[R5Stream alloc] initWithConnection:connection];
    _publishStream.delegate = self;

        AVCaptureDevice* audioDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
        R5Microphone* microphone = [[R5Microphone alloc] initWithDevice:audioDevice];
        microphone.bitrate = 32;
        microphone.device = audioDevice;
        NSLog(@"Got device %@", audioDevice);
        [_publishStream attachAudio:microphone];
}

/*
-(void)Play:(UIView*)view Selstream:(R5Stream*)Selectedstream streamName:(NSString*)streamName{
    self.refView = view;
    self.stream = Selectedstream;
    self.currentView attachStream:Selectedstream;
    [DM.stream play:streamName];
}
*/


#pragma Mark ================================================================
#pragma Mark  RED 5 PRO  BASE CODE STARTS
#pragma Mark ================================================================





@end
