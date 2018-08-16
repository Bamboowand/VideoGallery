//
//  MPAlbumController.h
//  TestVideoBrowser
//
//  Created by arplanet on 2018/8/1.
//  Copyright © 2018年 Jacob. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPAlbumCell.h"
#import "MPAlbumDataModel.h"
#import "PlayVideoViewController.h"

@interface MPAlbumController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end
