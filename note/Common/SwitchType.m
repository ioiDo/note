//
//  SwitchType.m
//  note
//
//  Created by apple on 2017/8/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "SwitchType.h"
#import "NSArray+Safe.h"

@implementation SwitchType

+ (NSString *)orderStateFromType:(NSString *)type {
    NSArray *arr = @[@"预定",@"进行中",@"结束"];
    NSString *str = [arr h_safeObjectAtIndex:[type integerValue]];
    return str;
}

+ (NSString *)detailCategoryFromType:(NSString *)type {
    NSArray *arr = @[@"收款",@"材料",@"工资",@"其他"];
    NSString *str = [arr h_safeObjectAtIndex:[type integerValue]];
    return str;
}

@end
