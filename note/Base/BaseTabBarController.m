//
//  BasicTabBarC.m
//  App
//
//  Created by apple on 2017/1/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "BaseTabBarController.h"
#import "HomeViewController.h"
#import "DetailViewController.h"
#import "SettingViewController.h"
#import "BaseNavController.h"

@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setVCs];
}

- (void)setVCs {
    HomeViewController *hvc = [[HomeViewController alloc]init];
    [self.navigationController pushViewController:hvc animated:YES];
    [self addChildVc:hvc title:@"项目" image:@"home" selectedImage:@"home_select"];
    DetailViewController *cvc = [[DetailViewController alloc]init];
    [self addChildVc:cvc title:@"详情" image:@"periphery" selectedImage:@"periphery_select"];
    SettingViewController *mvc = [[SettingViewController alloc]init];
    [self addChildVc:mvc title:@"设置" image:@"mine" selectedImage:@"mine_select"];
    self.selectedIndex = 0;
}

/**
 *  添加一个子控制器
 *
 *  @param childVc       子控制器
 *  @param title         标题
 *  @param image         图片
 *  @param selectedImage 选中的图片
 */
- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置子控制器的文字
    childVc.title = title; // 同时设置tabbar和navigationBar的文字
    childVc.tabBarItem.image = [[UIImage imageNamed:image]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 先给外面传进来的小控制器 包装 一个导航控制器
    BaseNavController *nav = [[BaseNavController alloc] initWithRootViewController:childVc];
    [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];
    // 添加为子控制器
    [self addChildViewController:nav];
}

@end
