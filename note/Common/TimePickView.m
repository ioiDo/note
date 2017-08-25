//
//  TimePickView.m
//  App
//
//  Created by apple on 2017/2/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "TimePickView.h"
#import "AppDelegate.h"

@interface TimePickView ()

@property (nonatomic, strong) UIDatePicker *datePick;

@end

@implementation TimePickView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
        ;
    }
    return self;
}

- (instancetype)initWithMode:(NSString *)model
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
        ;
        self.mode = model;
    }
    return self;
}

- (void)show {
    [[AppDelegate instance].window addSubview:self];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancleBtnAction)];
    [self addGestureRecognizer:tap];
}

- (void)layoutSubviews {
    UIView *backView = [[UIView alloc] init];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [backView addGestureRecognizer:tap];
    [self addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.height.equalTo(@265);
    }];
    backView.backgroundColor = [UIColor whiteColor];
    UIView *topLine = [[UIView alloc] init];
    [backView addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(@0);
        make.height.equalTo(@2);
    }];
    topLine.backgroundColor = kMainOrange;
    UIView *bottomLine = [[UIView alloc] init];
    [backView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(@0);
        make.bottom.equalTo(@(-57));
        make.height.equalTo(@(0.5));
    }];
    bottomLine.backgroundColor = kColorE5;
    UIView *bottomVLine = [[UIView alloc] init];
    [backView addSubview:bottomVLine];
    [bottomVLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(backView.mas_centerX);
        make.top.equalTo(bottomLine.mas_bottom);
        make.bottom.equalTo(@0);
        make.width.equalTo(@(0.5));
    }];
    bottomVLine.backgroundColor = kColorE5;
    UIButton *cancle = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancle setTitle:@"取消" forState:UIControlStateNormal];
    [cancle setTitleColor:kColor99 forState:UIControlStateNormal];
    [cancle addTarget:self action:@selector(cancleBtnAction) forControlEvents:UIControlEventTouchUpInside];
    cancle.titleLabel.font = [UIFont systemFontOfSize:18];
    [backView addSubview:cancle];
    [cancle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(@0);
        make.top.equalTo(bottomLine.mas_bottom);
        make.right.equalTo(bottomVLine.mas_left);
    }];
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:kMainOrange forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(confirmBtnAction) forControlEvents:UIControlEventTouchUpInside];
    confirmBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [backView addSubview:confirmBtn];
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(@0);
        make.top.equalTo(bottomLine.mas_bottom);
        make.left.equalTo(bottomVLine.mas_right);
    }];
    self.datePick = [[UIDatePicker alloc] init];
    [backView addSubview:self.datePick];
    [self.datePick mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(@15);
        make.bottom.equalTo(bottomLine.mas_top).offset(-10);
    }];
    if ([self.mode isEqualToString:@"DateAndTime"]) {
        self.datePick.datePickerMode = UIDatePickerModeDateAndTime;
    }else{
        self.datePick.datePickerMode = UIDatePickerModeDate;
    }
    //默认根据手机本地设置显示为中文还是其他语言
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中文显示
    self.datePick.locale = locale;
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/beijing"];
    [self.datePick setTimeZone:timeZone];
    //设置分割线颜色
    for (UIView *view in self.datePick.subviews) {
        if ([view isKindOfClass:[UIView class]]) {
            for (UIView *subView in view.subviews) {
                if (subView.frame.size.height < 1) {
                    subView.backgroundColor = kColorE5;
                }
            }
        }
    }
}

- (void)cancleBtnAction {
    [self removeFromSuperview];
}

- (void)confirmBtnAction {
    NSDate *pickerDate = [self.datePick date];// 获取用户通过UIDatePicker设置的日期和时间
    NSDateFormatter *pickerFormatter = [[NSDateFormatter alloc] init];// 创建一个日期格式器
//    [pickerFormatter setDateFormat:@"yyyy年MM月dd日(EEEE)   HH:mm:ss"];
    if ([self.mode isEqualToString:@"DateAndTime"]) {
        [pickerFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
    }else{
        [pickerFormatter setDateFormat:@"yyyy年MM月dd日"];
    }
    NSString *dateString = [pickerFormatter stringFromDate:pickerDate];
    
    //打印显示日期时间
    NSLog(@"格式化显示时间：%@",dateString);
    self.block(dateString);
    [self removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
