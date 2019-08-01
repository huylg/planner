//
//  DescriptionViewController.m
//  Planner
//
//  Created by HuyLG on 7/9/19.
//  Copyright © 2019 HuyLG. All rights reserved.
//

#import "DescriptionViewController.h"
#import "AddNewPlanViewController.h"
@interface DescriptionViewController (){

    NSUInteger index;

}

@end

@implementation DescriptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
     index = [self.navigationController.viewControllers indexOfObject:self];//create indexPage
    
    if(![self.descriptionPlan isEqualToString:@""])
    {
        _placeholder.hidden = true;
        
    }
    
    self.descriptionPlanTextView.text = self.descriptionPlan;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{

    if([self.descriptionPlan isEqualToString:@""])
    {
        _placeholder.hidden = true;
    }
    return true;
}


- (void)viewWillDisappear:(BOOL)animated{
    
    
   
    self.descriptionPlan = self.descriptionPlanTextView.text;
    
    
    
    AddNewPlanViewController* parentView = self.navigationController.viewControllers[index-1];
    
    parentView.descriptionPlan = self.descriptionPlan;
    
    
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
