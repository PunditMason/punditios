//
//  PoadcastDetailVC.h
//  IPundit
//
//  Created by Gaurav Verma on 13/09/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ManageLeaqueDetailCell.h"
#import "Helper.h"
#import "DataManager.h"
#import <MediaPlayer/MediaPlayer.h>

#import "UIImageView+WebCache.h"

@interface ManageLeaqueDetailVC : UIViewController<AVAudioPlayerDelegate>{
    
}

@property (strong, nonatomic) IBOutlet UITableView *mPoadcastDetailTableView;
//@property (strong, nonatomic) MPMoviePlayerController *streamPlayer;


@property (strong, nonatomic) MPMoviePlayerController *streamPlayer;
@property (strong, nonatomic) AVPlayer *player;



@property (nonatomic,strong) NSString *TMName;
@property (nonatomic,strong) NSString *LIString;
@property (nonatomic,strong) NSMutableArray *ChannelArray;

- (IBAction)BackButtonAction:(id)sender;
@end
