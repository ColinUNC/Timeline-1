//
//  CommonHelper.m
//  Timeline
//
//  Created by mihael on 16.01.13.
//  Copyright (c) 2013 Mihael Isaev. All rights reserved.
//

#import "CommonHelper.h"

@implementation CommonHelper

+(NSString*)dateFromTimestamp:(NSString*)timestamp
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:([timestamp intValue])];
    NSDateFormatter *gmtFormatter=[[NSDateFormatter alloc] init];
    [gmtFormatter setDateFormat:@"dd:MM:YYYY HH:mm:ss"];
    return [gmtFormatter stringFromDate:date];
}

@end
