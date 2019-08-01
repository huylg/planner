//
//  ViewController.m
//  MicrosoftPlanner
//
//  Created by HuyLG on 7/3/19.
//  Copyright © 2019 HuyLG. All rights reserved.
//

#import "ViewController.h"
#import "Plan.h"
#import "PlantableViewCell.h"
#import "AddNewPlanViewController.h"
#import "PlanListTableViewController.h"
#import "Bucket.h"
#import "FirebaseManager.h"
#import "BucketPageViewController.h"
@interface ViewController (){
    
    NSArray<NSString*> *stageList;
    NSArray<UIColor*>* colorList;
    FIRDatabaseReference *fireDatabaseReference;
}

@end

@implementation ViewController



- (void)addButtonClicked{
    
    
    AddNewPlanViewController* view =  [self.storyboard instantiateViewControllerWithIdentifier:@"AddNewPlanViewController"];
    
    UINavigationController* nav = [[UINavigationController  alloc] initWithRootViewController:view];
    
    [self.navigationController presentViewController:nav animated:true completion:nil];
    
    view.delegate = self;
    
    
}

- (void)AddNewPlan:(Plan *)plan{
    
    [self.planTableView beginUpdates];
    
    
    
    
    
    if(plan.stage == 0){
        [self.planList[plan.stage] addObject:plan];
        
        NSArray *arr = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:self.planList[0].count -1  inSection:plan.stage]];
        [self.planTableView insertRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    else if(plan.stage == 1){
        
        [self.planList[plan.stage] insertObject:plan atIndex:0];
        
        NSArray *arr = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:plan.stage]];
        [self.planTableView insertRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationAutomatic];
        
        
    }
    [self.rawPlanList addObject:plan];
    [self.planTableView endUpdates];
    [FirebaseManager loadBucketListForSinglePlan:plan];
    
    
    [self performSegueWithIdentifier:@"ViewControllerToBucketPageViewController" sender:plan];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UIBarButtonItem* searchButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchBarSearchButtonClicked)];
    
    UIBarButtonItem* addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonClicked)   ];
    
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:searchButton,addButton, nil];
    
    //init firebase database reference
    
    fireDatabaseReference = [[FIRDatabase database] reference];
    
    
    
    stageList = [[NSArray alloc]initWithObjects:@"Yêu thích",@"Gần đây", nil];
    //load plan list
    
    self.planList = [[NSMutableArray alloc] initWithCapacity:3];
    
    self.planList[0] = [[NSMutableArray alloc] init];
    self.planList[1] = [[NSMutableArray alloc] init];
    self.planList[2] = [[NSMutableArray alloc] init];
    [FirebaseManager loadPlanListByStageWithBlock:^(NSMutableArray<Plan *>* _Nonnull planList) {
        self.rawPlanList = planList;
        
        for(int i=0 ;i<planList.count;i++)
        {
            if(planList[i].stage == 0)
                [self.planList[0] addObject:planList[i]];
            else if(planList[i].stage == 1)
                [self.planList[1] insertObject:planList[i] atIndex:0];
            
        }
        
        [self.planTableView reloadData];
    }];
    
    
    
    colorList = [[NSArray alloc]initWithObjects:[[UIColor alloc]initWithRed:22.0/255 green:120.0/255 blue:123.0/255 alpha:1],[[UIColor alloc]initWithRed:117.0/255 green:72/255 blue:253.0/255 alpha:1], [[UIColor alloc]initWithRed:213.0/255 green:51.0/255 blue:5.0/255 alpha:1],[[UIColor alloc]initWithRed:106.0/255 green:106.0/255 blue:106.0/255 alpha:1],[[UIColor alloc]initWithRed:207.0/255 green:14.0/255 blue:191.0/255 alpha:1],[[UIColor alloc]initWithRed:236.0/255 green:2.0/255 blue:18.0/255 alpha:1],[[UIColor alloc]initWithRed:207.0/255 green:14.0/255 blue:191.0/255 alpha:0.8],nil];
    
    
    
    [self.planTableView registerNib:[UINib nibWithNibName:@"planCell" bundle:nil] forCellReuseIdentifier:@"PlanTableViewCell"];
    
    //dismiss empty cell
    self.planTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    
    //hide back button tiltle
    UIBarButtonItem* backButton = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
 
    
    
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithDisplayP3Red:77.0/255 green:111.0/255 blue:136.0/255 alpha:1]];
    
}






- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
   
    [self performSegueWithIdentifier:@"ViewControllerToBucketPageViewController" sender:self.planList[indexPath.section][indexPath.row]];

    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView* headerView = [[UIView alloc]init];
    [headerView setBackgroundColor:[UIColor colorWithRed:(245.0/255) green:(245.0/255) blue:(245.0/255) alpha:1]];
    UILabel* label = [[UILabel alloc]initWithFrame: CGRectMake(10, 0, 200, 40)];
    [label setText:stageList[section]];
    [label setFont:[UIFont systemFontOfSize:16]];
    [headerView addSubview:label];
    
    return headerView;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.planList[section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PlantableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"planCell"];
    
    Plan* plan  = _planList[indexPath.section][indexPath.row];
    
    if(!cell){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PlanTableViewCell" owner:self options:nil] objectAtIndex:0];
    }
    
    
    [cell.namePlanLabel setText:plan.namePlan];
    [cell.descriptionLabel setText:plan.descriptionPlan];
    
    NSArray<NSString*>* listItem = [cell.namePlanLabel.text componentsSeparatedByString:
                                    @" "];
    
    if(listItem.count == 1)
    {
        [cell.avatarLabel setText:[listItem[0] substringToIndex:1]];
    }
    else{
        
        NSString* str = [[NSString alloc] initWithFormat:(@"%@%@"),[listItem[0] substringToIndex:1],[listItem[listItem.count-1] substringToIndex:1]];
        
        [cell.avatarLabel setText:str];
        
    }
    
    
    NSUInteger hash = [cell.namePlanLabel.text hash]%colorList.count;
    
    [cell.avatarLabel setBackgroundColor:colorList[hash]];
    
    int heightOfCell=75;
    
    if(indexPath.section == 1)
        heightOfCell = 60;
    
    
    
    //resize avatar label
    CGRect avatarLabelFrame = cell.avatarLabel.frame;
    
    avatarLabelFrame.size.width  = heightOfCell;
    
    [cell.avatarLabel setFrame:avatarLabelFrame];
    
    //relocated namePlanLabel
    
    
    CGRect namePlanLabelFrame = cell.namePlanLabel.frame;
    
    namePlanLabelFrame.origin.x = avatarLabelFrame.size.width + 10;
    
    [cell.namePlanLabel setFrame: namePlanLabelFrame];
    
    
    //relocated descriptionPlanLabel
    CGRect descriptionPlanLabelFrame = cell.descriptionLabel.frame;
    
    descriptionPlanLabelFrame.origin.x = avatarLabelFrame.size.width + 10;
    
    [cell.descriptionLabel setFrame: descriptionPlanLabelFrame];
    
    
    cell.plan = plan;
    
    cell.delegate = self;
    
    
    
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 1)
        return 60;
    
    return 85;
}

- (void)viewDidAppear:(BOOL)animated{
    self.navigationController.navigationBar.prefersLargeTitles = true;

}

- (void)viewWillAppear:(BOOL)animated{
    [self.tabBarController.tabBar setHidden:false];

}


- (void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.prefersLargeTitles = false;
}



-(void)searchBarSearchButtonClicked{
    
    [self performSegueWithIdentifier:@"PlanListVCToPlanListTableViewController" sender:nil];
    
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"PlanListVCToPlanListTableViewController"])
    {
        
        
        PlanListTableViewController* destView = segue.destinationViewController;
        
        destView.planList = self.rawPlanList;
        
        [self.tabBarController.tabBar setHidden:true];
        
    }
    else if([segue.identifier isEqualToString:@"ViewControllerToBucketPageViewController"])
    {
        
        BucketPageViewController* destView = segue.destinationViewController;
        
        destView.plan = sender;
        
        [self.tabBarController.tabBar setHidden:true];

    }
    
}

- (void)optionButtonClick:(Plan *)plan{
    
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:[_planList[plan.stage] indexOfObject:plan] inSection:plan.stage] ;
    
    
    
    
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:_planList[indexPath.section][indexPath.row].namePlan
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    if(indexPath.section == 0)
    {
        
        
        UIAlertAction* removeFromFavoriteList = [UIAlertAction actionWithTitle:@"Xoá khỏi danh sách yêu thích" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
            
            [[[[self->fireDatabaseReference child:@"plans"] child:plan.id] child:@"stage"] setValue:@2];
            
            self->_planList[indexPath.section][indexPath.row].stage = 2;
            
            
            [self->_planList[2] addObject:plan];
            [self->_planList[indexPath.section] removeObject:plan];
            
            
            
            [self->_planTableView beginUpdates];
            NSArray *oldPosition = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]];
            
            [self->_planTableView deleteRowsAtIndexPaths:oldPosition withRowAnimation:UITableViewRowAnimationAutomatic];
            
            [self->_planTableView endUpdates];
            
            
        }];
        UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Huỷ" style:UIAlertActionStyleCancel handler:nil];
        
        [alert addAction:removeFromFavoriteList];
        [alert addAction:cancel];
        
    }
    else
    {
        
        
        UIAlertAction* addToFavoriteList = [UIAlertAction actionWithTitle:@"Thêm vào danh sách yêu thích" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [[[[self->fireDatabaseReference child:@"plans"] child:plan.id] child:@"stage"] setValue:@0];
            
            self->_planList[indexPath.section][indexPath.row].stage = 0;
            
            
            [self->_planList[0] addObject:plan];
            [self->_planList[indexPath.section] removeObject:plan];
            
            
            
            NSIndexPath *oldPosition = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
            NSIndexPath *newPoistion = [NSIndexPath indexPathForRow:self->_planList[0].count-1 inSection:0];
            
            
            [self->_planTableView moveRowAtIndexPath:oldPosition toIndexPath:newPoistion];
            [self->_planTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:newPoistion, nil] withRowAnimation:UITableViewRowAnimationNone];
            
            
            
            
            
        }];
        
        
        UIAlertAction* removeFromRecentList = [UIAlertAction actionWithTitle:@"Xoá khỏi danh sách gần đây" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
            [[[[self->fireDatabaseReference child:@"plans"] child:plan.id] child:@"stage"] setValue:@2];
            
            self->_planList[indexPath.section][indexPath.row].stage = 2;
            
            
            [self->_planList[2] addObject:plan];
            [self->_planList[indexPath.section] removeObject:plan];
            
            
            
            [self->_planTableView beginUpdates];
            NSArray *oldPosition = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]];
            
            [self->_planTableView deleteRowsAtIndexPaths:oldPosition withRowAnimation:UITableViewRowAnimationAutomatic];
            
            [self->_planTableView endUpdates];
            
        }];
        UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Huỷ" style:UIAlertActionStyleCancel handler:nil];
        
        [alert addAction:addToFavoriteList];
        [alert addAction:removeFromRecentList];
        [alert addAction:cancel];
        
    }
    
    [self presentViewController:alert animated:YES completion:nil];
    
}




@end
