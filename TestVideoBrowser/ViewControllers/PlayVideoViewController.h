//
//  PlayVideoViewController.h
//  TestVideoBrowser
//
//  Created by arplanet on 2018/8/1.
//  Copyright © 2018年 Jacob. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "MPAlbumDataModel.h"

@interface PlayVideoViewController : UIViewController

@property (weak, nonatomic) MPAlbumDataModel *dataModel;
@property (weak, nonatomic) IBOutlet UIView *videoView;

- (instancetype)initWithVideoAtIndex:(NSInteger)index withModel:(MPAlbumDataModel *)model;
- (IBAction)backAction:(UIButton *)sender;
- (IBAction)shareBtnPressed:(UIButton *)sender;


@end
