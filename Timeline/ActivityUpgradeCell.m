//
//  ActivityUpgradeCell.m
//  Timeline
//
//  Created by mihael on 16.01.13.
//  Copyright (c) 2013 Mihael Isaev. All rights reserved.
//

#import "ActivityUpgradeCell.h"

@implementation ActivityUpgradeCell

-(void)updateCellAtIndexPath:(NSIndexPath*)ip
                 inTableView:(UITableView*)tv
              withDictionary:(NSDictionary*)dict
              andImagesCache:(ImagesCache*)imagesCache
{
    self.containerView.layer.masksToBounds = YES;
    self.containerView.layer.opaque = NO;
    self.containerView.layer.cornerRadius = 10.0f;
    CGSize descriptionLabelSize = [[dict objectForKey:CSActivityKeyDescription]
                                   sizeWithFont:self.descriptionLabel.font
                                   constrainedToSize:CGSizeMake(self.descriptionLabel.bounds.size.width, 2000)
                                   lineBreakMode:NSLineBreakByWordWrapping];
    CGRect descriptionLabelFrame = self.descriptionLabel.frame;
    CGRect likeButtonFrame = self.likeButton.frame;
    CGRect commentButtonFrame = self.commentButton.frame;
    CGRect likesViewFrame = self.likesView.frame;
    CGRect commentViewFrame = self.commentView.frame;
    descriptionLabelFrame.size.height = descriptionLabelSize.height;
    likeButtonFrame.origin.y = self.descriptionLabel.frame.origin.y+descriptionLabelSize.height+5.0f;
    commentButtonFrame.origin.y = self.descriptionLabel.frame.origin.y+descriptionLabelSize.height+5.0f;
    likesViewFrame.origin.y = self.descriptionLabel.frame.origin.y+descriptionLabelSize.height+5.0f+self.likeButton.frame.size.height+5.0f;
    float commentsHeight = 0;
    if([[dict objectForKey:CSActivityKeyCommentsCount] intValue]>0)
        commentsHeight = [ActivityComments getCommentsViewHeightWithArray:[dict objectForKey:CSActivityKeyComments]];
    float likesHeight = 0;
    if([[dict objectForKey:CSActivityKeyLikesCount] intValue]>0)
        likesHeight = self.likesView.frame.size.height+5.0f;
    commentViewFrame.size.height = commentsHeight;
    commentViewFrame.origin.y = self.descriptionLabel.frame.origin.y+descriptionLabelSize.height+5.0f+self.likeButton.frame.size.height+5.0f+likesHeight;
    [self.descriptionLabel setFrame:descriptionLabelFrame];
    [self.likeButton setFrame:likeButtonFrame];
    [self.commentButton setFrame:commentButtonFrame];
    [self.likesView setFrame:likesViewFrame];
    [self.commentView setFrame:commentViewFrame];
    float containerHeight = self.descriptionLabel.frame.origin.y+descriptionLabelSize.height+5.0f+self.likeButton.frame.size.height+5.0f+likesHeight+commentsHeight+5.0f;
    [self.containerView setFrame:CGRectMake(10.0, 5.0, 300.0, containerHeight)];
    self.descriptionLabel.text = [dict objectForKey:CSActivityKeyDescription];
    self.name.text = [NSString stringWithFormat:@"%@ %@", [AppDelegate retrieveString:CSCurrentUserFirstName], [AppDelegate retrieveString:CSCurrentUserLastName]];
    self.created.text = [CommonHelper dateFromTimestamp:[dict objectForKey:CSActivityKeyCreated]];
    self.profilePhoto.image = [imagesCache imageInUIImageView:self.profilePhoto
                                                 forTableView:tv
                                                  atIndexPath:ip
                                                      withURL:[AppDelegate retrieveString:CSCurrentUserPhoto]
                                                      andType:CSImageTypeActivityProfilePhoto];
    
    int likesCount = [[dict objectForKey:CSActivityKeyLikesCount] intValue];
    if(likesCount>0)
    {
        NSArray *likes = [dict objectForKey:CSActivityKeyLikes];
        int likePhotoX = 5.0f;
        for(int x=0;x<likes.count;x++)
        {
            UIImageView *likeImage = [[UIImageView alloc] initWithFrame:CGRectMake(likePhotoX, 2, 30, 30)];
            likeImage.image = [imagesCache imageInUIImageView:likeImage
                                                 forTableView:tv
                                                  atIndexPath:ip
                                                      withURL:[likes objectAtIndex:x]
                                                      andType:CSImageTypeActivityProfilePhoto];
            [self.likesView addSubview:likeImage];
            likePhotoX += 35.0f;
        }
    }
    if([[dict objectForKey:CSActivityKeyCommentsCount] intValue]>0)
        self.commentView = [ActivityComments makeCommentsViewForView:self.commentView andArray:[dict objectForKey:CSActivityKeyComments]];
    [self addSubviewsToButton:self.likeButton withNumber:[dict objectForKey:CSActivityKeyLikesCount] andImage:[UIImage imageNamed:@"whiteHeart.png"]];
    [self addSubviewsToButton:self.commentButton withNumber:[dict objectForKey:CSActivityKeyCommentsCount] andImage:[UIImage imageNamed:@"comment.png"]];
}

-(float)heightForCellAtIndexPath:(NSIndexPath*)ip
                     inTableView:(UITableView*)tv
                  withDictionary:(NSDictionary*)dict
{
    CGSize descriptionLabelSize = [[dict objectForKey:CSActivityKeyDescription]
                                   sizeWithFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:12.0f]
                                   constrainedToSize:CGSizeMake(320.0f, 2000.0f)
                                   lineBreakMode:NSLineBreakByWordWrapping];
    float result = 44.0f;
    result += descriptionLabelSize.height;
    result +=5.0f;
    result += 32.0; //like button height
    result +=5.0f;
    result += 34.0f; //likes view height
    if([[dict objectForKey:CSActivityKeyCommentsCount] intValue]>0)
        result += [ActivityComments getCommentsViewHeightWithArray:[dict objectForKey:CSActivityKeyComments]]+5.0f;
    result +=30.0f;
    return result;
}

-(void)addSubviewsToButton:(UIButton*)button withNumber:(NSString*)number andImage:(UIImage*)image
{
    UIImageView *likesImage = [[UIImageView alloc] initWithFrame:CGRectMake(55, 9, 16, 14)];
    likesImage.image = image;
    UILabel *likesLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 9, 40, 16)];
    likesLabel.text = [NSString stringWithFormat:@"%@", number];
    likesLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:18.0f];
    likesLabel.textColor = [UIColor whiteColor];
    likesLabel.backgroundColor = [UIColor clearColor];
    [button addSubview:likesLabel];
    [button addSubview:likesImage];
}

@end
