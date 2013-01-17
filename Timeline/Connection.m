//
//  ConnectionHelper.m
//  Timeline
//
//  Created by mihael on 16.01.13.
//  Copyright (c) 2013 Mihael Isaev. All rights reserved.
//

#import "Connection.h"

@implementation Connection

+(NSData*)requestToUrl:(NSString*)url withParams:(NSDictionary*)params andType:(NSString*)type
{
    NSData *responseData = [NSData data];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSMutableString *paramsString = [[NSMutableString alloc] initWithString:@""];
    if(params!=nil){
        NSArray *keys = [params allKeys];
        for (int i=0;i<keys.count;i++)
        {
            NSString *key = [keys objectAtIndex:i];
            NSString *value = [params objectForKey:key];
            [paramsString appendString:[NSString stringWithFormat:@"%@=%@", key, value]];
            if(i<keys.count-1)
                [paramsString appendString:@"&"];
        }
        [request setHTTPBody:[paramsString dataUsingEncoding:NSUTF8StringEncoding]];
    }
    [request setHTTPMethod:type];
    [request setCachePolicy:NSURLRequestReloadRevalidatingCacheData];
    [request setTimeoutInterval:10];
    NSHTTPURLResponse *response = nil;
    NSError *error = nil;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if(error)
        responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if(error)
        responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    return responseData;
}

+(NSData*)getActivityJSONDataForUserID:(NSString*)userID
                             withLimit:(int)limit
                             andOffset:(int)offset
{
    NSMutableString *url = [[NSMutableString alloc] init];
    [url appendString:CSDefaultURL];
    [url appendString:CSAPIGetActivity];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:userID forKey:@"user_id"];
    [params setObject:[NSString stringWithFormat:@"%i", limit] forKey:@"limit"];
    [params setObject:[NSString stringWithFormat:@"%i", offset] forKey:@"offset"];
    return [Connection requestToUrl:url withParams:params andType:CSRequestPOST];
}

+(NSData*)getCommentsJSONDataForTargetID:(NSString*)targetID
                               withLimit:(int)limit
                               andOffset:(int)offset
{
    NSMutableString *url = [[NSMutableString alloc] init];
    [url appendString:CSDefaultURL];
    [url appendString:CSAPIGetComments];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:targetID forKey:@"target_id"];
    [params setObject:[NSString stringWithFormat:@"%i", limit] forKey:@"limit"];
    [params setObject:[NSString stringWithFormat:@"%i", offset] forKey:@"offset"];
    return [Connection requestToUrl:url withParams:params andType:CSRequestPOST];
}

@end
