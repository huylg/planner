//
//  FirebaseManager.m
//  Planner
//
//  Created by HuyLG on 7/23/19.
//  Copyright © 2019 HuyLG. All rights reserved.
//

#import "FirebaseManager.h"
#import <Firebase/Firebase.h>

@implementation FirebaseManager


+(void)editTask:(Task* )task
{
    static FIRDatabaseReference* fireDatabaseReference = nil;
    
    if(fireDatabaseReference == nil)
        fireDatabaseReference = [[FIRDatabase database] reference];
    
    [[[fireDatabaseReference child:@"tasks"] child:task.taskID]setValue:[task toNSDictionary]];
    
    
}

+(Bucket*)addNewBucket:(NSString*)bucketName andPlan:(Plan*)plan
{
    
    static FIRDatabaseReference* fireDatabaseReference = nil;
    
    if(fireDatabaseReference == nil)
        fireDatabaseReference = [[FIRDatabase database] reference];
    
    FIRDatabaseReference* child=[[fireDatabaseReference child:@"buckets"] childByAutoId];
    
    Bucket* bucket = [[Bucket alloc] init];
    
    bucket.name = bucketName;
    bucket.ID = [child key];
    
    [plan.bucketList  addObject:bucket];
    
    NSDictionary* nsDictionaryBucket = [[NSDictionary alloc] initWithObjectsAndKeys:bucketName,@"name",plan.id,@"planID", nil];
    
    [child setValue:nsDictionaryBucket];
    
    return bucket;
}

+(NSString*)addNewPlan:(Plan*)plan{
    
    static FIRDatabaseReference* fireDatabaseReference = nil;
    
    if(fireDatabaseReference == nil)
        fireDatabaseReference = [[FIRDatabase database] reference];
    
    
    
    FIRDatabaseReference* child = [[fireDatabaseReference child:@"plans"] childByAutoId];
    
    
    //add new plan to plan List Database
    [child setValue:[plan toNSDictionary]];
    
    
    NSDictionary* bucket = [[NSDictionary alloc] initWithObjectsAndKeys:@"Việc cần làm",@"name",child.key,@"planID", nil];
    
    
    
    //add default bucket
    
    FIRDatabaseReference* childBucket=[[fireDatabaseReference child:@"buckets"] childByAutoId];
    [childBucket setValue:bucket];
    
    Bucket* myBucket = [[Bucket alloc] init];
    myBucket.ID = [childBucket key];
    myBucket.name = @"Việc cần làm";
    
    [plan.bucketList addObject:myBucket];
    
    return child.key;
    
}


+(void)loadBucketList:(NSMutableArray<Plan*>*)planList{
    
    
    static FIRDatabaseReference* fireDatabaseReference = nil;
    
    if(fireDatabaseReference == nil)
        fireDatabaseReference = [[FIRDatabase database] reference];
    
    [[fireDatabaseReference child:@"buckets"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        
        
        NSEnumerator *children = [snapshot children];
        
        
        FIRDataSnapshot *child;
        while (child = [children nextObject]) {
            
            
            Bucket* bucket = [[Bucket alloc] init];
            
            bucket.ID = child.key;
            bucket.name = child.value[@"name"];
            
            NSUInteger count = planList.count;
            
            for(int i=0;i<count;i++)
            {
                if([planList[i].id isEqualToString:child.value[@"planID"]])
                    [planList[i].bucketList addObject:bucket];
                
            }
            
        }
    }];
    
    
}

+(NSString*)addNewTask:(Task*)task{
    
    static FIRDatabaseReference* fireDatabaseReference = nil;
    
    if(fireDatabaseReference == nil)
        fireDatabaseReference = [[FIRDatabase database] reference];
    
    FIRDatabaseReference* child=[[fireDatabaseReference child:@"tasks"] childByAutoId];
   
    [child setValue:[task toNSDictionary]];
   
    task.taskID = child.key;
    return child.key;
}

