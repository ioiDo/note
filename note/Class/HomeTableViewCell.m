//
//  HomeTableViewCell.m
//  note
//
//  Created by apple on 2017/8/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "HomeTableViewCell.h"

@implementation HomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = kColorBackView;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.cellBackView.layer.cornerRadius = 3;
    self.cellBackView.clipsToBounds = YES;
    //投影
    self.cellBackView.layer.shadowOpacity = 0.8;
    self.cellBackView.layer.shadowColor = kColorBack2.CGColor;
    self.cellBackView.layer.shadowOffset = CGSizeMake(0, 5);
    self.cellBackView.layer.shadowRadius = 5;
    self.stateLab.transform = CGAffineTransformMakeRotation(-M_PI/4);
}

- (void)setModel:(ProjectModel *)model {
    _model = model;
    self.projectName.text = [NSString stringWithFormat:@"%@",_model.name];
    self.firstPart.text = [NSString stringWithFormat:@"甲方：%@",_model.firstParty];
    self.money.text = [NSString stringWithFormat:@"预算：%@",_model.money];
    self.labR2.text = [NSString stringWithFormat:@"收/支：%@/%@",_model.money,_model.money];
    self.time.text = [NSString stringWithFormat:@"%@",_model.dateTime];
    self.stateLab.text = [SwitchType orderStateFromType:_model.state];
}

- (void)setDetailModel:(DetailModel *)detailModel {
    self.stateLab.hidden = YES;
    _detailModel = detailModel;
    self.projectName.text = [NSString stringWithFormat:@"%@",_detailModel.projectName];
    self.firstPart.text = [NSString stringWithFormat:@"金额：%@",_detailModel.money];
    self.labR1.text = [NSString stringWithFormat:@"类别：%@",[SwitchType detailCategoryFromType:_detailModel.category]];
    self.money.text = [NSString stringWithFormat:@"备注：%@",_detailModel.note];
    self.time.text = [NSString stringWithFormat:@"%@",_detailModel.dateTime];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
