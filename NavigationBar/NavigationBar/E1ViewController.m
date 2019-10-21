//
//  E1ViewController.m
//  NavigationBar
//
//  Created by LL on 2019/10/18.
//  Copyright © 2019 LL. All rights reserved.
//

#import "E1ViewController.h"
#import "UIViewController+handle.h"
#import "UIImage+Color.h"
#import "UINavigationBar+handle.h"
#import "UINavigationController+handle.h"

@interface E1ViewController ()<UIScrollViewDelegate,UINavigationControllerDelegate,UINavigationBarDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *listCV;
@property (nonatomic, assign) BOOL beginDragging;

@end

@implementation E1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"E1";
    self.navBarAlpha = 0.0;
    self.beginDragging = NO;
    //
    self.listCV.contentInset = UIEdgeInsetsMake(200.0-88.0, 0.0, 0.0, 0.0);
    CGRect rect = [UIScreen mainScreen].bounds;
    rect.origin.y = -200;
    rect.size.height = 200.0;
    UIView *rView = [[UIView alloc] initWithFrame:rect];
    rView.backgroundColor = [UIColor redColor];
    rView.userInteractionEnabled = YES;
    [rView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)]];
    [self.listCV addSubview:rView];
    CGFloat offsetY = self.listCV.contentOffset.y;
    NSLog(@"offsetY1:%f",offsetY);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)tapView:(UITapGestureRecognizer *)tap {
    NSLog(@"tap");
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.beginDragging = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    if (self.beginDragging) {
        offsetY = offsetY + 200.0;
        CGFloat alpha = 0.0;
        if (offsetY <= 0.0) {
            alpha = 0.0;
        }else if (offsetY < 112.0) {
            alpha = offsetY/112.0;
        }else {
            alpha = 1.0;
        }
        self.navBarAlpha = alpha;
        NSLog(@"offsetY:%f alpha:%f",offsetY, alpha);
        if (alpha < 1.0) {
            [self.navigationController.navigationBar setShadowImage:[UIImage new]];
        }else {
            UIColor *sColor = [UIColor purpleColor];
            UIImage *sImage = [UIImage imageWithColor:sColor];
            [self.navigationController.navigationBar setShadowImage:sImage];
        }
    }else {
        NSLog(@"not drag offsetY:%f",offsetY);
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        self.beginDragging = NO;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.beginDragging = NO;
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
        cell.backgroundColor = [UIColor yellowColor];
    }
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"E1PushToE2" sender:nil];
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
