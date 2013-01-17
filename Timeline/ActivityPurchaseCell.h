//
//  ActivityPurchaseCell.h
//  Timeline
//
//  Created by mihael on 16.01.13.
//  Copyright (c) 2013 Mihael Isaev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ActivityCells.h"
#import "ActivityComments.h"
#import "ImagesCache.h"
#import "CommonHelper.h"

@interface ActivityPurchaseCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

-(void)updateCellAtIndexPath:(NSIndexPath*)ip
                 inTableView:(UITableView*)tv
              withDictionary:(NSDictionary*)dict
              andImagesCache:(ImagesCache*)imagesCache;
-(float)heightForCellAtIndexPath:(NSIndexPath*)ip
                     inTableView:(UITableView*)tv
                  withDictionary:(NSDictionary*)dict;

@property (weak, nonatomic) IBOutlet UIImageView *profilePhoto;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *created;
@property (weak, nonatomic) IBOutlet UIView *likesView;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIView *commentView;

@end
