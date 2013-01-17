//
//  ImagesCache.m
//  Special for Timeline
//
//  Created by mihael on 16.01.13 a 5:53am.
//  Copyright (c) 2013 Mihael Isaev. All rights reserved.
//

#import "ImagesCache.h"

@implementation ImagesCache

-(id)init
{
    imagesReal = [[NSCache alloc] init];
    imagesActivityProfilePhoto = [[NSCache alloc] init];
    imagesActivityProfilePhotoRetina = [[NSCache alloc] init];
    imagesActivityCover = [[NSCache alloc] init];
    imagesActivityCoverRetina = [[NSCache alloc] init];
    
    imagesReal.countLimit = CSImageCacheLimit;
    imagesActivityProfilePhoto.countLimit = CSImageCacheLimit;
    imagesActivityProfilePhotoRetina.countLimit = CSImageCacheLimit;
    imagesActivityCover.countLimit = CSImageCacheLimit;
    imagesActivityCoverRetina.countLimit = CSImageCacheLimit;
    
    return self;
}

-(NSCache*)getCacheForType:(NSString*)type
{
    if([type isEqualToString:CSImageTypeActivityCover])
        return ([self isRetina]) ? imagesActivityCoverRetina : imagesActivityCover;
    else
        return ([self isRetina]) ? imagesActivityProfilePhotoRetina : imagesActivityProfilePhoto;
}

-(UIImage*)imageInUIImageView:(UIImageView*)imageView
                 forTableView:(UITableView*)tv
                 atIndexPath:(NSIndexPath*)ip
                     withURL:(NSString*)url
                     andType:(NSString*)type
{
    NSArray *parts = [url componentsSeparatedByString:@"/"];
    parts = [[parts objectAtIndex:[parts count]-1] componentsSeparatedByString:@"."];
    NSString *imageName = [parts objectAtIndex:0];
    NSString *imageExtension = [parts objectAtIndex:1];
    NSCache *imagesCache = [self getCacheForType:type];
    UIImage *image = [imagesCache objectForKey:imageName];
    if (image)
        return image;
    else
    {
        UITableViewCell *cell = [tv cellForRowAtIndexPath:ip];
        if (cell)
        {
            imageView.image = [UIImage imageNamed:@"blank_image.png"];
        }
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
                UIImage *image = [imagesReal objectForKey:imageName];
            CGSize imageSize = ([self isRetina]) ? CGSizeMake(imageView.frame.size.width*2, imageView.frame.size.height*2) : imageView.frame.size;
                if(!image)
                    image = [self getImageWithName:[self makeImageNameWithName:imageName
                                                                       andType:CSImageTypeReal]
                                      andExtension:imageExtension];
                if(!image)
                    @try {
                        image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
                        [self saveImage:image
                         toFileWithName:[self makeImageNameWithName:imageName andType:CSImageTypeReal]
                           andExtension:imageExtension];
                    }
                @catch (NSException *exception) {
                    NSLog(@"Error download image: %@", imageName);
                }
                if(image)
                {
                    UIImage *scaledImage = [self imageWithImage:image scaledToSize:imageSize];
                    [imagesReal setObject:image forKey:imageName];
                    if(imagesCache) [imagesCache setObject:scaledImage forKey:imageName];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        @try{
                            UITableViewCell *cell = [tv cellForRowAtIndexPath:ip];
                            if (cell)
                            {
                                imageView.image = scaledImage;
                            }
                        }
                        @catch (NSException *exception) {
                            NSLog(@"scale image exception: %@", exception);
                        }
                    });
                }
        });
    }
    return [UIImage imageNamed:@"blank_image.png"];
}

-(void)saveImage:(UIImage*)image
  toFileWithName:(NSString*)name
    andExtension:(NSString*)extension
{
    NSString *directory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileWithPathAndExtension = [directory stringByAppendingFormat:@"%@.%@", name, extension];
    if([extension isEqualToString:@"png"])
        [UIImagePNGRepresentation(image) writeToFile:fileWithPathAndExtension atomically:YES];
    else
        [UIImageJPEGRepresentation(image, 1.0) writeToFile:fileWithPathAndExtension atomically:YES];
}

- (UIImage*)getImageWithName:(NSString*)name
                andExtension:(NSString*)extension
{
    NSString *directory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileWithPathAndExtension = [directory stringByAppendingFormat:@"%@.%@", name, extension];
    return [UIImage imageWithContentsOfFile:fileWithPathAndExtension];
}

-(NSString*)makeImageNameWithName:(NSString*)name
                          andType:(NSString*)type
{
    return [NSString stringWithFormat:@"%@_%@", type, name];
}

-(UIImage*)imageWithImage:(UIImage*)image
              scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext( newSize );
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

-(BOOL)isRetina
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        CGFloat scale = [[UIScreen mainScreen] scale];
        if (scale > 1.0)
            return YES; //iPad retina screen
        else
            return NO; //iPad screen
    }
    else
    {
        if ([UIScreen instancesRespondToSelector:@selector(scale)])
        {
            CGFloat scale = [[UIScreen mainScreen] scale];
            if (scale > 1.0)
                if([[ UIScreen mainScreen ] bounds ].size.height == 568)
                    return YES; //iphone 5
                else
                    return YES; //iphone retina screen
            else
                return NO; //iphone screen
        }
        else
            return NO; //other not retina screen
    }
}

@end
