//
//  BasicMainVC.h
//  App
//
//  Created by apple on 2017/1/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (nonatomic, assign) NSInteger pageCount;
@property (nonatomic, strong) NSDictionary *dic;

- (void)setTitleStr:(NSString *)title;
- (void)setTitleStr:(NSString *)title withColor:(UIColor *)color;

- (void)setNetData;
- (void)addRefreshHeader;
- (void)addRefreshFooter;
- (void)endRefresh;

@end
