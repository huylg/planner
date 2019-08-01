//
//  BucketViewController.m
//  Planner
//
//  Created by HuyLG on 7/23/19.
//  Copyright © 2019 HuyLG. All rights reserved.
//

#import "BucketViewController.h"
#import "BucketPageViewController.h"
@interface BucketViewController ()
{
    UITextField* nameTaskTextField;
    UIView* nameTaskFooterView;
    UIButton* calendarButton;
    UIButton* memberButton;
    UIButton* addButton;
}

@end

@implementation BucketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    
    
    [self.bucketNameLabel setText:self.bucket.name];

    CGRect dropdownImageFrame = self.dropdownImage.frame;
    
    [self.bucketNameLabel sizeToFit];
    
    dropdownImageFrame.origin.x = self.bucketNameLabel.frame.size.width+15;
    
    [self.dropdownImage setFrame:dropdownImageFrame];
    
    
    
}

- (void)viewDidAppear:(BOOL)animated{
    

    [self.delegate BucketViewControllerDidAppear:self.pageIndex];
    
    
    }

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)nameTaskTextFieldChange{
    
    if(nameTaskTextField.text.length > 0)
    {
        [addButton setEnabled:true];
        [addButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        
    }
    else
    {
        [addButton setEnabled:false];
        [addButton setTitleColor:UIColor.lightGrayColor forState:UIControlStateNormal];
        
    }
    
}

- (IBAction)addTaskButtonClick:(id)sender {
    
    
    
    
    [_addTaskButton setHidden:true];
    
    CGRect nameTaskTextFieldFrame = _addTaskButton.frame;
    nameTaskTextFieldFrame.size.height = 55;
    
    if(nameTaskTextField == nil)
    {
        nameTaskTextField = [[UITextField alloc] initWithFrame:nameTaskTextFieldFrame];
        [nameTaskTextField addTarget:self action:@selector(nameTaskTextFieldChange) forControlEvents:UIControlEventEditingChanged];
        [nameTaskTextField setBackgroundColor:UIColor.whiteColor];
    }
    
    [self.view addSubview:nameTaskTextField];
    
    CGRect footViewFrame = _addTaskButton.frame;
    
    footViewFrame.origin.y = nameTaskTextFieldFrame.origin.y + nameTaskTextFieldFrame.size.height;
    footViewFrame.size.height = 50;
    
    if(nameTaskFooterView == nil)
    {
        nameTaskFooterView = [[UIView alloc] initWithFrame:footViewFrame];
        [nameTaskFooterView setBackgroundColor:[UIColor colorWithRed:245.0/255 green:246.0/255 blue:248.0/255 alpha:1]];
        
        calendarButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 13.5, 20, 20)];
        
        [calendarButton setImage:[UIImage imageNamed:@"calendar"] forState:UIControlStateNormal];
        
        [nameTaskFooterView addSubview:calendarButton];
        
        
        memberButton = [[UIButton alloc] initWithFrame:CGRectMake(80, 13.5, 20, 20)];

        [memberButton setImage:[UIImage imageNamed:@"member"] forState:UIControlStateNormal];
        
        [nameTaskFooterView addSubview: memberButton];
        
        
        addButton = [[UIButton alloc] initWithFrame:CGRectMake(300, 10, 40, 30)];
        [addButton setEnabled:false];
        [addButton setTitleColor:UIColor.lightGrayColor forState:UIControlStateNormal];
        [addButton addTarget:self action:@selector(addButtonClicked) forControlEvents:UIControlEventTouchDown];
        [addButton setTitle:@"Add" forState:UIControlStateNormal];
        [addButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        
        
        
        [nameTaskFooterView addSubview:addButton];
        
      
    }

    UIViewController* parentView = self.parentViewController;
    
    [parentView.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelClicked)]];
    [self.view addSubview:nameTaskFooterView];
}
-(void)addButtonClicked{

    Task* task = [[Task alloc] init];
    
    task.taskName = nameTaskTextField.text;
    task.planName = self.parentViewController.navigationItem.title;
    task.bucketID = _bucket.ID;
    task.stage = 0;
    
    
    [FirebaseManager addNewTask:task];

    [self cancelClicked];

}

-(void)cancelClicked{
    
    [nameTaskTextField removeFromSuperview];
    nameTaskTextField.text = @"";
    [self nameTaskTextFieldChange ];
    
    [nameTaskFooterView removeFromSuperview];
    [self.addTaskButton setHidden:false];
    UIViewController* parentView = self.parentViewController;
    [parentView.navigationItem setLeftBarButtonItem:nil];

}


@end
