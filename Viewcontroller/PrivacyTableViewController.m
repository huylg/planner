//
//  PrivacyTableViewController.m
//  Planner
//
//  Created by HuyLG on 7/9/19.
//  Copyright © 2019 HuyLG. All rights reserved.
//

#import "PrivacyTableViewController.h"
#import "AddNewPlanViewController.h"
@interface PrivacyTableViewController (){

    NSArray<NSString*>* labelTexts;
    NSUInteger index;
}
@end

@implementation PrivacyTableViewController


- (void)viewDidLoad{

    labelTexts = [[NSArray<NSString*> alloc] initWithObjects:@"Riêng tư",@"Cộng đồng", nil];
    index = [self.navigationController.viewControllers indexOfObject:self];//create indexPage

    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    
    
    
    
    
    AddNewPlanViewController* parentView = self.navigationController.viewControllers[index-1];
    
    parentView.isPublicSelected = self.
    isPublicSelected;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
 UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"PrivacyTableViewCell" forIndexPath:indexPath];
    
    
    [cell.textLabel setText:labelTexts[indexPath.row]];
    
    if(indexPath.row == _isPublicSelected)
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    else
        cell.accessoryType =UITableViewCellAccessoryNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    _isPublicSelected = indexPath.row;
    
    [tableView reloadData];
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
