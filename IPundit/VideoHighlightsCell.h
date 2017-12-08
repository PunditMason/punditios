//
//  VideoHighlightsCell.h
//  IPundit
//
//  Created by Gaurav Verma on 30/10/17.
//  Copyright © 2017 James Mason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoHighlightsCell : UITableViewCell<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *mTitalCellLbl;
@property (weak, nonatomic) IBOutlet UILabel *mSubTitalCellLbl;
@property (weak, nonatomic) IBOutlet UIImageView *mimageView;

//-(void)WebPlayer :(NSString *)videoURl;
@end
