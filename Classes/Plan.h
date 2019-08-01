//
//  Plan.h
//  Planner
//
//  Created by HuyLG on 7/11/19.
//  Copyright © 2019 HuyLG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bucket.h"
NS_ASSUME_NONNULL_BEGIN

@interface Plan : NSObject
@property NSString* namePlan;
@property(readwrite) NSString* descriptionPlan;
@property int stage;
@property int privacy;
@property NSString* id;
@property NSMutableArray<Bucket*>*bucketList;
- (NSDictionary*)toNSDictionary;

@end

NS_ASSUME_NONNULL_END
