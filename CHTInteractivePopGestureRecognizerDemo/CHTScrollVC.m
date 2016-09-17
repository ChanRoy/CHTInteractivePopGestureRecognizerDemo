//
//  CHTScrollVC.m
//  CHTInteractivePopGestureRecognizerDemo
//
//  Created by cht on 16/9/17.
//  Copyright © 2016年 Roy Chan. All rights reserved.
//

#import "CHTScrollVC.h"
#import "CHTScrollItemBar.h"

#define SCREEN_WIDTH        [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT       [UIScreen mainScreen].bounds.size.height
#define RandomColor [UIColor colorWithRed:(random() % 256 / 255.0f) green:(random() % 256 / 255.0f) blue:(random() % 256 / 255.0f) alpha:1]

@interface CHTScrollVC ()

@end

@implementation CHTScrollVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *titles = @[@"小明",@"小红",@"小刚",@"小雪",@"小鱼",@"小江"];
    UIScrollView *relevantScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT - 40)];
    relevantScrollView.pagingEnabled = YES;
    relevantScrollView.showsHorizontalScrollIndicator = NO;
    relevantScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * titles.count, CGRectGetHeight(relevantScrollView.frame));
    relevantScrollView.bounces = NO;
    [self.view addSubview:relevantScrollView];
    
    for (NSInteger i = 0; i < titles.count; i ++) {
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, CGRectGetHeight(relevantScrollView.frame))];
        view.backgroundColor = RandomColor;
        [relevantScrollView addSubview:view];
    }
    
    CHTScrollItemBar *itemBar = [[CHTScrollItemBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    [itemBar setupItemTitles:titles relevantScrollView:relevantScrollView];
    itemBar.textFont = [UIFont systemFontOfSize:15.0f];
    itemBar.textNormalColor = [UIColor grayColor];
    itemBar.textSelectedColor = [UIColor purpleColor];
    itemBar.sliderColor = [UIColor blueColor];
    [self.view addSubview:itemBar];


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
