//
//  PlantableViewCell.h
//  Planner
//
//  Created by HuyLG on 7/11/19.
//  Copyright © 2019 HuyLG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Plan.h"
NS_ASSUME_NONNULL_BEGIN


@protocol OptionButtonDelegate <NSObject>

@required
-(void)optionButtonClick:(Plan*)plan;
@end

@interface PlantableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *avatarLabel;
@property (weak, nonatomic) IBOutlet UILabel *namePlanLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *optionButton;

@property (weak, nonatomic) Plan* plan;

@property (nonatomic,assign) NSObject<OptionButtonDelegate>* delegate;
- (IBAction)optionButtonClicked:(id)sender;


@end

NS_ASSUME_NONNULL_END
