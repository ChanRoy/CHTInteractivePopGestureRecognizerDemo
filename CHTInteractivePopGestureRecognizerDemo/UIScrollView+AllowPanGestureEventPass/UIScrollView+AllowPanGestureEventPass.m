//
//  UIScrollView+AllowPanGestureEventPass.m
//  WangyiDemo
//
//  Created by cht on 16/3/1.
//  Copyright © 2016年 qfangwanghk. All rights reserved.
//

#import "UIScrollView+AllowPanGestureEventPass.h"

@implementation UIScrollView (AllowPanGestureEventPass)


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    
    //scrollview横向滑动与系统返回手势冲突解决
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]] && self.contentOffset.y == 0){
        
        [gestureRecognizer requireGestureRecognizerToFail:otherGestureRecognizer];
        
    }

    return  NO;
    
}



@end
