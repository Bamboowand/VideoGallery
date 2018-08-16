//
//  MPAlbumDataModel.h
//  TestVideoBrowser
//
//  Created by arplanet on 2018/7/30.
//  Copyright © 2018年 Jacob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol MPAlbumDataModelDelegate;

@interface MPAlbumDataModel : NSObject


- (NSInteger)numberOfVideos;
- (UIImage *)videoImageAtIndex:(NSInteger)index;
- (NSURL *)videoURLAtIndex:(NSInteger)index;
- (void)saveVideo:(NSData *)video withName:(NSString *)name addToSystemAlbum:(BOOL)addToSystemAlbum;
- (BOOL)deleteVideoAtIndex:(NSInteger)index;


- (NSInteger)numberOfPhotos;
- (UIImage *)imageAtIndex:(NSInteger)index;
- (void)savePhoto:(UIImage *)photo withName:(NSString *)name addToSystemAlbum:(BOOL)addToSystemAlbum;

@end

@protocol MPAlbumDataModelDelegate <NSObject>

@optional


@end
