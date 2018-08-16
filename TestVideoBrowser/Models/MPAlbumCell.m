//
//  MPAlbumCell.m
//  TestVideoBrowser
//
//  Created by arplanet on 2018/7/31.
//  Copyright © 2018年 Jacob. All rights reserved.
//

#import "MPAlbumCell.h"

@implementation MPAlbumCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.layer.borderWidth = 1.0f;
    self.contentView.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.imageView.layer.masksToBounds = YES;
    self.imageView.layer.borderWidth = 1.0f;
    self.imageView.layer.borderColor = [[UIColor whiteColor] CGColor];
    // Initialization code
}

@end
