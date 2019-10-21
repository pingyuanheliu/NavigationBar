//
//  ViewController.m
//  NavigationBar
//
//  Created by LL on 2019/10/17.
//  Copyright © 2019 LL. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+Color.h"
#import "UIViewController+handle.h"
#import "UINavigationController+handle.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *listArray;
@property (weak, nonatomic) IBOutlet UITableView *listTV;
@property (nonatomic, strong) UIImage *bImage;
@property (nonatomic, strong) UIImage *sImage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"主界面";
    self.navigationController.delegate = self.navigationController;
    self.navigationController.navigationBar.delegate = self.navigationController;
    self.navBarAlpha = 1.0;
    self.listArray = @[@"导航栏隐藏与显示方式一", @"导航栏隐藏与显示方式二", @"导航栏透明与不透明方式一", @"导航栏透明与不透明方式二", @"导航栏透明渐变"];
    NSLog(@"bImage1:%@",[self.navigationController.navigationBar shadowImage]);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.navigationController.navigationBarHidden) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
    NSLog(@"bImage2:%@",[self.navigationController.navigationBar shadowImage]);
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *const Identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier forIndexPath:indexPath];
    cell.textLabel.text = self.listArray[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            [self performSegueWithIdentifier:@"MainPushToA1" sender:nil];
            break;
        case 1:
            [self performSegueWithIdentifier:@"MainPushToB1" sender:nil];
            break;
        case 2:
            [self performSegueWithIdentifier:@"MainPushToC1" sender:nil];
            break;
        case 3:
            [self performSegueWithIdentifier:@"MainPushToD1" sender:nil];
            break;
        case 4:
            [self performSegueWithIdentifier:@"MainPushToE1" sender:nil];
            break;
        default:
            break;
    }
}

@end
