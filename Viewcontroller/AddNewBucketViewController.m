//
//  AddNewBucketViewController.m
//  Planner
//
//  Created by HuyLG on 7/23/19.
//  Copyright © 2019 HuyLG. All rights reserved.
//

#import "AddNewBucketViewController.h"

@interface AddNewBucketViewController ()

@end

@implementation AddNewBucketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated{
    
    [_delegate AddBucketViewControllerDidAppear:self.pageIndex];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)addNewBucketButtonClick:(id)sender {
    
    AddNewBucketDetailViewController* subView = [[[NSBundle mainBundle] loadNibNamed:@"AddNewBucketDetailViewController" owner:self options:nil] firstObject];

    
    subView.plan = self.plan;
    
    subView.delegate = self;
    
    [self.navigationController pushViewController:subView animated:false];
    

    
    
}


- (void)addNewUIBucketViewController:(Bucket*)bucket
{
    
    
    [self.delegate addNewUIBucketViewController:bucket];
    
    
}


@end
