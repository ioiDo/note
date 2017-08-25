//
//  TimePickView.h
//  App
//
//  Created by apple on 2017/2/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DateBlock)(NSString *);

@interface TimePickView : UIView

@property (nonatomic, strong) DateBlock block;
@property (nonatomic, strong) NSString *mode;

- (void)show;
- (instancetype)initWithMode:(NSString *)model;

@end
