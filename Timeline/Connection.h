//
//  ConnectionHelper.h
//  Timeline
//
//  Created by mihael on 16.01.13.
//  Copyright (c) 2013 Mihael Isaev. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CSDefaultURL @"http://api.mihaelisaev.com/cashsquare/api/"
#define CSAPIGetComments @"comments/get_comments.php"
#define CSAPIGetActivity @"users/get_activity.php"

#define CSRequestGET @"GET"
#define CSRequestPOST @"POST"

@interface Connection : NSObject

+(NSData*)getActivityJSONDataForUserID:(NSString*)userID
                             withLimit:(int)limit
                             andOffset:(int)offset;
+(NSData*)getCommentsJSONDataForTargetID:(NSString*)targetID
                               withLimit:(int)limit
                               andOffset:(int)offset;

@end
