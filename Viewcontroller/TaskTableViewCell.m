    //
//  TaskTableViewCell.m
//  Planner
//
//  Created by HuyLG on 7/10/19.
//  Copyright © 2019 HuyLG. All rights reserved.
//

#import "TaskTableViewCell.h"

@implementation TaskTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
    
    // Configure the view for the selected state
}

- (IBAction)changeStageButtonClick:(id)sender {
    
    [_delegate changeStageButton:_task];
    
    
}
@end
