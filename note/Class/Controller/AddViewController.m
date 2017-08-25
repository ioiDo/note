//
//  AddViewController.m
//  note
//
//  Created by apple on 2017/8/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AddViewController.h"
#import "TimePickView.h"
#import "BRPlaceholderTextView.h"
#import "ProjectModel.h"

@interface AddViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *dateTime;
@property (weak, nonatomic) IBOutlet UITextField *startTime;
@property (weak, nonatomic) IBOutlet UITextField *endTime;
@property (nonatomic, strong) UITextField *editTF;
@property (weak, nonatomic) IBOutlet BRPlaceholderTextView *ptv;
@property (weak, nonatomic) IBOutlet UITextField *projectName;
@property (weak, nonatomic) IBOutlet UIButton *preBtn;
@property (weak, nonatomic) IBOutlet UIButton *actBtn;
@property (weak, nonatomic) IBOutlet UIButton *endBtn;
@property (weak, nonatomic) IBOutlet UITextField *firstPartyTF;
@property (weak, nonatomic) IBOutlet UITextField *moneyTF;
@property (weak, nonatomic) IBOutlet UITextField *dateTimeTF;
@property (nonatomic, strong) UIButton *tem;


@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUI];
    [self setData];
}

- (void)setData {
    
}

- (void)setUI {
    self.navigationItem.title = @"新增项目";
    [self rightItem];
    self.dateTime.delegate = self.startTime.delegate = self.endTime.delegate = self;
    self.ptv.placeholder = @"请输入备注";
    self.preBtn.selected = YES;
    self.tem = self.preBtn;
}
- (IBAction)selectAction:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if (self.tem != btn) {
        self.tem.selected = NO;
    }
    btn.selected = YES;
    self.tem = btn;
}

- (void)rightItem {
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 44, 22);
    [rightBtn setTitle:@"保存" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [rightBtn addTarget:self action:@selector(rightItemClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)rightItemClick {
    ProjectModel *model = [[ProjectModel alloc] init];
    model.name = self.projectName.text;
    if (self.preBtn.selected) {
        model.state = @"0";
    }else if (self.actBtn.selected) {
        model.state = @"1";
    }else{
        model.state = @"2";
    }
    model.firstParty = self.firstPartyTF.text;
    model.money = self.moneyTF.text;
    model.dateTime = self.dateTimeTF.text;
    model.startTime = self.startTime.text;
    model.endTime = self.endTime.text;
    model.note = self.ptv.text;
    // 获取默认的 Realm 实例
    RLMRealm *realm = [RLMRealm defaultRealm];
    // 通过事务将数据添加到 Realm 中
    [realm beginWriteTransaction];
    [realm addObject:model];
    [realm commitWriteTransaction];
    [APPHelp showTip:@"保存成功" inView:self.view];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [self.editTF resignFirstResponder];
    if (textField == self.dateTime || textField == self.startTime || textField == self.endTime) {
        TimePickView *pickView = [[TimePickView alloc] init];
        pickView.block = ^(NSString *dateStr) {
            textField.text = dateStr;
        };
        [pickView show];
        return NO;
    }
    self.editTF = textField;
    return YES;
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
