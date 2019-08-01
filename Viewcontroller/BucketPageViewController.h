//
//  BucketPageViewController.h
//  Planner
//
//  Created by HuyLG on 7/23/19.
//  Copyright © 2019 HuyLG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Plan.h"
#import "BucketViewController.h"
#import "AddNewBucketViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface BucketPageViewController : UIPageViewController<UIPageViewControllerDataSource,BucketViewControllerDelegate,AddBucketViewControllerDelegate>
@property Plan* plan;
@property NSMutableArray<UIViewController*>* subViewControllerList;
@property NSUInteger pageIndex;

@end

NS_ASSUME_NONNULL_END
