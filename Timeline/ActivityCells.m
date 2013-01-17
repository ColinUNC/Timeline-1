//
//  ActivityCells.m
//  Timeline
//
//  Created by mihael on 16.01.13.
//  Copyright (c) 2013 Mihael Isaev. All rights reserved.
//

#import "ActivityCells.h"

@implementation ActivityCells

-(id)init
{
    imagesCache = [[ImagesCache alloc] init];
    return self;
}

-(UITableViewCell*)getCellForTableView:(UITableView*)tv
                           atIndexPath:(NSIndexPath*)ip
                        withDictionary:(NSDictionary*)dict
{
    if(dict)
    {
        NSString *type = [dict objectForKey:CSActivityKeyType];
        if([type isEqualToString:CSActivityKeyTypePurchase])
            return [self purchaseCellForTableView:tv atIndexPath:ip withDictionary:dict];
        else if([type isEqualToString:CSActivityKeyTypeExchange])
            return [self exchangeCellForTableView:tv atIndexPath:ip withDictionary:dict];
        else if([type isEqualToString:CSActivityKeyTypeFriendship])
            return [self friendshipCellForTableView:tv atIndexPath:ip withDictionary:dict];
        else if([type isEqualToString:CSActivityKeyTypeUpgrade])
            return [self upgradeCellForTableView:tv atIndexPath:ip withDictionary:dict];
        else if([type isEqualToString:CSActivityKeyTypeAddCover])
            return [self addCoverCellForTableView:tv atIndexPath:ip withDictionary:dict];
        else
            return [self dummyCellForTableView:tv atIndexPath:ip];
    }
    else
        return [self loadingCellForTableView:tv atIndexPath:ip];
}

-(UITableViewCell*)dummyCellForTableView:(UITableView*)tv
                             atIndexPath:(NSIndexPath*)ip
{
    static NSString *CellIdentifier = @"DummyCell";
    UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    return cell;
}

-(UITableViewCell*)purchaseCellForTableView:(UITableView*)tv
                                atIndexPath:(NSIndexPath*)ip
                             withDictionary:(NSDictionary*)dict
{
    static NSString *CellIdentifier = @"PurchaseCell";
    static NSString *CellNib = @"ActivityPurchaseCell";
    ActivityPurchaseCell *cell = (ActivityPurchaseCell *)[tv dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
    	NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellNib owner:self options:nil];
    	cell = (ActivityPurchaseCell *)[nib objectAtIndex:0];
    }
    [cell updateCellAtIndexPath:ip
                    inTableView:tv
                 withDictionary:dict
                 andImagesCache:imagesCache];
    return cell;
}

-(UITableViewCell*)exchangeCellForTableView:(UITableView*)tv
                                atIndexPath:(NSIndexPath*)ip
                             withDictionary:(NSDictionary*)dict
{
    static NSString *CellIdentifier = @"ExchangeCell";
    static NSString *CellNib = @"ActivityExchangeCell";
    ActivityExchangeCell *cell = (ActivityExchangeCell *)[tv dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
    	NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellNib owner:self options:nil];
    	cell = (ActivityExchangeCell *)[nib objectAtIndex:0];
    }
    [cell updateCellAtIndexPath:ip
                    inTableView:tv
                 withDictionary:dict
                 andImagesCache:imagesCache];
    return cell;
}

-(UITableViewCell*)friendshipCellForTableView:(UITableView*)tv
                                  atIndexPath:(NSIndexPath*)ip
                               withDictionary:(NSDictionary*)dict
{
    static NSString *CellIdentifier = @"FriendshipCell";
    static NSString *CellNib = @"ActivityFriendshipCell";
    ActivityFriendshipCell *cell = (ActivityFriendshipCell *)[tv dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
    	NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellNib owner:self options:nil];
    	cell = (ActivityFriendshipCell *)[nib objectAtIndex:0];
    }
    [cell updateCellAtIndexPath:ip
                    inTableView:tv
                 withDictionary:dict
                 andImagesCache:imagesCache];
    return cell;
}

-(UITableViewCell*)upgradeCellForTableView:(UITableView*)tv
                               atIndexPath:(NSIndexPath*)ip
                            withDictionary:(NSDictionary*)dict
{
    static NSString *CellIdentifier = @"UpgradeCell";
    static NSString *CellNib = @"ActivityUpgradeCell";
    ActivityUpgradeCell *cell = (ActivityUpgradeCell *)[tv dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
    	NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellNib owner:self options:nil];
    	cell = (ActivityUpgradeCell *)[nib objectAtIndex:0];
    }
    [cell updateCellAtIndexPath:ip
                    inTableView:tv
                 withDictionary:dict
                 andImagesCache:imagesCache];
    return cell;
}

