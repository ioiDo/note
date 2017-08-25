//
//  BasicMainNC.m
//  App
//
//  Created by apple on 2017/1/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "BaseNavController.h"
#import "UIImage+Extension.h"

@interface BaseNavController ()

@end

@implementation BaseNavController

- (void)loadView {
    [super loadView];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage createImageWithColor:[UIColor whiteColor]] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
//    self.navigationBar.barStyle = UIBarStyleBlack;//去除nav底边线条
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) { // 这时push进来的控制器viewController，不是第一个子控制器（不是根控制器）
        /* 自动显示和隐藏tabbar */
        viewController.hidesBottomBarWhenPushed = YES;
        
    }
    
    [super pushViewController:viewController animated:animated];
    
//    if (self.viewControllers.count > 0) {
//        CATransition *animation = [CATransition animation];
//        animation.duration = 0.5f;
//        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//        animation.type = kCATransitionPush;
//        animation.subtype = kCATransitionFromRight;
//        [self.view.layer addAnimation:animation forKey:nil];
//        [super pushViewController:viewController animated:NO];
//        return;
//    }
//    [super pushViewController:viewController animated:YES];
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
