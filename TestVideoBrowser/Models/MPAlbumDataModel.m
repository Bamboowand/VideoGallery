//
//  MPAlbumDataModel.m
//  TestVideoBrowser
//
//  Created by arplanet on 2018/7/30.
//  Copyright © 2018年 Jacob. All rights reserved.
//

#import "MPAlbumDataModel.h"
#import <AVFoundation/AVFoundation.h>

@interface MPAlbumDataModel() {
    id<MPAlbumDataModelDelegate> delegate_;
    
    NSMutableArray *photoFileNames_;
    NSMutableArray *videoFileNames_;
}

@property(nonatomic, readonly) NSString *documentPath;
@property(nonatomic, readonly) NSString *videosPath;
@property(nonatomic, readonly) NSString *photoPath;
@end

@implementation MPAlbumDataModel
#pragma mark - initialize
- (instancetype)init {
    if ( !self ) {
        self = [super init];
    }
    
    NSArray *searchPaths =NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    _documentPath = [searchPaths objectAtIndex:0];
    
    _videosPath = [_documentPath stringByAppendingString:@"/Video/"];
    [self ensurePathAt:_videosPath];

    //原path /var/mobile/Containers/Data/Application/7BA049FB-779B-4169-809A-A874CA4FB949/Library/Caches/Image/image
    _photoPath = [_documentPath stringByAppendingString:@"/Image/image/"];
    [self ensurePathAt:_photoPath];
    
    return self;
}

- (void)releaseList {
    photoFileNames_ = nil;
    videoFileNames_ = nil;
}

#pragma mark - File Names and Paths
- (void)ensurePathAt:(NSString *)path {
    NSFileManager *fm = [NSFileManager defaultManager];
    if ( [fm fileExistsAtPath:path] == false ) {
        [fm createDirectoryAtPath:path
      withIntermediateDirectories:YES
                       attributes:nil
                            error:NULL];
    }
}

- (NSArray *)photoFileNames {
    if ( photoFileNames_ ) {
        return photoFileNames_;
    }
    NSError *error = nil;
    NSArray *dirContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:_photoPath error:&error];
    if ( !error ) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self ENDSWITH '.jpg'"];
        NSArray *imagesOnly = [dirContents filteredArrayUsingPredicate:predicate];
        photoFileNames_ = [NSMutableArray arrayWithArray:imagesOnly];
    } else {
#ifdef DEBUG
        NSLog(@"error: %@", [error localizedDescription]);
#endif
        photoFileNames_ = [[NSMutableArray alloc] init];
    }
    return photoFileNames_;
}

- (NSArray *)videoFileNames {
    if ( videoFileNames_ ) {
        return videoFileNames_;
    }
    NSError *error = nil;
    NSArray *dirContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:_videosPath error:&error];
    if ( !error ) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self ENDSWITH '.mov'"];
        NSArray *imagesOnly = [dirContents filteredArrayUsingPredicate:predicate];
        videoFileNames_ = [NSMutableArray arrayWithArray:imagesOnly];
    } else {
#ifdef DEBUG
        NSLog(@"error: %@", [error localizedDescription]);
#endif
        videoFileNames_ = [[NSMutableArray alloc] init];
    }
    return videoFileNames_;
}

#pragma mark - Video Management
- (NSInteger)numberOfVideos {
    return [[self videoFileNames] count];
}

- (UIImage *)videoImageAtIndex:(NSInteger)index {
    NSString *fileName = [[self videoFileNames] objectAtIndex:index];
    NSString *path = [_videosPath stringByAppendingString:fileName];
    NSLog(@"path = %@", path);
    NSURL *pathURL = [NSURL fileURLWithPath:path];
    return [self firstFrame:pathURL];
}

- (NSURL *)videoURLAtIndex:(NSInteger)index {
    NSString *fileName = [[self videoFileNames] objectAtIndex:index];
    NSString *path = [_videosPath stringByAppendingString:fileName];
    return [NSURL fileURLWithPath:path];
}

- (void)saveVideo:(NSData *)video withName:(NSString *)name addToSystemAlbum:(BOOL)addToSystemAlbum {
    NSString *fileName = [NSString stringWithFormat:@"%@.mov", name];
    NSString *path = [_videosPath stringByAppendingString:fileName];
    [video writeToFile:path atomically:NO];
    [self releaseList];
}

- (BOOL)deleteVideoAtIndex:(NSInteger)index {
    if ( index > [self videoFileNames].count ) {
        NSLog(@"Error: MPAlbumDataModel don't delete Video at index");
        return NO;
    }
    NSString *fileName = [[self videoFileNames] objectAtIndex:index];
    NSString *path = [_videosPath stringByAppendingString:fileName];
    [videoFileNames_ removeObject:fileName];
    NSError *error = nil;
    [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
    NSLog(@"Error: MPAlbumDataModel don't delete Video for %@", error);
    return YES;
}

- (UIImage *)firstFrame:(NSURL *)videoURL {
    
    // courtesy of null0pointer and Javi Campaña
    // http://stackoverflow.com/questions/10221242/first-frame-of-a-video-using-avfoundation
    
    AVURLAsset* asset = [AVURLAsset URLAssetWithURL:videoURL options:nil];
    NSLog(@"URL = %@", videoURL);
    AVAssetImageGenerator* generator = [AVAssetImageGenerator assetImageGeneratorWithAsset:asset];
    generator.appliesPreferredTrackTransform = YES;
    UIImage* image = [UIImage imageWithCGImage:[generator copyCGImageAtTime:CMTimeMake(0, 1) actualTime:nil error:nil]];
    
    return image;
}

#pragma mark - Photo Management
- (NSInteger)numberOfPhotos {
    return [[self photoFileNames] count];
}

- (UIImage *)imageAtIndex:(NSInteger)index {
    NSString *fileName = [[self photoFileNames] objectAtIndex:index];
    NSString *path = [_photoPath stringByAppendingString:fileName];
    return [UIImage imageWithContentsOfFile:path];
}

- (void)savePhoto:(UIImage *)photo withName:(NSString *)name addToSystemAlbum:(BOOL)addToSystemAlbum {
    
    [self releaseList];
}

@end
