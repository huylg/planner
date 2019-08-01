 //
//  Plan.m
//  Planner
//
//  Created by HuyLG on 7/11/19.
//  Copyright © 2019 HuyLG. All rights reserved.
//

#import "Plan.h"

@implementation Plan

- (instancetype)init
{
    self = [super init];
    if (self) {
        _bucketList = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSDictionary*) toNSDictionary{
    
    NSDictionary<NSString*,NSObject*> *result = [NSDictionary dictionaryWithObjectsAndKeys:self.namePlan,@"name",self.descriptionPlan,@"description",[NSNumber numberWithInteger:self.stage],@"stage",[NSNumber numberWithBool:self.privacy],@"isPublicedPrivacy", nil];
    
   
    
    
    return result;
    
}


@end
