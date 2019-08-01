//
//  Task.h
//  Planner
//
//  Created by HuyLG on 7/10/19.
//  Copyright © 2019 HuyLG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import"Member.h"
NS_ASSUME_NONNULL_BEGIN



@interface Task:NSObject
@property NSString* _Nullable planName;
@property NSString* _Nullable taskName;
@property NSMutableArray<Member*>*  members;
@property NSString* bucketID;
@property NSString* taskID;
- (NSDictionary*)toNSDictionary;

@property int stage;
@end
NS_ASSUME_NONNULL_END
