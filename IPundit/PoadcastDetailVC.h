//
//  PoadcastDetailVC.h
//  IPundit
//
//  Created by Gaurav Verma on 13/09/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PoadcastDetailCell.h"
#import "Helper.h"
#import "DataManager.h"
#import <MediaPlayer/MediaPlayer.h>

@interface PoadcastDetailVC : UIViewController<AVAudioPlayerDelegate>{
    
}
@property (strong, nonatomic) IBOutlet UITableView *mPoadcastDetailTableView;
@property (strong, nonatomic) MPMoviePlayerController *streamPlayer;

@property (nonatomic,strong) NSMutableArray *ChannelArray;

- (IBAction)BackButtonAction:(id)sender;
@end
