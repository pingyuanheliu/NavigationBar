//
//  C1ViewController.m
//  NavigationBar
//
//  Created by LL on 2019/10/18.
//  Copyright © 2019 LL. All rights reserved.
//

#import "C1ViewController.h"
#import "UIImage+Color.h"
#import "UINavigationBar+handle.h"

@interface C1ViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *listCV;
@property (nonatomic, strong) UIImage *bImage;
@property (nonatomic, strong) UIImage *sImage;
@property (nonatomic, assign) BOOL isBarClear;

@end

@implementation C1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"C1";
    self.view.backgroundColor = [UIColor orangeColor];
    self.listCV.backgroundColor = [UIColor lightGrayColor];
    //
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"不透明" style:UIBarButtonItemStylePlain target:self action:@selector(clickRight:)];
    self.navigationItem.rightBarButtonItem = right;
    //
//    self.listCV.contentInset = UIEdgeInsetsMake(200.0-88.0, 0.0, 0.0, 0.0);
//    CGRect rect = [UIScreen mainScreen].bounds;
//    rect.origin.y = -200;
//    rect.size.height = 200.0;
//    UIView *rView = [[UIView alloc] initWithFrame:rect];
//    rView.backgroundColor = [UIColor redColor];
//    rView.userInteractionEnabled = YES;
//    [rView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)]];
//    [self.listCV addSubview:rView];
    //
    self.bImage = [self.navigationController.navigationBar backgroundImageForBarMetrics:UIBarMetricsDefault];
    self.sImage = [self.navigationController.navigationBar shadowImage];
    NSLog(@"bImage1:%@",[self.navigationController.navigationBar shadowImage]);
    CGFloat offsetY = self.listCV.contentOffset.y;
    NSLog(@"offsetY1:%f",offsetY);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"==viewWillAppear1==");
    UIColor *color = [UIColor colorWithRed:60.0/255.0 green:131.0/255.0 blue:255.0/255.0 alpha:0.5];
    UIImage *image = [UIImage imageWithColor:color];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.isBarClear = YES;
    NSLog(@"==viewWillAppear2==");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"==viewDidAppear==");
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    NSLog(@"offsetY:%f",offsetY);
}

- (void)tapView:(UITapGestureRecognizer *)tap {
    NSLog(@"tap");
}

- (void)clickRight:(UIBarButtonItem *)sender {
    NSLog(@"===click right");
    [self setIsBarClear:!self.isBarClear];
    if (self.isBarClear) {
        [sender setTitle:@"不透明"];
        UINavigationBar *bar = self.navigationController.navigationBar;
//        [bar setTranslucent:YES];
//        [bar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//        [bar setShadowImage:[UIImage new]];
        [bar cx_setBackgroudImage:[UIImage new]];
        NSLog(@"==YES=frame==:%@==%@==%@",NSStringFromCGRect(self.listCV.frame),NSStringFromCGRect(self.view.frame),NSStringFromUIEdgeInsets(self.listCV.contentInset));
    }else {
        [sender setTitle:@"透明"];
        UINavigationBar *bar = self.navigationController.navigationBar;
//        [bar setTranslucent:NO];
        UIColor *color = [UIColor orangeColor];
        UIImage *image = [UIImage imageWithColor:color];
//        [bar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
//        [bar setShadowImage:self.sImage];
        [bar cx_setBackgroudImage:image];
        NSLog(@"==NO=frame==:%@==%@==%@",NSStringFromCGRect(self.listCV.frame),NSStringFromCGRect(self.view.frame),NSStringFromUIEdgeInsets(self.listCV.contentInset));
    }
    NSLog(@"offset:%@==%@",NSStringFromCGPoint(self.listCV.contentOffset), NSStringFromUIEdgeInsets(self.listCV.contentInset));
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
    [self performSegueWithIdentifier:@"C1PushToC2" sender:nil];
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
