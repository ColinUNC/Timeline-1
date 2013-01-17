//
//  DataHelper.m
//  Timeline
//
//  Created by mihael on 16.01.13.
//  Copyright (c) 2013 Mihael Isaev. All rights reserved.
//

#import "Data.h"

@implementation Data

+(NSArray*)getActivityArrayForUserID:(NSString*)userID
                           withLimit:(int)limit
                           andOffset:(int)offset
{
    NSArray *result = [[NSArray alloc] initWithObjects: nil];
    NSData *json = [Connection getActivityJSONDataForUserID:userID withLimit:limit andOffset:offset];
    result = [Parser parseActivityJSONData:json];
    return result;
}

+(NSArray*)getCommentsArrayForTargetID:(NSString*)targetID
                             withLimit:(int)limit
                             andOffset:(int)offset
{
    NSArray *result = [[NSArray alloc] initWithObjects: nil];
    NSData *json = [Connection getCommentsJSONDataForTargetID:targetID withLimit:limit andOffset:offset];
    result = [Parser parseCommentsJSONData:json];
    return result;
}

@end
