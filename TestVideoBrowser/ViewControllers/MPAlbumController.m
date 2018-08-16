//
//  MPAlbumController.m
//  TestVideoBrowser
//
//  Created by arplanet on 2018/8/1.
//  Copyright © 2018年 Jacob. All rights reserved.
//

#import "MPAlbumController.h"

@interface MPAlbumController () {
    MPAlbumDataModel *dataModel_;
}

@end

@implementation MPAlbumController

static NSString * const reuseIdentifier = @"MPAlbumCell";
#pragma mark - View Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    dataModel_ = [[MPAlbumDataModel alloc] init];
    
    // Register cell classes
    [self.collectionView setCollectionViewLayout:[self collectionViewLayout]];
    [self.collectionView registerClass:[MPAlbumCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:reuseIdentifier bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - initialize
//- (UICollectionView *)collectionView {
//    if ( !self.collectionView ) {
//
//        [self.collectionView registerNib:[UINib nibWithNibName:reuseIdentifier bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
//        [self.collectionView registerClass:[MPAlbumCell class] forCellWithReuseIdentifier:reuseIdentifier];
//
//    }
//    return self.collectionView;
//}

- (UICollectionViewFlowLayout *)collectionViewLayout {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    layout.sectionInset = UIEdgeInsetsMake(screenHeight * 0.1141, 0.1087 * screenWidth, 5, 0.1087 * screenWidth);
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    CGFloat width = ([UIScreen mainScreen].bounds.size.width - 2 * 10 - 0.1087 * screenWidth * 2) / 3;
    layout.itemSize = CGSizeMake(width, width);
    return layout;
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of items
    return [dataModel_ numberOfVideos];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MPAlbumCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.imageView.image = [dataModel_ videoImageAtIndex:indexPath.row];
//    cell.imageView.backgroundColor = [UIColor blackColor];
    // Configure the cell
    
    return (MPAlbumCell *)cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    PlayVideoViewController *vc = [[PlayVideoViewController alloc] initWithVideoAtIndex:indexPath.row withModel:dataModel_];
    [self presentViewController:vc animated:YES completion:nil];
}
/*
 // Uncomment this method to specify if the specified item should be highlighted during tracking
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 */

/*
 // Uncomment this method to specify if the specified item should be selected
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 */

/*
 // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
 return NO;
 }
 
 - (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
 return NO;
 }
 
 - (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
 
 }
 */
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
