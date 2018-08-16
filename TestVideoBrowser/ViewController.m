//
//  ViewController.m
//  TestVideoBrowser
//
//  Created by arplanet on 2018/7/30.
//  Copyright © 2018年 Jacob. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)openAlbum:(UIButton *)sender {
    MPAlbumController *vc = [[MPAlbumController alloc] init];
    [self presentViewController:vc animated:NO completion:nil];
}

- (IBAction)saveData:(UIButton *)sender {
    MPAlbumDataModel *data = [[MPAlbumDataModel alloc] init];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ICRTForiOS" ofType:@"mov"];
    NSData *videoData = [NSData dataWithContentsOfFile:path];
    [data saveVideo:videoData withName:@"video002" addToSystemAlbum:NO];
    
}
@end
