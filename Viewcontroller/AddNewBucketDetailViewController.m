//
//  AddNewBucketDetailViewController.m
//  Planner
//
//  Created by HuyLG on 7/29/19.
//  Copyright © 2019 HuyLG. All rights reserved.
//

#import "AddNewBucketDetailViewController.h"
@interface AddNewBucketDetailViewController ()

@end

@implementation AddNewBucketDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem * cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Huỷ" style:UIBarButtonItemStylePlain target:self action:@selector(cancelButtonClicked)];
    [self.navigationItem setLeftBarButtonItem:cancelButton];
    
    UIBarButtonItem * addButton = [[UIBarButtonItem alloc] initWithTitle:@"Thêm" style:UIBarButtonItemStylePlain target:self action:@selector(addNewBucket)];
    [addButton setEnabled:false];
    [self.navigationItem setRightBarButtonItem:addButton];

    [self.nameBucketTextField addTarget:self action:@selector(nameBucketTextFieldChange) forControlEvents:UIControlEventEditingChanged];
    
    
}


-(void)nameBucketTextFieldChange{
    
    if (self.nameBucketTextField.text && self.nameBucketTextField.text.length > 0)
        [self.navigationItem.rightBarButtonItem setEnabled:true];
    else
        [self.navigationItem.rightBarButtonItem setEnabled:false];

    
    
}

-(void)addNewBucket{
    
    Bucket* bucket=[FirebaseManager addNewBucket:self.nameBucketTextField.text andPlan:self.plan];
    
    //update UI
    
    [self.delegate addNewUIBucketViewController:bucket];
    [self.navigationController popViewControllerAnimated:false];

}

-(void)cancelButtonClicked{
    
    [self.navigationController popViewControllerAnimated:false];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationItem setTitle:self.plan.namePlan];

    

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
