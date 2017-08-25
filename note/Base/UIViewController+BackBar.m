//
//  UIViewController+BackBar.m
//  VSBuyComponent
//
//  Created by summer.zhu on 31/10/14.
//  Copyright (c) 2014年 test. All rights reserved.
//

#import "UIViewController+BackBar.h"
#import "objc/runtime.h"

static NSString *AnimationString = @"bAnimation";
static NSString *BacKBlockString = @"BackBlock";

@implementation UIViewController (BackBar)

- (void)useLeftBarItem:(BOOL)bUse back:(BackBlock)block{
    if (bUse) {
        UIImage *imageBack = [UIImage imageNamed:@"navigation_arrow_btn"];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:imageBack
                                                                 style:UIBarButtonItemStylePlain
                                                                target:self
                                                                action:@selector(pop)];
        [item setTintColor:[UIColor blackColor]];

        self.navigationItem.leftBarButtonItem = item;
        objc_setAssociatedObject(self, &BacKBlockString, block, OBJC_ASSOCIATION_COPY);
    }
}

- (void)pop{
    BackBlock backBlock = (BackBlock)objc_getAssociatedObject(self, &BacKBlockString);
    if (backBlock != nil) {
        backBlock();
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
