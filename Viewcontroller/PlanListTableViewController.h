//
//  PlanListTableViewController.h
//  Planner
//
//  Created by HuyLG on 7/16/19.
//  Copyright © 2019 HuyLG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Plan.h"
NS_ASSUME_NONNULL_BEGIN

@interface PlanListTableViewController : UITableViewController<UISearchBarDelegate>
- (IBAction)favoriteButton:(id)sender;
@property NSMutableArray<Plan*> *planList;
@end

NS_ASSUME_NONNULL_END
