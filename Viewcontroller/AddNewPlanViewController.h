//
//  AddNewPlanViewController.h
//  MicrosoftPlanner
//
//  Created by HuyLG on 7/3/19.
//  Copyright © 2019 HuyLG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Plan.h"
NS_ASSUME_NONNULL_BEGIN

@protocol AddNewPlanViewControllerDelegate <NSObject>

@required

-(void) AddNewPlan:(Plan*)plan;



@end

@interface AddNewPlanViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *planListTableView;
@property (weak, nonatomic) IBOutlet UIButton *createButton;
- (IBAction)createButtonClicked:(id)sender;
@property bool isPublicSelected;
@property NSString* descriptionPlan;
@property (nonatomic, strong) id<AddNewPlanViewControllerDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
