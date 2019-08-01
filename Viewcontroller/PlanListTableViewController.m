//
//  PlanListTableViewController.m
//  Planner
//
//  Created by HuyLG on 7/16/19.
//  Copyright © 2019 HuyLG. All rights reserved.
//

#import "PlanListTableViewController.h"
#import "Plan.h"
#import "PlanListTableViewCell.h"
#import <FIRDatabase.h>
#import "ViewController.h"
#import "BucketPageViewController.h"
@interface PlanListTableViewController (){
    NSArray<NSString*> *stageList;
    NSArray<UIColor*> *colorList;
    FIRDatabaseReference* fireDatabaseReference;
    NSMutableArray<Plan*> *rawPlanList;
}
@end

@implementation PlanListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    stageList = [[NSArray alloc]initWithObjects:@"Yêu thích",@"Gần đây", nil];
    colorList = [[NSArray alloc]initWithObjects:[[UIColor alloc]initWithRed:22.0/255 green:120.0/255 blue:123.0/255 alpha:1],[[UIColor alloc]initWithRed:117.0/255 green:72/255 blue:253.0/255 alpha:1], [[UIColor alloc]initWithRed:213.0/255 green:51.0/255 blue:5.0/255 alpha:1],[[UIColor alloc]initWithRed:106.0/255 green:106.0/255 blue:106.0/255 alpha:1],[[UIColor alloc]initWithRed:207.0/255 green:14.0/255 blue:191.0/255 alpha:1],[[UIColor alloc]initWithRed:236.0/255 green:2.0/255 blue:18.0/255 alpha:1],[[UIColor alloc]initWithRed:207.0/255 green:14.0/255 blue:191.0/255 alpha:0.8],nil];
    
    
    //add search bar to navigation bar
    
    [self.navigationItem setSearchController: [[UISearchController alloc]initWithSearchResultsController:nil]];
    [self.navigationItem.searchController.searchBar setPlaceholder:@"Tìm kiếm"];
    
    [self.navigationItem.searchController.searchBar setDelegate:self];
    [self.navigationItem.searchController setDimsBackgroundDuringPresentation:NO];
    [self.navigationItem.searchController setHidesNavigationBarDuringPresentation:NO];
    
    //init fireDatabaseReference
    
    fireDatabaseReference = [[FIRDatabase database] reference];

    rawPlanList = [[NSMutableArray<Plan*> alloc]init];

    for(Plan* plan in _planList)
        [rawPlanList addObject:plan];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
  
    
    UIBarButtonItem* backButton = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    
    
    
    self.navigationItem.backBarButtonItem = backButton;
    
}

#pragma mark - Table view data source



- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [_planList removeAllObjects];
    
    
    for(Plan* plan in rawPlanList)
            [_planList addObject:plan];
    
    [self.tableView reloadData];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{

    [_planList removeAllObjects];
    
    
    for(Plan* plan in rawPlanList)
    {

        if([[plan.namePlan lowercaseString] containsString:[searchText lowercaseString]]  || [searchText isEqualToString:@""])
            [_planList addObject:plan];
      
    }
    
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _planList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PlanListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlanListTableViewCell" forIndexPath:indexPath];
    
    [cell.planNameLabel setText:_planList[indexPath.row].namePlan];
    
    NSArray<NSString*>* listItem = [cell.planNameLabel.text componentsSeparatedByString:
                                    @" "];
    
    
    if(listItem.count == 1)
    {
        [cell.avatarLabel setText:[listItem[0] substringToIndex:1]];
    }
    else{
        
        NSString* str = [[NSString alloc] initWithFormat:(@"%@%@"),[listItem[0] substringToIndex:1],[listItem[listItem.count-1] substringToIndex:1]];
        
        [cell.avatarLabel setText:str];
        
    }
    
    
    NSUInteger hash = [cell.planNameLabel.text hash]%colorList.count;
    
    [cell.avatarLabel setBackgroundColor:colorList[hash]];
    
    if(_planList[indexPath.row].stage == 0)
        [cell.favoriteButton setImage:[UIImage imageNamed:@"filledStar"] forState:UIControlStateNormal];
    else
        [cell.favoriteButton setImage:[UIImage imageNamed:@"unfilledStar"] forState:UIControlStateNormal];

    [cell.favoriteButton setTag:indexPath.row];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
        return 60;
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationItem.hidesSearchBarWhenScrolling = false;

    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self performSegueWithIdentifier:@"PlanListTableViewControllerToPlanInfoViewController" sender:_planList[indexPath.row]];
    
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"PlanListTableViewControllerToPlanInfoViewController"])
    {
        
        BucketPageViewController* destView = segue.destinationViewController;
        
        destView.plan = sender;
        
        
    }
    
}


- (IBAction)favoriteButton:(id)sender {
    
    
    ViewController* previousView = self.navigationController.viewControllers.firstObject;
    
    
    
    NSInteger rowIndexPath = [sender tag];
    
    Plan* plan =_planList[rowIndexPath];
    
    for(int i=0;i<=2;i++)
    {
        NSUInteger index =[previousView.planList[i] indexOfObject:plan];
        if( index != NSNotFound)
        {
            [previousView.planList[i] removeObject:plan];
            if(i<=1)
                [previousView.planTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:index inSection:i]] withRowAnimation:UITableViewRowAnimationNone];
            break;
        }
    }
    
    
    if(plan.stage == 0)
        plan.stage = 2;
    else
        plan.stage  = 0;

    
     [previousView.planList[plan.stage] addObject:plan];
    
    if(plan.stage<=1)
        [previousView.planTableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:previousView.planList[plan.stage].count-1 inSection:plan.stage]] withRowAnimation:UITableViewRowAnimationNone];
    
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:rowIndexPath inSection:0];
    PlanListTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    if(plan.stage == 0)
        [cell.favoriteButton setImage:[UIImage imageNamed:@"filledStar"] forState:UIControlStateNormal];
    else
        [cell.favoriteButton setImage:[UIImage imageNamed:@"unfilledStar"] forState:UIControlStateNormal];
    
    
    [[[[fireDatabaseReference child:@"plans"] child:plan.id] child:@"stage"] setValue:[NSNumber numberWithInteger:plan.stage]];
    
    

}
@end
