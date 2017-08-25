//
//  HomeDetaiViewController.m
//  note
//
//  Created by apple on 2017/8/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "HomeDetaiViewController.h"
#import "HomeTableViewCell.h"
#import "HomeDetaiViewController.h"
#import "AddDetailViewController.h"
// **** 需要下载 LibXL.framework  *******
#include "LibXL/libxl.h"


@interface HomeDetaiViewController ()<UITableViewDelegate,UITableViewDataSource,UIDocumentInteractionControllerDelegate,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate> {
    RLMResults<DetailModel *> *detailModels;
}
@property (strong, nonatomic) IBOutlet UIView *headView;
@property (nonatomic,strong) UITableView *myTable;
@property (nonatomic, strong) NSMutableArray *datalist;
@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, strong) UIButton *addBtn;

@end

@implementation HomeDetaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"项目明细";
    [self setUI];
    [self setDate];
    [self addRefreshHeader];
    [self addRefreshFooter];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    detailModels = [DetailModel allObjects];
    self.data = [NSMutableArray array];
    for (NSInteger i=0; i<detailModels.count; i++) {
        DetailModel *model = detailModels[i];
        if ([model.projectName isEqualToString: self.projectModel.name]) {
            [self.data addObject:model];
        }
    }
    [self.myTable.mj_header beginRefreshing];
}

- (void)setUI {
    [self.view addSubview:self.myTable];
    [self.myTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.top.equalTo(@0);
        make.bottom.equalTo(@(0));
    }];
    [self rightItem];
    [self initAddBtn];
    self.myTable.emptyDataSetSource = self;
    self.myTable.emptyDataSetDelegate = self;
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"empty_placeholder"];
}


- (void)initAddBtn {
    self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.addBtn addTarget:self action:@selector(addBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.addBtn setBackgroundImage:[UIImage imageNamed:@"添加"] forState:UIControlStateNormal];
    [self.view addSubview:self.addBtn];
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-20));
        make.bottom.equalTo(@(-20));
        make.width.equalTo(@60);
        make.height.equalTo(@60);
    }];
    [self.view bringSubviewToFront:self.addBtn];
}

- (void)addBtnAction {
    AddDetailViewController *vc = [[AddDetailViewController alloc] init];
    vc.projectModel = self.projectModel;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)rightItem {
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 44, 22);
    [rightBtn setTitle:@"导出" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [rightBtn addTarget:self action:@selector(rightItemClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)setDate {
    
}

- (void)rightItemClick {
    if (!(self.data.count>0)) {
        return;
    }
    BookHandle book = xlCreateBook(); // use xlCreateXMLBook() for working with xlsx files
    
    SheetHandle sheet = xlBookAddSheet(book, "Sheet1", NULL);
    //第一个参数代表插入哪个表，第二个是第几行（默认从0开始），第三个是第几列（默认从0开始）
    xlSheetWriteStr(sheet, 1, 0, "项目", 0);
    xlSheetWriteStr(sheet, 1, 1, "金额", 0);
    xlSheetWriteStr(sheet, 1, 2, "类别", 0);
    xlSheetWriteStr(sheet, 1, 3, "备注", 0);
    xlSheetWriteStr(sheet, 1, 4, "日期", 0);
    for (int i=0; i<self.data.count; i++) {
        DetailModel *model = self.data[i];
        const char *name_c = [model.projectName cStringUsingEncoding:NSUTF8StringEncoding];
        xlSheetWriteStr(sheet, i+2, 0,name_c, 0);
        const char *money_c = [model.money cStringUsingEncoding:NSUTF8StringEncoding];
        xlSheetWriteStr(sheet, i+2, 1,money_c, 0);
        const char *category_c = [[SwitchType orderStateFromType:model.category] cStringUsingEncoding:NSUTF8StringEncoding];
        xlSheetWriteStr(sheet, i+2, 2,category_c, 0);
        const char *note_c = [model.note cStringUsingEncoding:NSUTF8StringEncoding];
        xlSheetWriteStr(sheet, i+2, 3,note_c, 0);
        const char *date_c = [model.dateTime cStringUsingEncoding:NSUTF8StringEncoding];
        xlSheetWriteStr(sheet, i+2, 4,date_c, 0);

    }
    NSString *documentPath =
    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0];
//    NSString *fname = [@"data" stringByAppendingString:@".xls"];
    NSString *fname = [NSString stringWithFormat:@"%@.xls",((DetailModel *)self.data[0]).projectName];
    NSString *filename = [documentPath stringByAppendingPathComponent:fname];
    // 输出路径
    NSLog(@"filepath:%@",filename);
    BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:filename];
    if (!blHave) {
        NSLog(@"no  have");
        return ;
    }else {
        NSLog(@" have");
        BOOL blDele= [[NSFileManager defaultManager] removeItemAtPath:filename error:nil];
        if (blDele) {
            NSLog(@"dele success");
        }else {
            NSLog(@"dele fail");
        }
    }
    xlBookSave(book, [filename UTF8String]);
    
    xlBookRelease(book);
    
    // 分享出去
    UIDocumentInteractionController *docu = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:filename]];
    
    docu.delegate = self;
    CGRect rect = CGRectMake(0, 0, 320, 300);
    
    [docu presentOpenInMenuFromRect:rect inView:self.view animated:YES];
    [docu presentPreviewAnimated:YES];
    
    
}

- (void)partData {
    for (NSInteger i=5*(self.pageCount-1); i<5*self.pageCount; i++) {
        if (i>=self.data.count) {
            return;
        }
        DetailModel *model = self.data[i];
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
    cell.detailModel = self.datalist[indexPath.row];
    return cell;
}

/**
 *  设置删除按钮
 *
 */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete){
        DetailModel *model = self.datalist[indexPath.row];
        // 获取默认的 Realm 实例
        RLMRealm *realm = [RLMRealm defaultRealm];
        // 通过事务将数据添加到 Realm 中
        [realm beginWriteTransaction];
        [realm deleteObject:model];
        [realm commitWriteTransaction];
        
        [self.datalist removeObjectAtIndex:indexPath.row];
        [self.myTable reloadData];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
