//
//  Parser.m
//  Timeline
//
//  Created by mihael on 16.01.13.
//  Copyright (c) 2013 Mihael Isaev. All rights reserved.
//

#import "Parser.h"

@implementation Parser

+(NSArray*)parseActivityJSONData:(NSData*)data
{
    NSError *error = nil;
    NSArray *result = [[NSArray alloc] initWithObjects: nil];
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if(!error)
    {
        @try {
            NSArray *activity = [json objectForKey:CSJSONKeyUserActivity];
            if(activity)
                result = [activity copy];
            NSDictionary *user = [json objectForKey:CSJSONKeyUser];
            if(user)
            {
                [AppDelegate saveString:[user objectForKey:CSJSONKeyUserFirstName] forKey:CSCurrentUserFirstName];
                [AppDelegate saveString:[user objectForKey:CSJSONKeyUserLastName] forKey:CSCurrentUserLastName];
                [AppDelegate saveString:[user objectForKey:CSJSONKeyUserPhoto] forKey:CSCurrentUserPhoto];
            }
        }
        @catch (NSException *exception) {
            #if DEBUG
            NSLog(@"parseActivityJSONData error: %@", exception);
            #endif
        }
    }
    return result;
}

+(NSArray*)parseCommentsJSONData:(NSData*)data
{
    NSError *error = nil;
    NSArray *result = [[NSArray alloc] initWithObjects: nil];
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if(!error)
    {
        @try {
            NSArray *comments = [json objectForKey:CSJSONKeyComments];
            result = [comments copy];
        }
        @catch (NSException *exception) {
            #if DEBUG
            NSLog(@"parseActivityJSONData error: %@", exception);
            #endif
        }
    }
    return result;
}

@end
