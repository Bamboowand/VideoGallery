//
//  PlayVideoViewController.m
//  TestVideoBrowser
//
//  Created by arplanet on 2018/8/1.
//  Copyright © 2018年 Jacob. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "PlayVideoViewController.h"

@interface PlayVideoViewController () {
    NSInteger selectIndex_;
}
@property(nonatomic)MPMoviePlayerController *moviePlayer;
@end

@implementation PlayVideoViewController
#pragma mark = Initialize
- (instancetype)initWithVideoAtIndex:(NSInteger)index withModel:(MPAlbumDataModel *)model {
    if ( !self ) {
        self = [super init];
    }
    selectIndex_ = index;
    self.dataModel = model;
    return self;
}

#pragma mark - View Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *sourceVideoURL = [self.dataModel videoURLAtIndex:selectIndex_];
//    AVAsset *movieAsset = [AVURLAsset URLAssetWithURL:sourceVideoURL options:nil];
//    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
//    AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
//    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
//    playerLayer.frame = self.videoView.layer.bounds;
//    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
//
//    [self.videoView.layer addSublayer:playerLayer];
//    [player play];
    
    self.moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:sourceVideoURL];
    [self.moviePlayer prepareToPlay];
    self.moviePlayer.view.frame = self.videoView.bounds;
    self.moviePlayer.scalingMode = MPMovieScalingModeAspectFit;
    self.moviePlayer.repeatMode = MPMovieRepeatModeNone;
    self.moviePlayer.controlStyle = MPMovieControlStyleEmbedded;
    
    [self.videoView addSubview:self.moviePlayer.view];
    [self.moviePlayer play];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)backAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)shareBtnPressed:(UIButton *)sender {
    NSURL *path = [self.dataModel videoURLAtIndex:selectIndex_];
    NSArray *dataArray = @[path];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:dataArray applicationActivities:nil];
    [self presentViewController:activityVC animated:YES completion:nil];
}
@end
