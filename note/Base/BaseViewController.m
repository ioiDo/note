//
//  BasicMainVC.m
//  App
//
//  Created by apple on 2017/1/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "BaseViewController.h"
#import "UIViewController+BackBar.h"

@interface BaseViewController ()

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UITableView *myTable;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageCount = 1;
    // Do any additional setup after loading the view.
    __weak typeof(self) weakSelf = self;
    NSLog(@" navcount = %lu",[self.navigationController.viewControllers count] );
    if ([self.navigationController.viewControllers count] > 1||[self.navigationController.viewControllers count] == 0) {
        [self useLeftBarItem:YES back:^{
            [weakSelf leftItemClick];
        }];
    }
}

- (void)leftItemClick {
    [self pop];
}

- (void)pop {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setTitleStr:(NSString *)title withColor:(UIColor *)color {
    self.titleLab.text = title;
    self.titleLab.textColor = color;
    self.navigationItem.titleView = self.titleLab;
}

- (void)setTitleStr:(NSString *)title {
    [self setTitleStr:title withColor:[UIColor whiteColor]];
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
        [self.titleLab setTextAlignment:NSTextAlignmentCenter];
        [self.titleLab setFont:[UIFont systemFontOfSize:18]];
    }
    return _titleLab;
}

- (void)endRefresh {
    __unsafe_unretained UITableView *tableView = self.myTable;
    [tableView.mj_header endRefreshing];
    [tableView.mj_footer endRefreshing];
}

- (void)addRefreshHeader
{
    __unsafe_unretained typeof(self) weakSelf = self;
    __unsafe_unretained UITableView *tableView = self.myTable;
    tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.pageCount = 1;
        [self setNetData];
    }];
    tableView.mj_header.automaticallyChangeAlpha = YES;
}

- (void)addRefreshFooter {
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    self.myTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

- (void)loadMoreData {
    self.pageCount += 1;
    [self setNetData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
