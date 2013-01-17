//
//  AppDelegate.h
//  Timeline
//
//  Created by mihael on 15.01.13.
//  Copyright (c) 2013 Mihael Isaev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimeLineViewController.h"

#define CSCurrentUserFirstName @"CSCurrentUserFirstName"
#define CSCurrentUserLastName @"CSCurrentUserLastName"
#define CSCurrentUserPhoto @"CSCurrentUserPhoto"

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+(NSString*)retrieveString:(NSString*)key;
+(void)saveString:(NSString*)value forKey:(NSString*)key;

@end
