//
//  HomeViewController.m
//  note
//
//  Created by apple on 2017/8/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeTableViewCell.h"
#import "HomeDetaiViewController.h"
#import "AddViewController.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate> {
    RLMResults<ProjectModel *> *projects;
}
@property (strong, nonatomic) IBOutlet UIView *headView;
@property (nonatomic,strong) UITableView *myTable;
@property (nonatomic, strong) NSMutableArray *datalist;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"Notes";
    [self setUI];
    [self setDate];
    [self addRefreshHeader];
    [self addRefreshFooter];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    projects = [ProjectModel allObjects];
    [self.myTable.mj_header beginRefreshing];
}

- (void)setUI {
    [self.view addSubview:self.headView];
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.height.equalTo(@40);
        make.top.equalTo(@0);
    }];
    [self.view addSubview:self.myTable];
    [self.myTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.top.equalTo(self.headView.mas_bottom);
        make.bottom.equalTo(@(-49));
    }];
    [self rightItem];
    self.myTable.emptyDataSetSource = self;
    self.myTable.emptyDataSetDelegate = self;
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"empty_placeholder"];
}

- (void)rightItem {
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 44, 22);
    [rightBtn setTitle:@"新增" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [rightBtn addTarget:self action:@selector(rightItemClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)setDate {
    
}

- (void)rightItemClick {
    AddViewController *vc = [[AddViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)partData {
    for (NSInteger i=5*(self.pageCount-1); i<5*self.pageCount; i++) {
        if (i>=projects.count) {
            return;
        }
        ProjectModel *model = projects[i];
        [self.datalist addObject:model];
    }
}


#pragma mark - table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datalist.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 117;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"HomeTableViewCell";
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:cellId owner:nil options:nil] firstObject];
    }
    cell.model = self.datalist[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeDetaiViewController *vc = [[HomeDetaiViewController alloc] init];
    vc.projectModel = self.datalist[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)setNetData {
    if (self.pageCount == 1) {
        [self.datalist removeAllObjects];
    }
    [self partData];
    [self.myTable reloadData];
    [self endRefresh];
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

- (NSMutableArray *)datalist {
    if (!_datalist) {
        _datalist = [[NSMutableArray alloc] init];
    }
    return _datalist;
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
