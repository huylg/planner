//
//  ViewController.h
//  Microsoft Planner
//
//  Created by HuyLG on 7/3/19.
//  Copyright © 2019 HuyLG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlantableViewCell.h"
#import "AddNewPlanViewController.h"
@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,OptionButtonDelegate,AddNewPlanViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *planTableView;
@property NSMutableArray<NSMutableArray<Plan*>*> *planList;
@property NSMutableArray<Plan*> *rawPlanList;


@end

