//
//  ActivityComments.m
//  Timeline
//
//  Created by mihael on 16.01.13.
//  Copyright (c) 2013 Mihael Isaev. All rights reserved.
//

#import "ActivityComments.h"

@implementation ActivityComments

+(UIView*)makeCommentsViewForView:(UIView*)originalView
                         andArray:(NSArray*)comments
{
    CGRect originalFrame = originalView.frame;
    float y = 0;
    for(NSDictionary* dict in comments)
    {
        NSString *text = [NSString stringWithFormat:@"%@ %@", [dict objectForKey:@"username"], [dict objectForKey:@"text"]];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
        UIFont *fontBold = [UIFont fontWithName:@"HelveticaNeue-Bold" size:11.0f];
        UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:11.0f];
        [attributedString addAttribute:NSFontAttributeName value:fontBold range:NSMakeRange(0, [[dict objectForKey:@"username"] length])];
        [attributedString addAttribute:NSFontAttributeName value:font range:NSMakeRange([[dict objectForKey:@"username"] length], [attributedString length]-[[dict objectForKey:@"username"] length])];
        [attributedString addAttribute:NSForegroundColorAttributeName
                                 value:[UIColor colorWithRed:0.266 green:0.266 blue:0.266 alpha:1.000]
                                 range:NSMakeRange(0, [attributedString length])];
        CGSize textSize = [text
                           sizeWithFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:11.0f]
                           constrainedToSize:CGSizeMake(290.0f, 2000.0f)
                           lineBreakMode:NSLineBreakByWordWrapping];
        UIView *subView = [[UIView alloc] init];
        UIImageView *iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(2.0f, 5.0f, 11.0f, 9.0f)];
        iconImage.image = [UIImage imageNamed:@"smallComment.png"];
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.numberOfLines = 0;
        textLabel.attributedText = attributedString;
        [subView setFrame:CGRectMake(0, y, originalFrame.size.width, textSize.height+4.0f)];
        [subView addSubview:textLabel];
        [subView addSubview:iconImage];
        [textLabel setFrame:CGRectMake(15.0f, 2.0f, 280.0f, textSize.height)];
        [originalView addSubview:subView];
        y += textSize.height+4.0f;
    }
    originalFrame.size.height = y;
    [originalView setFrame: originalFrame];
    return originalView;
}

+(float)getCommentsViewHeightWithArray:(NSArray*)comments
{
    float height = 0;
    for(NSDictionary* dict in comments)
    {
        NSString *text = [NSString stringWithFormat:@"%@ %@", [dict objectForKey:@"username"], [dict objectForKey:@"text"]];
        CGSize textSize = [text
                           sizeWithFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:11.0f]
                           constrainedToSize:CGSizeMake(290.0f, 2000.0f)
                           lineBreakMode:NSLineBreakByWordWrapping];
        height += textSize.height+4.0f;
    }
    return height;
}

@end
