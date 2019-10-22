//
//  B1ViewController.m
//  NavigationBar
//
//  Created by LL on 2019/10/18.
//  Copyright © 2019 LL. All rights reserved.
//

#import "B1ViewController.h"
#import "UIViewController+handle.h"
#import "UINavigationController+FDFullscreenPopGesture.h"

@interface B1ViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *listCV;

@end

@implementation B1ViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.fd_prefersNavigationBarHidden = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"演示二";
    CGRect rect = [UIScreen mainScreen].bounds;
    CGFloat imgHeight = 251.0*414.0/rect.size.width;
    CGFloat offset = [UIViewController cx_navTopHeight] + 44.0;
    //
    self.listCV.contentInset = UIEdgeInsetsMake(imgHeight - offset, 0.0, 0.0, 0.0);
    //
    rect.origin.y = -imgHeight;
    rect.size.height = imgHeight;
    UIImageView *rView = [[UIImageView alloc] initWithFrame:rect];
    rView.image = [UIImage imageNamed:@"top"];
    rView.userInteractionEnabled = YES;
    [rView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)]];
    [self.listCV addSubview:rView];
}

- (void)tapView:(UITapGestureRecognizer *)tap {
    NSLog(@"tap");
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 30.0;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *const Identifier = @"Cell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:Identifier forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.backgroundColor = [UIColor greenColor];
    }else {
        cell.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.3];
    }
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"B1PushToB2" sender:nil];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(100.0, 100.0);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10.0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10.0;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeZero;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeZero;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
