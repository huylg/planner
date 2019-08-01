//
//  TaskSubPageView.m
//  Planner
//
//  Created by HuyLG on 7/8/19.
//  Copyright © 2019 HuyLG. All rights reserved.
//

#import "TaskSubPageView.h"
#import "TaskTableViewCell.h"



@interface TaskSubPageView (){

    NSMutableArray* newCellHeights;
    NSArray<NSString*>* texts;
    UIRefreshControl* refreshController;
}

@end

@implementation TaskSubPageView



- (void)viewDidLoad {
    [super viewDidLoad];

    
    newCellHeights = [[NSMutableArray alloc] init];


    
    [self.label setText:_labelText];
    
    
   
    
    refreshController = [[UIRefreshControl alloc] init];
    [refreshController addTarget:self action:@selector(refreshControllerAction) forControlEvents:UIControlEventValueChanged];
    [self.tableView setRefreshControl:refreshController];

}


-(void)refreshControllerAction{

    [self.tableView reloadData];
    [refreshController endRefreshing];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return _tasks.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    CGFloat newCellHeight;


    TaskTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"] ;
    
    cell.delegate = self;
    
    cell.task = _tasks[indexPath.section];
    
    [cell.namePlanLabel setText:_tasks[indexPath.section].planName];
    [cell.nameTaskLabel setText:_tasks[indexPath.section].taskName];

   
    
    CGRect nameTaskLabelFrame = [cell.nameTaskLabel.text boundingRectWithSize:CGSizeMake(cell.nameTaskLabel.frame.size.width, CGFLOAT_MAX)
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:@{NSFontAttributeName: cell.nameTaskLabel.font}
                                             context:nil];
    nameTaskLabelFrame.origin = cell.nameTaskLabel.frame.origin;
    nameTaskLabelFrame.size.width = cell.nameTaskLabel.frame.size.width;
    cell.nameTaskLabel.frame = nameTaskLabelFrame;
//    [cell.nameTaskLabel setBackgroundColor:UIColor.blueColor];
    
    //relocated changeStageButton
    CGRect changeStageButtonFrame = cell.changeStageButton.frame;
    changeStageButtonFrame.origin.y = nameTaskLabelFrame.size.height + nameTaskLabelFrame.origin.y + 5;
    cell.changeStageButton.frame = changeStageButtonFrame;
    
    //relocated lineUIView
    CGRect lineUIViewFrame = cell.lineUIView.frame;
    lineUIViewFrame.origin.y = changeStageButtonFrame.size.height + changeStageButtonFrame.origin.y + 5;
    cell.lineUIView.frame = lineUIViewFrame;
    
    
    
    
    
    UIView* footerView = [[UIView alloc] initWithFrame:CGRectMake(0, lineUIViewFrame.origin.y+2, cell.frame.size.width, 60)];
    [footerView setBackgroundColor:UIColor.whiteColor];
    
    
    
    
    
    NSMutableArray<Member*>* members = _tasks[indexPath.section].members;
    
    for(int i=0;i<members.count;i++)
    {

          UIImageView* avatar = [[UIImageView alloc]initWithFrame:CGRectMake(i*55+10, 5, 50, 50)];
        
        avatar.layer.borderWidth = 1;
        avatar.layer.masksToBounds = false;
        avatar.layer.borderColor = UIColor.whiteColor.CGColor;
        avatar.layer.cornerRadius = avatar.frame.size.height/2;
        avatar.clipsToBounds = true;
        
        NSURL* url = [[NSURL alloc]initWithString:members[i].avatarURL];
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration:NSURLSessionConfiguration.defaultSessionConfiguration];

       NSURLSessionDataTask* dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            if(error != nil)
                NSLog(@"error: %@",error);
            else
            {
                
              
                dispatch_async(dispatch_get_main_queue(), ^{
                    [avatar setImage:[UIImage imageWithData:data]];
                });
                

            }
            
        }];

        [dataTask resume];
        [footerView addSubview: avatar];

      
    }
    
    if(members.count == 1 )
    {
        
        
        UILabel* nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 5, 100, 50)];
        [nameLabel setText:members[0].name];
        [nameLabel setFont:[UIFont systemFontOfSize:14]];
        
        
        [footerView addSubview: nameLabel];
        
    }
    
    [cell addSubview:footerView];
    
    //set new size for uiTableView
    newCellHeight = footerView.frame.origin.y + footerView.frame.size.height;
    
    NSNumber* newCellHeightNSNumber = [[NSNumber alloc] initWithFloat:newCellHeight];
    
    [newCellHeights addObject:newCellHeightNSNumber];
    //set tag for button
    //[cell.changeStageButton setTag:indexPath.section];


    
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    cell.layer.shadowColor = UIColor.blackColor.CGColor;
    cell.layer.shadowOpacity = 0.23;
    cell.layer.shadowRadius = 4;
   
    return cell;
    

}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    return [[UIView alloc] init];
}



- (void)viewDidAppear:(BOOL)animated{

    
    
    [_delegate TaskSubViewDidAppear:_pageIndex];
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 10;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return [newCellHeights[indexPath.section] floatValue];

}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)changeStageButton:(Task *)task{
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:task.taskName
                                                            preferredStyle:UIAlertControllerStyleActionSheet]; // 1
    
    NSArray<NSString*> *labels = [[NSArray alloc]initWithObjects:@"Chưa bắt đầu",@"Đang thực hiện",@"Hoàn thành", nil];
    
    for(int i=0;i<labels.count;i++){
        
        if([labels[i] isEqualToString:_labelText])
            continue;
        
        __weak TaskSubPageView *weakSelf = self;
        UIAlertAction* alertAction = [UIAlertAction actionWithTitle:labels[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            @try {
                
                [weakSelf.delegate changeStageButtonClicked:task destView:i];
                task.stage = i;
                
                [FirebaseManager editTask:task];
                
                NSUInteger index = [weakSelf.tasks indexOfObject:task];

                [weakSelf.tasks removeObject:task];
                [self->newCellHeights removeObjectAtIndex:index];
                
                
                [weakSelf.tableView deleteSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:UITableViewRowAnimationFade];
                
                
                
                
                
            } @catch (NSException *exception) {
                NSLog(@"excrption");
            } @finally {
                
            }
        }];
        [alert addAction:alertAction];
        
    }
    
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Huỷ" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
        
        
    }];
    
    
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil]; // 6
    
}


@end

