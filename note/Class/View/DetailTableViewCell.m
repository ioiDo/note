//
//  DetailTableViewCell.m
//  note
//
//  Created by apple on 2017/8/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DetailTableViewCell.h"

@implementation DetailTableViewCell

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
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
