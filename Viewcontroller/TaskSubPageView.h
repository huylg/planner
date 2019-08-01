//
//  TaskSubPageView.h
//  Planner
//
//  Created by HuyLG on 7/8/19.
//  Copyright © 2019 HuyLG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"
#import "TaskTableViewCell.h"
#import "FirebaseManager.h"
NS_ASSUME_NONNULL_BEGIN

@protocol TaskSubViewDelegate <NSObject>


@required

-(void) TaskSubViewDidAppear:(int)pageIndex;
-(void) changeStageButtonClicked:(Task*)task destView:(int)destView ;
@end

@interface TaskSubPageView : UIViewController<UITableViewDelegate,UITableViewDataSource,TaskTableViewCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *label;

@property(nonatomic, retain) NSMutableArray<Task*>* tasks;
    
@property NSString* labelText;
@property int pageIndex;
@property (nonatomic, strong) id<TaskSubViewDelegate>  delegate;
@end


NS_ASSUME_NONNULL_END
