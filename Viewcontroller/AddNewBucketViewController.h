//
//  AddNewBucketViewController.h
//  Planner
//
//  Created by HuyLG on 7/23/19.
//  Copyright © 2019 HuyLG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddNewBucketDetailViewController.h"
#import "Plan.h"
NS_ASSUME_NONNULL_BEGIN

@protocol AddBucketViewControllerDelegate <NSObject>

@required
- (void)AddBucketViewControllerDidAppear:(NSUInteger)pageIndex;
- (void)addNewUIBucketViewController:(Bucket*)bucket;

@end

@interface AddNewBucketViewController : UIViewController<AddNewBucketDetailViewControllerDelegate>
@property NSUInteger pageIndex;
@property (nonatomic, strong) id<AddBucketViewControllerDelegate>  delegate;
- (IBAction)addNewBucketButtonClick:(id)sender;
@property Plan* plan;
@end

NS_ASSUME_NONNULL_END
