//
//  TabBarControllerViewController.m
//  Planner
//
//  Created by HuyLG on 7/8/19.
//  Copyright © 2019 HuyLG. All rights reserved.
//

#import "TabBarControllerViewController.h"

@interface TabBarControllerViewController ()

@end

@implementation TabBarControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tabBar.items[0].title = @"Tác vụ của tôi";
    self.tabBar.items[0].image = [UIImage imageNamed:@"person"];
   
    
    
    self.tabBar.items[1].title = @"Trung tâm trình";
    self.tabBar.items[1].image = [UIImage imageNamed:@"circle"];
    
    self.tabBar.items[2].title = @"Thiết đặt";
    self.tabBar.items[2].image = [UIImage imageNamed:@"setting"];

    
    [self.tabBar setTintColor:[[UIColor alloc]initWithRed:77.0/255 green:111.0/255 blue:136.0/255 alpha:1]];


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
