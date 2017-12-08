//
//  LineupCell.m
//  IPundit
//
//  Created by Manoj Gadamsetty on 01/11/17.
//  Copyright © 2017 James Mason. All rights reserved.
//

#import "LineupCell.h"

@implementation LineupCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.mPlayer1substitutionImage.hidden = true;
    self.mPlayer2substitutionImage.hidden = true;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
 


    // Configure the view for the selected state
}

@end
