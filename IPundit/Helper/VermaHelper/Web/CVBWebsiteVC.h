//
//  CVBWebsiteVC.h
//  Dalton_iGuide
//
//  Created by Bhupinder Verma on 22/08/15.
//
//

#import <UIKit/UIKit.h>

@interface CVBWebsiteVC : UIViewController<UIActionSheetDelegate>{
    NSString *webURL;
}
@property(nonatomic,weak)IBOutlet UIImageView *mBackImageView;
@property(nonatomic,weak)IBOutlet UIImageView *mFwdImageView;
@property(nonatomic,weak)IBOutlet UILabel *mTopTitleLable;
@property(nonatomic,weak)IBOutlet UIButton *mBackButton;
@property(nonatomic,weak)IBOutlet UIButton *mFwdButton;
@property (nonatomic,weak)IBOutlet UIView *mTopBarView;
@property(nonatomic,copy)    NSString *webURL;
@property(nonatomic,copy)    NSString *titleStr;

-(IBAction)crossButtonAction:(id)sender;
-(IBAction)backButtonAction:(id)sender;
-(IBAction)fwdButtonAction:(id)sender;
-(IBAction)uploadButtonAction:(id)sender;
@end



//=================.h================

//#import "CVBWebsiteVC.h"
//#define kfbPrefixStr @"https://www.facebook.com/"
//#define ktwitterPrefixStr @"https://twitter.com/"
//-(IBAction)screenWebsiteAction:(id)sender ;


//=================.m================

//
//-(IBAction)screenWebsiteAction:(id)sender {
//    CVBWebsiteVC *webvcObj = [self.storyboard instantiateViewControllerWithIdentifier:@"webvc"];
//    webvcObj.webURL = @"http://www.google.com";
//    webvcObj.titleStr = @"";
//    [self presentViewController:webvcObj animated:YES completion:NULL];
//}
