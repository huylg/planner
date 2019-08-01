//
//  TaskPageViewController.m
//  Planner
//
//  Created by HuyLG on 7/8/19.
//  Copyright © 2019 HuyLG. All rights reserved.
//

#import "TaskPageViewController.h"
#import "TaskSubPageView.h"
#import "Task.h"

@interface TaskPageViewController (){
    
    
    
}

@end

@implementation TaskPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    UIActivityIndicatorView* loadingView = [[UIActivityIndicatorView alloc] init];
    
    [loadingView setCenter:self.view.center];
    loadingView.hidesWhenStopped = true;
    loadingView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    
    [self.view addSubview:loadingView];
    
    [loadingView startAnimating];
    

    
    
    self.dataSource = self;
    self.delegate = self;
    
  
    
    TaskSubPageView * notYesStartTaskView = [self.storyboard instantiateViewControllerWithIdentifier:@"TaskSubPageView"];
    
    TaskSubPageView * processingTaskView =[self.storyboard instantiateViewControllerWithIdentifier:@"TaskSubPageView"];
    
    TaskSubPageView * finishedTaskView =[self.storyboard instantiateViewControllerWithIdentifier:@"TaskSubPageView"];
    
    
    NSMutableArray<Task*>* notStartedTask = [[NSMutableArray alloc] init];
    NSMutableArray<Task*>* processingTask = [[NSMutableArray alloc] init];
    NSMutableArray<Task*>* finishedTask = [[NSMutableArray alloc] init];
    
    NSMutableArray<Task*>* tasks = [[NSMutableArray alloc] init];
    
  
    [FirebaseManager loadTaskList:^(Task * _Nonnull task) {
        
        task.members = [[NSMutableArray alloc] initWithObjects:[[Member alloc]initWithName:@"person1" andAvatarUrl:@"https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50"],nil];
        
        [tasks addObject:task];
        
        
        if(task.stage == 0)
        {
            [notStartedTask addObject:task];
            [notYesStartTaskView.tableView reloadData];
        }
        else if(task.stage == 1)
        {
            [processingTask addObject:task];
            [processingTaskView.tableView reloadData];
        }
        else
        {
            [finishedTask addObject:task];
            [finishedTaskView.tableView reloadData];

        }
        
    
            [loadingView stopAnimating];

        
    }];
    
//    Task* task = [[Task alloc] init];
//
//    task.planName = @"Software As A Service.VcloudCam";
//    task.taskName = @"[IOS] Các tính năng cho phần xem lại";
//    task.members = [[NSMutableArray alloc] initWithObjects:[[Member alloc]initWithName:@"person1" andAvatarUrl:@"https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50"],nil];
//
//    [tasks addObject:task];
//
//
//    Task* task1 = [[Task alloc] init];
//
//    task1.planName = @"Software As A Service.VcloudCam";
//    task1.taskName = @"[IOS] Hiển thị thông báo khi camera mất kết nối/kết nối lại Hiển thị thông báo khi camera mất kết nối/kết nối lại Hiển thị thông báo khi camera mất kết nối/kết nối lại Hiển thị thông báo khi camera mất kết nối/kết nối lại ";
//    task1.members = [[NSMutableArray alloc] initWithObjects:[[Member alloc]initWithName:@"person1" andAvatarUrl:@"https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50"],nil];
//
//    [tasks addObject:task1];
    
    
    

    
    
    _pageIndex = 0;
    _subViews = [[NSMutableArray alloc] init];
   
    notYesStartTaskView.labelText = @"Chưa bắt đầu";
    notYesStartTaskView.pageIndex = 0;
    notYesStartTaskView.delegate = self;
    notYesStartTaskView.tasks = notStartedTask;
    
    
    
    processingTaskView.labelText = @"Đang thực hiện";
    processingTaskView.pageIndex = 1;
    processingTaskView.delegate = self;
    processingTaskView.tasks = processingTask;
    
   
    
    finishedTaskView.labelText = @"Hoàn thành";
    finishedTaskView.pageIndex = 2;
    finishedTaskView.delegate = self;
    finishedTaskView.tasks = finishedTask;
    
    [_subViews addObject:notYesStartTaskView];
    
    [_subViews addObject:processingTaskView];
    
    [_subViews addObject:finishedTaskView];
    
    [self setViewControllers:@[notYesStartTaskView] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    

    [self.view setBackgroundColor:[UIColor colorWithRed:237.0/255 green:238.0/255 blue:242.0/255 alpha:1]];
    
    
    UIBarButtonItem* optionButton = [[UIBarButtonItem  alloc] initWithImage:[UIImage imageNamed:@"option"] style:UIBarButtonItemStylePlain target:self action:nil];
    
    [self.navigationItem setRightBarButtonItem:optionButton];
    
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithDisplayP3Red:77.0/255 green:111.0/255 blue:136.0/255 alpha:1]];
}



- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{

    
    if(_pageIndex== 0)
        return nil;
   
    
    
    
    return _subViews[_pageIndex-1];

}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
 

    if(_pageIndex == _subViews.count-1)
        return nil;

    

    return _subViews[_pageIndex+1];
    
}

-(void) TaskSubViewDidAppear:(int)pageIndex{

    _pageIndex = pageIndex;

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(void) changeStageButtonClicked:(Task*)task destView:(int)destView{
    
    
    [_subViews[destView].tasks addObject:task];
    [_subViews[destView].tableView reloadData];
}



@end
