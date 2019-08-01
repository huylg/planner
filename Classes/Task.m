//
//  Task.m
//  Planner
//
//  Created by HuyLG on 7/10/19.
//  Copyright © 2019 HuyLG. All rights reserved.
//

#import "Task.h"

@implementation Task
- (NSDictionary*) toNSDictionary{
    
    NSDictionary<NSString*,NSObject*> *result = [NSDictionary dictionaryWithObjectsAndKeys:self.taskName,@"name",self.bucketID,@"bucketID",[NSNumber numberWithInteger:self.stage],@"stage",self.planName,@"planName", nil];
    
    return result;
    
}
@end
