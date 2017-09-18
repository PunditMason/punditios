//
//  CVBWebsiteVC.m
//  Dalton_iGuide
//
//  Created by Bhupinder Verma on 22/08/15.
//
//

#import "OTMWebView.h"
#import "OTMWebViewProgressBar.h"
#import "PIURLUtils.h"
#import "MBProgressHUD.h"
#import "CVBWebsiteVC.h"
@interface CVBWebsiteVC ()<OTMWebViewDelegate>{
    MBProgressHUD *HUD;
}
@property (strong, nonatomic) OTMWebView *webView;
@property (strong, nonatomic) OTMWebViewProgressBar *progressBar;

@end

@implementation CVBWebsiteVC
@synthesize webURL,titleStr;
- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    self.mTopTitleLable.text = @"Loading...";
    self.webView = [[OTMWebView alloc]initWithFrame:CGRectZero];
    self.webView.translatesAutoresizingMaskIntoConstraints = NO;
    self.webView.delegate = self;
    self.webView.scalesPageToFit = YES;
    self.webView.frame = CGRectMake(self.mTopBarView.frame.origin.x,self.mTopBarView.frame.origin.y+self.mTopBarView.frame.size.height,self.mTopBarView.frame.size.width,self.view.frame.size.height-self.mTopBarView.frame.size.height);
    [self.view addSubview:self.webView];
    
    self.progressBar = [[OTMWebViewProgressBar alloc]init];
    CGFloat progressBarHeight = 3.0;
    self.progressBar.tintColor = [UIColor whiteColor];
    self.progressBar.frame = CGRectMake(0,self.mTopBarView.frame.size.height-4,self.view.frame.size.width,3);
    self.progressBar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [self.view addSubview:self.progressBar];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webURL]]];
}

- (void)webViewProgressDidStart:(OTMWebView *)webView
{
}

- (void)webView:(OTMWebView *)progressTracker progressDidChange:(double)progress
{
    [self.progressBar setProgress:progress animated:YES];
}

- (void)webViewProgressDidFinish:(OTMWebView *)webView
{
    if ([webView canGoBack]) {
        self.mBackImageView.image = [UIImage imageNamed:@"btn_back"];
        self.mBackButton.enabled = YES;
    }
    else{
        self.mBackImageView.image = [UIImage imageNamed:@"btn_back_blur"];
        self.mBackButton.enabled = NO;
    }
    
    if ([webView canGoForward]) {
        self.mFwdImageView.image = [UIImage imageNamed:@"btn_fwd"];
        self.mFwdButton.enabled = YES;
    }
    else{
        self.mFwdImageView.image = [UIImage imageNamed:@"btn_fwd_blur"];
        self.mFwdButton.enabled = NO;
    }
    
    /*dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
	    [self.progressView setProgress:0.0];
     
     });
     */
}

- (void)webView:(OTMWebView *)webView documentTitleDidChange:(NSString *)title
{
    self.mTopTitleLable.text = title;
}



-(IBAction)crossButtonAction:(id)sender {
   
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
   
    
    [self dismissViewControllerAnimated:YES completion:^{
   // [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }];
}

-(IBAction)backButtonAction:(id)sender {
    [self.webView goBack];
    
}
-(IBAction)fwdButtonAction:(id)sender {
    [self.webView goForward];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(IBAction)uploadButtonAction:(id)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:self.webURL delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Open in Safari",@"Copy Link", nil];
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {

    
    if (buttonIndex == 0) {
        [PIURLUtils openURL:self.webURL];
    }
    if (buttonIndex == 1) {
    [self showHud];
    }
}

-(void)showHud{
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.webURL;
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark.png"]];
    
    // Set custom view mode
    HUD.mode = MBProgressHUDModeCustomView;
    
    HUD.labelText = @"Copied";
    
    [HUD show:YES];
    [HUD hide:YES afterDelay:2];
}

@end
