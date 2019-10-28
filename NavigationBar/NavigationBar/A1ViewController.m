//
//  A1ViewController.m
//  NavigationBar
//
//  Created by LL on 2019/10/18.
//  Copyright © 2019 LL. All rights reserved.
//

#import "A1ViewController.h"
#import "UIViewController+handle.h"
#import <XRNavigationBar/XRNavigationBar.h>

@interface A1ViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *listCV;
@property (strong, nonatomic) UILabel *labTip;

@end

@implementation A1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"演示一";
    CGRect rect = [UIScreen mainScreen].bounds;
    CGFloat imgHeight = floor(251.0*414.0/rect.size.width);
    CGFloat offset = [UIViewController cx_navTopHeight];
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
    //
    rect.origin.y = 100.0 + offset/2.0;
    rect.size.height = 60.0;
    self.labTip = [[UILabel alloc] initWithFrame:rect];
    self.labTip.textAlignment = NSTextAlignmentCenter;
    self.labTip.textColor = [UIColor whiteColor];
    self.labTip.text = @"点击我-不隐藏导航栏";
    [rView addSubview:self.labTip];
}

- (void)tapView:(UITapGestureRecognizer *)tap {
    NSLog(@"tap");
    [self.navigationController setNavigationBarHidden:!self.navigationController.navigationBarHidden animated:YES];
    if (self.navigationController.navigationBarHidden) {
        self.labTip.text = @"点击我-不隐藏导航栏";
    }else {
        self.labTip.text = @"点击我-隐藏导航栏";
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!self.navigationController.navigationBarHidden) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        self.labTip.text = @"点击我-不隐藏导航栏";
    }
}

#pragma mark - Click Item

- (IBAction)clickHelpItem:(UIBarButtonItem *)sender {
    UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"提示"
                                                     message:@"该界面演示了系统API提供的导航栏隐藏方法\n- (void)setNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated;"
                                                    delegate:nil
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil, nil];
    [alertV show];
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
    [self performSegueWithIdentifier:@"A1PushToA2" sender:nil];
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
