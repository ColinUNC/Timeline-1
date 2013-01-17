//
//  ImagesCache.h
//  Timeline
//
//  Created by mihael on 16.01.13.
//  Copyright (c) 2013 Mihael Isaev. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CSImageTypeReal @"CSImageTypeReal"
#define CSImageTypeActivityProfilePhoto @"CSImageTypeActivityProfilePhoto"
#define CSImageTypeActivityCover @"CSImageTypeActivityCover"

#define CSImageCacheLimit 50

@interface ImagesCache : NSObject
{
    NSCache *imagesReal;
    NSCache *imagesActivityProfilePhoto;
    NSCache *imagesActivityProfilePhotoRetina;
    NSCache *imagesActivityCover;
    NSCache *imagesActivityCoverRetina;
}

-(id)init;
-(UIImage*)imageInUIImageView:(UIImageView*)imageView
                 forTableView:(UITableView*)tv
                  atIndexPath:(NSIndexPath*)ip
                      withURL:(NSString*)url
                      andType:(NSString*)type;

@end
