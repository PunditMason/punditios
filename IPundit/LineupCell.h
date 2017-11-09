//
//  LineupCell.h
//  IPundit
//
//  Created by Manoj Gadamsetty on 01/11/17.
//  Copyright © 2017 James Mason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LineupCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *mPlayer1shirtNo;
@property (weak, nonatomic) IBOutlet UILabel *mPlayer1name;
@property (weak, nonatomic) IBOutlet UILabel *mPlayer1replacedBy;
@property (weak, nonatomic) IBOutlet UILabel *mPlayer1minute;
@property (weak, nonatomic) IBOutlet UIImageView *mPlayer1substitutionImage;
@property (weak, nonatomic) IBOutlet UIImageView *mPlayer1shirtImage;


@property (weak, nonatomic) IBOutlet UILabel *mPlayer2shirtNo;
@property (weak, nonatomic) IBOutlet UILabel *mPlayer2name;
@property (weak, nonatomic) IBOutlet UILabel *mPlayer2replacedBy;
@property (weak, nonatomic) IBOutlet UILabel *mPlayer2minute;
@property (weak, nonatomic) IBOutlet UIImageView *mPlayer2substitutionImage;
@property (weak, nonatomic) IBOutlet UIImageView *mPlayer2shirtImage;






@end
