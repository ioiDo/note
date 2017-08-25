//
//  HomeTableViewCell.h
//  note
//
//  Created by apple on 2017/8/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *cellBackView;
@property (weak, nonatomic) IBOutlet UILabel *stateLab;
@property (nonatomic, strong) ProjectModel *model;
@property (weak, nonatomic) IBOutlet UILabel *projectName;
@property (weak, nonatomic) IBOutlet UILabel *firstPart;
@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet UILabel *time;

@property (nonatomic, strong) DetailModel *detailModel;
@property (weak, nonatomic) IBOutlet UILabel *labR1;
@property (weak, nonatomic) IBOutlet UILabel *labR2;

@end
