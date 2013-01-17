//
//  ActivityFriendshipCell.m
//  Timeline
//
//  Created by mihael on 16.01.13.
//  Copyright (c) 2013 Mihael Isaev. All rights reserved.
//

#import "ActivityFriendshipCell.h"

@implementation ActivityFriendshipCell

-(void)updateCellAtIndexPath:(NSIndexPath*)ip
                 inTableView:(UITableView*)tv
              withDictionary:(NSDictionary*)dict
              andImagesCache:(ImagesCache*)imagesCache
{
    self.descriptionLabel.text = [dict objectForKey:CSActivityKeyDescription];
    self.fromUserImage.image = [imagesCache imageInUIImageView:self.fromUserImage
                                                  forTableView:tv
                                                   atIndexPath:ip
                                                       withURL:[AppDelegate retrieveString:CSCurrentUserPhoto]
                                                       andType:CSImageTypeActivityProfilePhoto];
    
    NSDictionary *params = [dict objectForKey:CSActivityKeyParams];
    
    self.toUserImage.image = [imagesCache imageInUIImageView:self.toUserImage
                                                forTableView:tv
                                                 atIndexPath:ip
                                                     withURL:[params objectForKey:CSActivityKeyParamsFriendPhoto]
                                                     andType:CSImageTypeActivityProfilePhoto];
    self.containerView.layer.masksToBounds = YES;
    self.containerView.layer.opaque = NO;
    self.containerView.layer.cornerRadius = 10.0f;
}

-(float)heightForCellAtIndexPath:(NSIndexPath*)ip
                     inTableView:(UITableView*)tv
                  withDictionary:(NSDictionary*)dict
{
    return 53.0f;
}

@end