+(void)loadBucketListForSinglePlan:(Plan*)plan
{
    
    static FIRDatabaseReference* fireDatabaseReference = nil;
    
    if(fireDatabaseReference == nil)
        fireDatabaseReference = [[FIRDatabase database] reference];
    
    [[fireDatabaseReference child:@"buckets"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        NSEnumerator *children = [snapshot children];
        FIRDataSnapshot *child;
        while (child = [children nextObject]) {
            Bucket* bucket = [[Bucket alloc] init];
            bucket.ID = child.key;
            bucket.name = child.value[@"name"];
            if(plan.id == child.value[@"planID"])
                [plan.bucketList addObject:bucket];
        }
    }];
}

+(void)loadTaskList:(void (^)(Task* task))handler{

    static FIRDatabaseReference* fireDatabaseReference = nil;
    
    if(fireDatabaseReference == nil)
        fireDatabaseReference = [[FIRDatabase database] reference];
    
    [[fireDatabaseReference child:@"tasks"] observeEventType:FIRDataEventTypeChildAdded withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        
        Task* task = [[Task alloc] init];
        
        task.taskName = snapshot.value[@"name"];
        task.planName = snapshot.value[@"planName"];
        task.stage = [snapshot.value[@"stage"] intValue];
        task.bucketID = snapshot.value[@"bucketID"];
        task.taskID = snapshot.key;
        handler(task);
        
        
    }];
    
    
}


//+(void)addListenerAddChildInPlanList:(void (^)(Plan* planList))handler{
//
//
//
//        static FIRDatabaseReference* fireDatabaseReference = nil;
//
//        if(fireDatabaseReference == nil)
//            fireDatabaseReference = [[FIRDatabase database] reference];
//
//        [[fireDatabaseReference child:@"plans"] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
//
//            FIRDataSnapshot *child = snapshot;
//
//
//
//                Plan* plan = [[Plan alloc]init];
//
//                plan.namePlan = child.value[@"name"];
//
//                plan.id = child.key;
//
//                plan.stage = [child.value[@"stage"] intValue];
//
//                plan.privacy = [child.value[@"isPubliced rivacy"] boolValue];
//
//                plan.descriptionPlan = child.value[@"description"];
//
//                [parentView.planTableView beginUpdates];
//
//
//
//
//
//            if(plan.stage == 0){
//                [parentView.planList[plan.stage] addObject:plan];
//
//                NSArray *arr = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:parentView.planList[0].count -1  inSection:plan.stage]];
//                [parentView.planTableView insertRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationAutomatic];
//            }
//            else if(plan.stage == 1){
//
//                [parentView.planList[plan.stage] insertObject:plan atIndex:0];
//
//                NSArray *arr = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:plan.stage]];
//                [parentView.planTableView insertRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationAutomatic];
//
//
//            }
//            [parentView.rawPlanList addObject:plan];
//            [parentView.planTableView endUpdates];
//            [FirebaseManager loadBucketListForSinglePlan:plan];
//
//
//            }];
//
//
//}

+(void)loadPlanListByStageWithBlock:(void (^)(NSMutableArray* planList))handler{
    
    
    
    
    static FIRDatabaseReference* fireDatabaseReference = nil;
    
    if(fireDatabaseReference == nil)
        fireDatabaseReference = [[FIRDatabase database] reference];
    
    
    NSMutableArray<Plan*>* planList;
    planList = [[NSMutableArray alloc] init];
    
    
    
    
    [[fireDatabaseReference child:@"plans"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        
        
        NSEnumerator *children = [snapshot children];
        
        
        
        FIRDataSnapshot *child;
        while (child = [children nextObject]) {
            
            
            Plan* plan = [[Plan alloc]init];
            
            plan.namePlan = child.value[@"name"];
            
            plan.id = child.key;
            
            plan.stage = [child.value[@"stage"] intValue];
            
            plan.privacy = [child.value[@"isPubliced rivacy"] boolValue];
            
            plan.descriptionPlan = child.value[@"description"];
            
            [planList addObject:plan];
            
            
            
        }
        [FirebaseManager loadBucketList:planList];
        handler(planList);
    }];
    
    
}



@end
