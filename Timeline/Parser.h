//
//  Parser.h
//  Timeline
//
//  Created by mihael on 16.01.13.
//  Copyright (c) 2013 Mihael Isaev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

#define CSJSONKeyUser @"User"
#define CSJSONKeyUserFirstName @"first_name"
#define CSJSONKeyUserLastName @"last_name"
#define CSJSONKeyUserPhoto @"profile_photo"
#define CSJSONKeyComments @"Comments"
#define CSJSONKeyUserActivity @"UserActivity"

@interface Parser : NSObject

+(NSArray*)parseActivityJSONData:(NSData*)data;
+(NSArray*)parseCommentsJSONData:(NSData*)data;

@end
