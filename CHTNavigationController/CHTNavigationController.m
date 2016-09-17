//
//  CHTNavigationController.m
//  CHTInteractivePopGestureRecognizerDemo
//
//  Created by cht on 16/9/17.
//  Copyright © 2016年 Roy Chan. All rights reserved.
//

#import "CHTNavigationController.h"


@interface CHTNavigationController () <UIGestureRecognizerDelegate, UINavigationControllerDelegate>

@end

@implementation CHTNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置代理
    __weak typeof(CHTNavigationController) *weakSelf = self;
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.delegate = weakSelf;
    }

}

#pragma mark - super methods

//防止push viewController的时候触发滑动返回手势造成崩溃
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)] && animated == YES) {
        
        //push的时候禁止掉滑动返回手势
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    [super pushViewController:viewController animated:animated];
}

//防止popToRootViewController的时候出发滑动返回手势造成崩溃
- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated{
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)] && animated == YES) {
        
        //pop的时候禁止掉滑动返回手势
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    return [super popToRootViewControllerAnimated:YES];
}

//防止popToViewController的时候出发滑动返回手势造成崩溃
- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)] && animated == YES) {
        
        //pop的时候禁止掉滑动返回手势
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    return [super popToViewController:viewController animated:animated];
}

#pragma mark - navigationController delegate

//加载完vc后打开滑动返回手势
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        //加载完vc后打开滑动返回手势
        self.interactivePopGestureRecognizer.enabled = YES;
    }
    
    if (navigationController.viewControllers.count == 1) {
        
        //防止在根控制器中push卡死
        navigationController.interactivePopGestureRecognizer.enabled = NO;
        navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
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
