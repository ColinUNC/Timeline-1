//
//  ActivityCells.h
//  Timeline
//
//  Created by mihael on 16.01.13.
//  Copyright (c) 2013 Mihael Isaev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActivityPurchaseCell.h"
#import "ActivityExchangeCell.h"
#import "ActivityFriendshipCell.h"
#import "ActivityUpgradeCell.h"
#import "ActivityAddCoverCell.h"
#import "ImagesCache.h"

#define CSActivityKeyID @"id"
#define CSActivityKeyCreated @"created"
#define CSActivityKeyComments @"comments"
#define CSActivityKeyCommentsCount @"comments_count"
#define CSActivityKeyLikesCount @"likes_count"
#define CSActivityKeyDescription @"description"
#define CSActivityKeyType @"type"
#define CSActivityKeyParams @"params"
#define CSActivityKeyLikes @"likes"

#define CSActivityKeyTypePurchase @"purchase"
#define CSActivityKeyTypeExchange @"exchange"
#define CSActivityKeyTypeFriendship @"friendship"
#define CSActivityKeyTypeUpgrade @"upgrade"
#define CSActivityKeyTypeAddCover @"addCover"

#define CSActivityKeyParamsCover @"cover"
#define CSActivityKeyParamsFriendPhoto @"friend_photo"

@interface ActivityCells : NSObject
{
    ImagesCache *imagesCache;
}

-(id)init;
-(UITableViewCell*)getCellForTableView:(UITableView*)tv
                           atIndexPath:(NSIndexPath*)ip
                        withDictionary:(NSDictionary*)dict;
-(float)getHeightOfCellForTableView:(UITableView*)tv
                        atIndexPath:(NSIndexPath*)ip
                     withDictionary:(NSDictionary*)dict;

@end
