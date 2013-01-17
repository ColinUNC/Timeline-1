//
//  ViewController.m
//  Timeline
//
//  Created by mihael on 15.01.13.
//  Copyright (c) 2013 Mihael Isaev. All rights reserved.
//

#import "TimeLineViewController.h"

#define UserID @""
#define Limit 10

@interface TimeLineViewController ()

@end

@implementation TimeLineViewController

NSMutableArray *items;
ActivityCells *activityCells;
BOOL itemsDownloadInProgress = NO;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timelineBackground.png"]];
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [self setRefreshControl:refreshControl];
    [self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
	items = [[NSMutableArray alloc] initWithObjects: nil];
    activityCells = [[ActivityCells alloc] init];
    [self startDownloadAndAppend:NO];
}

#pragma mark - TableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (items.count>0) ? items.count+1 : items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==items.count-4)
        [self startDownloadAndAppend:YES];
    NSDictionary *dict = (indexPath.row==items.count) ? nil : [items objectAtIndex:indexPath.row];
    return [activityCells getCellForTableView:tableView
                                  atIndexPath:indexPath
                               withDictionary:dict];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = (indexPath.row==items.count) ? nil : [items objectAtIndex:indexPath.row];
    return [activityCells getHeightOfCellForTableView:tableView
                                          atIndexPath:indexPath
                                       withDictionary:dict];
}

#pragma mark - Download
-(void)startDownloadAndAppend:(BOOL)append
{
    if(!itemsDownloadInProgress)
    {
        itemsDownloadInProgress = YES;
        if(!append)
            [self.refreshControl beginRefreshing];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            while(itemsDownloadInProgress)
            {
                @try {
                    NSArray *result = [Data getActivityArrayForUserID:UserID withLimit:Limit andOffset:items.count];
                    if(!append)
                        items = [result mutableCopy];
                    else
                    {
                        [self removeLoadingCell];
                        items = [[items arrayByAddingObjectsFromArray:result] mutableCopy];
                    }
                }
                @catch (NSException *exception) {
                    NSLog(@"download activity error: %@", exception);
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                    if(!append)
                        [self.refreshControl endRefreshing];
                });
                itemsDownloadInProgress = NO;
            }
        });
    }
}

-(void)removeLoadingCell
{
    [items removeLastObject];
}

#pragma mark - RefreshControl Delegate
-(void)refresh
{
    [self startDownloadAndAppend:NO];
}

@end
