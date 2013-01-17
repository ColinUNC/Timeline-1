//
//  ActivityComments.h
//  Timeline
//
//  Created by mihael on 16.01.13.
//  Copyright (c) 2013 Mihael Isaev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityComments : NSObject

+(UIView*)makeCommentsViewForView:(UIView*)originalView
                         andArray:(NSArray*)comments;
+(float)getCommentsViewHeightWithArray:(NSArray*)comments;

@end
