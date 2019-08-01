//
//  Member.m
//  Planner
//
//  Created by HuyLG on 7/30/19.
//  Copyright © 2019 HuyLG. All rights reserved.
//

#import "Member.h"

@implementation Member

- (instancetype)initWithName:(NSString *)name andAvatarUrl:(NSString *)url{
    
    self.name = name;
    self.avatarURL = url ;
    
    return self;
}


@end
