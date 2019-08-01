//
//  PlantableViewCell.m
//  Planner
//
//  Created by HuyLG on 7/11/19.
//  Copyright © 2019 HuyLG. All rights reserved.
//

#import "PlantableViewCell.h"

@implementation PlantableViewCell




- (IBAction)optionButtonClicked:(id)sender {
 
    
    [_delegate optionButtonClick:_plan];
}
@end
