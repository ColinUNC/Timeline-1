//
//  DataHelper.h
//  Timeline
//
//  Created by mihael on 16.01.13.
//  Copyright (c) 2013 Mihael Isaev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Connection.h"
#import "Parser.h"

@interface Data : NSObject

+(NSArray*)getActivityArrayForUserID:(NSString*)userID
                           withLimit:(int)limit
                           andOffset:(int)offset;
+(NSArray*)getCommentsArrayForTargetID:(NSString*)targetID
                             withLimit:(int)limit
                             andOffset:(int)offset;

@end
