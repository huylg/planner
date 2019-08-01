//
//  BucketPageViewController.m
//  Planner
//
//  Created by HuyLG on 7/23/19.
//  Copyright © 2019 HuyLG. All rights reserved.
//

#import "BucketPageViewController.h"
#import "BucketViewController.h"
#import "AddNewBucketViewController.h"
@interface BucketPageViewController ()

@end




@implementation BucketPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = self;
    
    [self.navigationItem setTitle:_plan.namePlan];
    
    
    self.subViewControllerList = [[NSMutableArray alloc] init];

    for(int i=0;i<self.plan.bucketList.count;i++)
    {
        BucketViewController* bucketViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"BucketViewController"];
        
        bucketViewController.bucket = self.plan.bucketList[i];
        bucketViewController.delegate = self;
        bucketViewController.pageIndex = i;
        
        
        [self.subViewControllerList addObject:bucketViewController];
    }
    
    
    AddNewBucketViewController* addNewBucketViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AddNewBucketViewController"];
    addNewBucketViewController.delegate = self;
    addNewBucketViewController.pageIndex = self.subViewControllerList.count;
    addNewBucketViewController.plan = self.plan;
    
    [self.subViewControllerList addObject:addNewBucketViewController];
    
    
    _pageIndex = 0;
    [self setViewControllers:@[self.subViewControllerList
                               .firstObject] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];

    // Do any additional setup after loading the view.

    [self.view setBackgroundColor:[UIColor colorWithRed:237.0/255 green:238.0/255 blue:242.0/255 alpha:1]];

}


- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    
    if(_pageIndex ==0)
        return nil;
    
    return self.subViewControllerList[_pageIndex-1];
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    
    if(_pageIndex == self.subViewControllerList.count-1)
        return nil;
    
    return self.subViewControllerList[_pageIndex+1];
    
}

- (void)AddBucketViewControllerDidAppear:(NSUInteger)pageIndex{
    
    self.pageIndex = pageIndex;
    
}

- (void)BucketViewControllerDidAppear:(NSUInteger)pageIndex{
    
    self.pageIndex = pageIndex;
    
}

- (void)addNewUIBucketViewController:(Bucket*)bucket{
    

    AddNewBucketViewController* addNewBucketViewController = self.subViewControllerList.lastObject;

    addNewBucketViewController.pageIndex = self.subViewControllerList.count;

    BucketViewController* bucketViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"BucketViewController"];
    
    bucketViewController.bucket = bucket;
    bucketViewController.delegate = self;
    bucketViewController.pageIndex = self.subViewControllerList.count-1;
    
    [self.subViewControllerList insertObject:bucketViewController atIndex:bucketViewController.pageIndex];
    
    self.pageIndex++;
    
    [self setViewControllers:@[bucketViewController] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
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
