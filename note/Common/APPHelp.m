//
//  APPHelp.m
//  Track
//
//  Created by apple on 2017/4/20.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "APPHelp.h"
#import "MBProgressHUD.h"

@interface APPHelp (){
}

@end

@implementation APPHelp

MBProgressHUD *HUD;
+ (void)showTip:(NSString *)tip inView:(UIView *)view{
    if (HUD) {
        HUD.hidden = YES;
        [HUD removeFromSuperview];
        HUD = nil;
    }
    HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.animationType = MBProgressHUDAnimationZoom;
    HUD.label.text = tip;
    HUD.yOffset = -50;
    HUD.removeFromSuperViewOnHide = YES;
    [HUD hideAnimated:YES afterDelay:1.2];
}

@end
