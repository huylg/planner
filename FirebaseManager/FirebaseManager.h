//
//  FirebaseManager.h
//  Planner
//
//  Created by HuyLG on 7/23/19.
//  Copyright © 2019 HuyLG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Plan.h"
#import "Bucket.h"
#import <Firebase/Firebase.h>
#import "ViewController.h"
#import "Task.h"
NS_ASSUME_NONNULL_BEGIN

@interface FirebaseManager : NSObject

+(NSString*)addNewPlan:(Plan*)plan;

+(void)loadBucketList:(NSMutableArray<Plan*>*)planList;

+(void)loadPlanListByStageWithBlock:(void (^)(NSMutableArray* planList))handler;

//+(void)addListenerAddChildInPlanList:(void (^)(Plan* planList))handler;
+(void)loadBucketListForSinglePlan:(Plan*)plan;

+(Bucket*)addNewBucket:(NSString*)bucketName andPlan:(Plan*)plan;

+(NSString*)addNewTask:(Task*)task;

+(void)loadTaskList:(void (^)(Task* task))handler;

+(void)editTask:(Task* )task;

@end

NS_ASSUME_NONNULL_END