-(UITableViewCell*)addCoverCellForTableView:(UITableView*)tv
                                atIndexPath:(NSIndexPath*)ip
                             withDictionary:(NSDictionary*)dict
{
    static NSString *CellIdentifier = @"AddCoverCell";
    static NSString *CellNib = @"ActivityAddCoverCell";
    ActivityAddCoverCell *cell = (ActivityAddCoverCell *)[tv dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
    	NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellNib owner:self options:nil];
    	cell = (ActivityAddCoverCell *)[nib objectAtIndex:0];
    }
    [cell updateCellAtIndexPath:ip
                    inTableView:tv
                 withDictionary:dict
                 andImagesCache:imagesCache];
    return cell;
}

-(UITableViewCell*)loadingCellForTableView:(UITableView*)tv
                               atIndexPath:(NSIndexPath*)ip
{
    static NSString *CellIdentifier = @"LoadingCell";
    static NSString *CellNib = @"ActivityLoadingCell";
    UITableViewCell *cell = (UITableViewCell *)[tv dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
    	NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellNib owner:self options:nil];
    	cell = (UITableViewCell *)[nib objectAtIndex:0];
    }
    return cell;
}

-(float)getHeightOfCellForTableView:(UITableView*)tv
                        atIndexPath:(NSIndexPath*)ip
                     withDictionary:(NSDictionary*)dict
{
    if(dict)
    {
        NSString *type = [dict objectForKey:CSActivityKeyType];
        if([type isEqualToString:CSActivityKeyTypePurchase])
            return [[[ActivityPurchaseCell alloc] init] heightForCellAtIndexPath:ip inTableView:tv withDictionary:dict];
        else if([type isEqualToString:CSActivityKeyTypeExchange])
            return [[[ActivityExchangeCell alloc] init] heightForCellAtIndexPath:ip inTableView:tv withDictionary:dict];
        else if([type isEqualToString:CSActivityKeyTypeFriendship])
            return [[[ActivityFriendshipCell alloc] init] heightForCellAtIndexPath:ip inTableView:tv withDictionary:dict];
        else if([type isEqualToString:CSActivityKeyTypeUpgrade])
            return [[[ActivityUpgradeCell alloc] init] heightForCellAtIndexPath:ip inTableView:tv withDictionary:dict];
        else if([type isEqualToString:CSActivityKeyTypeAddCover])
            return [[[ActivityAddCoverCell alloc] init] heightForCellAtIndexPath:ip inTableView:tv withDictionary:dict];
        else
            return .0f;
    }
    else
        return 44.0f;
}
/*
-(UITableViewCell*)cellBig:(UITableView*)tv indexPath:(NSIndexPath*)ip
{
#define NAME_LABEL_TAG 99
#define IMAGE_VIEW_TAG 98
    static NSString *CellIdentifier = @"ItemsViewCellBig";
    UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.contentView.backgroundColor = [UIColor clearColor];
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 0, 190, 28)];
        nameLabel.tag = NAME_LABEL_TAG;
        [cell addSubview:nameLabel];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 100, 100)];
        imageView.tag = IMAGE_VIEW_TAG;
        [cell addSubview:imageView];
    }
    @try {
        if(items.count>=ip.row-((subCategories)?sub.count:0)) {
            NSDictionary *dict = [[items objectAtIndex:ip.row-((subCategories)?sub.count:0)] valueForKey:@"values"];
            UILabel *nameLabel = (UILabel*)[cell viewWithTag:NAME_LABEL_TAG];
            [nameLabel setText:[NSString stringWithFormat:@"%@ %@", [dict objectForKey:@"articul"], [dict objectForKey:@"name"]]];
            [nameLabel setTextColor:[UIColor redColor]];
            UIImageView * imageView = (UIImageView*)[cell viewWithTag:IMAGE_VIEW_TAG];
            imageView.image = [self imageWithArticul:[self getCleanArticulFromImageUrl:[dict objectForKey:@"img"]] forCellType:ULItemsViewBig toIndexPath:ip];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"Error in cell: %i", ip.row);
    }
    return cell;
}*/

@end
