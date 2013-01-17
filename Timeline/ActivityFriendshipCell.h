//
//  ActivityFriendshipCell.h
//  Timeline
//
//  Created by mihael on 16.01.13.
//  Copyright (c) 2013 Mihael Isaev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ActivityCells.h"
#import "ImagesCache.h"
#import "AppDelegate.h"

@interface ActivityFriendshipCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIImageView *fromUserImage;
@property (weak, nonatomic) IBOutlet UIImageView *toUserImage;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

-(void)updateCellAtIndexPath:(NSIndexPath*)ip
                 inTableView:(UITableView*)tv
              withDictionary:(NSDictionary*)dict
              andImagesCache:(ImagesCache*)imagesCache;
-(float)heightForCellAtIndexPath:(NSIndexPath*)ip
                     inTableView:(UITableView*)tv
                  withDictionary:(NSDictionary*)dict;

@end
