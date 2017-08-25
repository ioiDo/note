//
//  AddDetailViewController.m
//  note
//
//  Created by apple on 2017/8/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AddDetailViewController.h"
#import "BRPlaceholderTextView.h"
#import "TimePickView.h"

@interface AddDetailViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet BRPlaceholderTextView *contentPTF;
@property (weak, nonatomic) IBOutlet UITextField *moneyTF;
@property (weak, nonatomic) IBOutlet UIButton *receiptBtn;
@property (weak, nonatomic) IBOutlet UIButton *materialsBtn;
@property (weak, nonatomic) IBOutlet UIButton *cashBtn;
@property (weak, nonatomic) IBOutlet UIButton *otherBtn;
@property (weak, nonatomic) IBOutlet UITextField *dateTF;
@property (weak, nonatomic) IBOutlet BRPlaceholderTextView *notePTV;
@property (nonatomic, strong) UITextField *editTF;
@property (nonatomic, strong) UIButton *tem;

@end

@implementation AddDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUI];
}

- (void)setUI {
    self.navigationItem.title  = @"创建明细";
    [self rightItem];
    self.dateTF.delegate = self.moneyTF.delegate = self;
    self.receiptBtn.selected = YES;
    self.tem = self.receiptBtn;
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
    self.contentPTF.placeholder = @"请输入明细内容";
    self.notePTV.placeholder = @"请输入备注";
}

- (void)setDate {
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [self.editTF resignFirstResponder];
    if (textField == self.dateTF) {
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

- (void)rightItemClick {
    DetailModel *model = [[DetailModel alloc] init];
    model.content = self.contentPTF.text;
    model.money = self.moneyTF.text;
    if (self.receiptBtn.selected) {
        model.category = @"0";
    }else if (self.materialsBtn.selected) {
        model.category = @"1";
    }else if (self.cashBtn.selected) {
        model.category = @"2";
    }else{
        model.category = @"3";
    }
    model.projectName = self.projectModel.name;
    model.dateTime = self.dateTF.text;
    model.note = self.notePTV.text;
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

- (IBAction)btnAction:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if (self.tem != btn) {
        self.tem.selected = NO;
    }
    btn.selected = YES;
    self.tem = btn;
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
