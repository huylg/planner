//
//  PlanListTableViewCell.h
//  Planner
//
//  Created by HuyLG on 7/16/19.
//  Copyright © 2019 HuyLG. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface PlanListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *avatarLabel;
@property (weak, nonatomic) IBOutlet UILabel *planNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;

@end

NS_ASSUME_NONNULL_END
