//
//  Member.h
//  Planner
//
//  Created by HuyLG on 7/30/19.
//  Copyright © 2019 HuyLG. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Member : NSObject

@property NSString* name;
@property NSString* avatarURL;

-(instancetype)initWithName:(NSString*)name andAvatarUrl:(NSString*)url;

@end

NS_ASSUME_NONNULL_END
