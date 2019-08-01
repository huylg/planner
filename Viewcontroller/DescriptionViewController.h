//
//  DescriptionViewController.h
//  Planner
//
//  Created by HuyLG on 7/9/19.
//  Copyright © 2019 HuyLG. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DescriptionViewController : UIViewController<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *descriptionPlanTextView;
@property (weak, nonatomic) IBOutlet UILabel *placeholder;
@property NSString* descriptionPlan;
@end

NS_ASSUME_NONNULL_END
