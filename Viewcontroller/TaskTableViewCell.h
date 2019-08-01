//
//  TaskTableViewCell.h
//  Planner
//
//  Created by HuyLG on 7/10/19.
//  Copyright © 2019 HuyLG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"
NS_ASSUME_NONNULL_BEGIN

@protocol TaskTableViewCellDelegate <NSObject>

@required
-(void)changeStageButton:(Task*)task;

@end

@interface TaskTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *namePlanLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameTaskLabel;
@property (weak, nonatomic) IBOutlet UIView *lineUIView;
@property (weak, nonatomic) IBOutlet UIButton *changeStageButton;
- (IBAction)changeStageButtonClick:(id)sender;
@property (nonatomic, strong) id<TaskTableViewCellDelegate>  delegate;

@property Task* task;
@end

NS_ASSUME_NONNULL_END
