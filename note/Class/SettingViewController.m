//
//  SettingViewController.m
//  note
//
//  Created by apple on 2017/8/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingTableViewCell.h"

@interface SettingViewController ()<UITableViewDataSource,UITableViewDelegate> {
    NSArray *_titleArr;
}

@property (nonatomic, strong) UITableView *myTable;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUI];
    [self setData];
}

- (void)setData {
    _titleArr = @[@"导出历史",@"备份数据",@"读取数据",@"关于应用"];
}

- (void)setUI {
    [self.view addSubview:self.myTable];
    [self.myTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.top.equalTo(@0);
    }];
}

#pragma mark - table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titleArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"SettingTableViewCell";
    SettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:cellId owner:nil options:nil] firstObject];
    }
    cell.textLabel.text = _titleArr[indexPath.row];
    return cell;
}

- (UITableView *)myTable {
    if (!_myTable) {
        _myTable = [[UITableView alloc] init];
        _myTable.delegate = self;
        _myTable.dataSource = self;
        _myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _myTable.tableFooterView = [[UIView alloc] init];
        _myTable.backgroundColor = kColorBackView;
    }
    return _myTable;
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
