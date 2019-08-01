//
//  AddNewPlanViewController.m
//  MicrosoftPlanner
//
//  Created by HuyLG on 7/3/19.
//  Copyright © 2019 HuyLG. All rights reserved.
//
#import "AddNewPlanViewController.h"
#import "PrivacyTableViewController.h"
#import "DescriptionViewController.h"
#import "Plan.h"
#import "Bucket.h"
#import "FirebaseManager.h"
@interface AddNewPlanViewController ()

@property (weak, nonatomic) IBOutlet UITableView *addNewPlanTableView;
@property NSMutableArray<UITableViewCell*> *cells;
@end

@implementation AddNewPlanViewController
UITextField* namePlanTextField;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    


    
    _cells = [[NSMutableArray<UITableViewCell*> alloc] init];
    namePlanTextField = [[UITextField alloc]init];
    UITableViewCell* namePlanTableViewCell = [[UITableViewCell alloc] init];
    
    
    
    //set placeholder for name plan text view
    namePlanTextField.textColor = UIColor.blackColor;
    [namePlanTextField setPlaceholder:@"Tên kế hoạch"];
    [namePlanTextField setFont:[UIFont systemFontOfSize:17.0f]];
    [namePlanTextField setFrame:CGRectMake(15, 25, 300, 40)];
    //add namePlanTextField to namePlaneTableViewCell
    [namePlanTableViewCell addSubview:namePlanTextField];

    [_cells addObject:namePlanTableViewCell];
    
    
    
    //create privacyTableViewCell
    UITableViewCell* privacytableViewCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"privacy"];
    
    [privacytableViewCell.textLabel setText:@"Quyền riêng tư"];
    [privacytableViewCell.detailTextLabel setText:@"Cộng đồng" ];
    
    
    [_cells addObject:privacytableViewCell];

    
    
    
    //create descriptionTableViewCell
    UITableViewCell* descriptionTableViewCell = [[UITableViewCell alloc]init];
    
    [descriptionTableViewCell.textLabel setText:@"Mô tả"];
    
    
    [_cells addObject:descriptionTableViewCell];
    
    
    //Add line to cell footer
    self.planListTableView.tableFooterView = [[UIView alloc]
                                              initWithFrame:CGRectZero];
   
    
    
    //createButton is disable
    [_createButton setBackgroundColor:UIColor.grayColor];
    [_createButton setEnabled:false];
    _createButton.layer.cornerRadius = 6; // this value vary as per your desire
    _createButton.clipsToBounds = YES;
    
    
    //namePlanTextField add acction begin
    
    [namePlanTextField addTarget:self action:@selector(namePlanTextFieldChange) forControlEvents:UIControlEventEditingChanged];
    
    
    //set accessory
    
    privacytableViewCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    descriptionTableViewCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    //create descriptionPlan
    
    _descriptionPlan = [[NSString alloc]init];
    

  
    //add backButton
    
  
    
    
    UIBarButtonItem *backButton = 	[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(backButtonClicked)];

    
    [self.navigationItem setLeftBarButtonItem:backButton];
    
    [self.navigationController.navigationBar setTintColor:[[UIColor alloc]initWithRed:77.0/255 green:111.0/255 blue:136.0/255 alpha:1]];
    
}

-(void)backButtonClicked{
    
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    //show tab bar
    self.tabBarController.tabBar.hidden = false;
    
    //change detail label of privacy label
    
    [_planListTableView.visibleCells[1].detailTextLabel setText:_isPublicSelected ? @"Cộng đồng" : @"Riêng tư"];
    
    

    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [namePlanTextField becomeFirstResponder];
    
}



-(void)namePlanTextFieldChange{
    if([namePlanTextField.text isEqualToString:@""])
    {
        //createButton is disable
        [_createButton setBackgroundColor:UIColor.grayColor];
        [_createButton setEnabled:false];
        
    }
    else
    {
        [_createButton setBackgroundColor:[[UIColor alloc]initWithRed:77.0/255 green:111.0/255 blue:136.0/255 alpha:1]];
        
        [_createButton setEnabled:true];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _cells.count;
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [_cells[indexPath.row] setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return _cells[indexPath.row];
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if(indexPath.row == 1){
        
       
        
        if([_planListTableView.visibleCells[1].detailTextLabel.text isEqualToString:@"Cộng đồng"] )
            [self performSegueWithIdentifier:@"CreateNewPlanViewControllerToPrivacyTableViewController" sender:[NSNumber numberWithBool:YES]];
        
        else
            [self performSegueWithIdentifier:@"CreateNewPlanViewControllerToPrivacyTableViewController" sender:[NSNumber numberWithBool:NO]];
        //hide toolbar
        self.tabBarController.tabBar.hidden = true;
    }
    else if(indexPath.row ==2){
    
        [self performSegueWithIdentifier:@"CreateNewPlanViewControllerToDecriptionController" sender:_descriptionPlan];
        //hide toolbar
        self.tabBarController.tabBar.hidden = true;
        
    }
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    
    if([segue.identifier isEqualToString:@"CreateNewPlanViewControllerToPrivacyTableViewController"])//jump to PrivacyViewController
    {
        PrivacyTableViewController* privacyTableViewConTroller = segue.destinationViewController;
        privacyTableViewConTroller.isPublicSelected = [(NSNumber*)sender boolValue];
    }
    else if([segue.identifier isEqualToString:@"CreateNewPlanViewControllerToDecriptionController"])//jump to DescriptionViewController
    {
        DescriptionViewController* descriptionViewController = segue.destinationViewController;
        descriptionViewController.descriptionPlan = (NSString*)sender;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == 0)
        return 90;
    else
        return 60;
    
}
- (IBAction)createButtonClicked:(id)sender {
    
    Plan* plan = [[Plan alloc]init];
    
    plan.namePlan = namePlanTextField.text;
    plan.stage = 1;
    plan.descriptionPlan = self.descriptionPlan;
    plan.privacy = _isPublicSelected;

    plan.id = [FirebaseManager addNewPlan:plan];
    
   
    [self.delegate AddNewPlan:plan];
    
     [self dismissViewControllerAnimated:false completion:nil];
}



@end
