//
//  BucketViewController.h
//  Planner
//
//  Created by HuyLG on 7/23/19.
//  Copyright © 2019 HuyLG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Bucket.h"
#import "FirebaseManager.h"
#import "Task.h"
NS_ASSUME_NONNULL_BEGIN

@protocol BucketViewControllerDelegate <NSObject>

@required
- (void)BucketViewControllerDidAppear:(NSUInteger)pageIndex;

@end

@interface BucketViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *bucketNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *dropdownImage;
- (IBAction)addTaskButtonClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *addTaskButton;

@property NSUInteger pageIndex;
@property (nonatomic, strong) id<BucketViewControllerDelegate>  delegate;
@property Bucket* bucket;   
@end

NS_ASSUME_NONNULL_END
