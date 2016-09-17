#CHTInteractivePopGestureRecognizerDemo

*解决自定义界面返回按钮与iOS7系统返回手势冲突*

![](https://github.com/ChanRoy/CHTInteractivePopGestureRecognizerDemo/blob/master/CHTInteractivePopGestureRecognizerDemo.gif)

## 使用方法

* 实际项目中经常会自定义navigationBar的返回按钮，此时返回按钮跟系统的返回按钮会失效，可使用以下方法解决。

* 将项目中使用的所有navigationController都修改为继承于CHTNavigationController，即可解决。

* 具体看CHTNavigationController的代码：

#### 遵循协议：下方会用到
     @interface CHTNavigationController ()
     <UIGestureRecognizerDelegate, UINavigationControllerDelegate>
     @end

#### viewDidLoad 中设置代理	

	  - (void)viewDidLoad 
	  {
        [super viewDidLoad];
    
        //设置代理
        __weak typeof(CHTNavigationController) *weakSelf = self;
    
   		 if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
   		 {
        		self.delegate = weakSelf;
   		 }
   	  }
   	  
#### 重写navigationController方法

1.防止push viewController的时候触发滑动返回手势造成崩溃

     - (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
   		if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)] && animated == YES) {
        
        	//push的时候禁止掉滑动返回手势
        	self.interactivePopGestureRecognizer.enabled = NO;
    	}
    	[super pushViewController:viewController animated:animated];
	}
	
2.防止popToRootViewController的时候出发滑动返回手势造成崩溃

	 - (NSArray *)popToRootViewControllerAnimated:(BOOL)animated{
    
   		if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)] && animated == YES) {
        
        	//pop的时候禁止掉滑动返回手势
        	self.interactivePopGestureRecognizer.enabled = NO;
    	}
    	return [super popToRootViewControllerAnimated:YES];
	}
	
3.防止popToViewController的时候出发滑动返回手势造成崩溃

	- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    	if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)] && animated == YES) {
        
        	//pop的时候禁止掉滑动返回手势
        	self.interactivePopGestureRecognizer.enabled = NO;
   	 	}
    	return [super popToViewController:viewController animated:animated];
	}
	
#### navigationController 代理方法
1.加载完vc后打开滑动返回手势

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
	
## 当系统中有横向滑动的scrollview时，可通过添加UIScrollView+AllowPanGestureEventPass类别解决手势冲突

	- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
	{
    
    	//scrollview横向滑动与系统返回手势冲突解决
    	if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]] && self.contentOffset.y == 0)	{
        
        	[gestureRecognizer requireGestureRecognizerToFail:otherGestureRecognizer];
        
    	}

    	return  NO;
    
	}

*详细代码见demo*