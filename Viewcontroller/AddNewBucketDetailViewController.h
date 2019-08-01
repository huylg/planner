//
//  AddNewBucketDetailViewController.h
//  Planner
//
//  Created by HuyLG on 7/29/19.
//  Copyright © 2019 HuyLG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Plan.h"
#import "FirebaseManager.h"
NS_ASSUME_NONNULL_BEGIN

@protocol AddNewBucketDetailViewControllerDelegate <NSObject>

@optional
-(void)addNewUIBucketViewController:(Bucket*)bucket;

@end

@interface AddNewBucketDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nameBucketTextField;
@property Plan* plan;

@property (nonatomic, strong) id<AddNewBucketDetailViewControllerDelegate>  delegate;

@end

NS_ASSUME_NONNULL_END
