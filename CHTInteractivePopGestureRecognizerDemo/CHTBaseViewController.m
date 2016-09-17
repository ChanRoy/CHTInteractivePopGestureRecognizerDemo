//
//  CHTBaseViewController.m
//  CHTInteractivePopGestureRecognizerDemo
//
//  Created by cht on 16/9/17.
//  Copyright © 2016年 Roy Chan. All rights reserved.
//

#import "CHTBaseViewController.h"

@interface CHTBaseViewController ()

//自定义的返回按钮
@property (nonatomic, strong) UIButton *navBackBtn;

@end

@implementation CHTBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //统一设置navigationBar的背景色
    [self getBackView:self.navigationController.navigationBar Color:[UIColor whiteColor]];
    
    if (self.navigationItem && self.navigationController.viewControllers.count  > 1) {
        
        //自定义返回按钮
        [self creatBackBtn];
    }
}


- (void)creatBackBtn{
    
    _navBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _navBackBtn.frame = CGRectMake(0, 0, 14, 24);
    [_navBackBtn setImage:[UIImage imageNamed:@"Nav_Back_Btn"] forState:UIControlStateNormal];
    [_navBackBtn addTarget:self action:@selector(backBarBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_navBackBtn];
}

- (void)backBarBtnClick:(UIButton *)navBackBtn{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -  设navigationBar的背景颜色
- (void)getBackView:(UIView *)View Color:(UIColor *)color{
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    
    if ([View isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")]) {
        //背景颜色清除
        [UIView animateWithDuration:0 animations:^{
            View.backgroundColor = color;
            [UIView commitAnimations];
        }];
    }else if ([View isKindOfClass:NSClassFromString(@"_UIBackdropView")]){
        //将_UINavigationBarBackground上面的遮罩层隐藏
        View.backgroundColor = color;
        View.hidden = YES;
    }
    
    for (UIView *view in View.subviews) {
        [UIView animateWithDuration:0 animations:^{
            [self getBackView:view Color:color];       //递归遍历NavBar视图
            [UIView commitAnimations];
        }];
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
