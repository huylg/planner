//
//  TaskPageViewController.h
//  Planner
//
//  Created by HuyLG on 7/8/19.
//  Copyright © 2019 HuyLG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskSubPageView.h"

NS_ASSUME_NONNULL_BEGIN




@interface TaskPageViewController : UIPageViewController<UIPageViewControllerDataSource,TaskSubViewDelegate>
@property int pageIndex;
@property NSMutableArray<TaskSubPageView *>* subViews;

@end

NS_ASSUME_NONNULL_END
