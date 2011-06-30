//
//  RootViewController.m
//  SpectttatorTest-iOS
//
//  Created by David Keegan on 6/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "Spectttator.h"

@implementation RootViewController

@synthesize shots = _shots;
@synthesize imageRetrievedCache = _imageRetrievedCache;
@synthesize imageCache = _imageCache;

- (void)refresh{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [[SPManager sharedManager] shotsForList:SPPopularList withBlock:^(NSArray *theShots, SPPagination *thsPagination) {
        self.shots = theShots;
        self.imageRetrievedCache = nil;
        self.imageRetrievedCache = [[NSMutableSet alloc] initWithCapacity:[theShots count]];
        self.imageCache = [[NSMutableDictionary alloc] initWithCapacity:[theShots count]];
        [self.tableView reloadData];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    } andPagination:[SPPagination perPage:30]];    
}

- (void)viewDidLoad{
    self.title = @"Popular";
    UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh 
                                                                                   target:self 
                                                                                   action:@selector(refresh)];          
    self.navigationItem.rightBarButtonItem = refreshButton;
    [refreshButton release];    
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated{
    [self refresh];
    [super viewDidAppear:animated];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return[self.shots count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }

    SPShot *aShot = [self.shots objectAtIndex:indexPath.row];
    cell.textLabel.text = aShot.title;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Views: %lu Likes: %lu Comments: %lu", 
                                 aShot.viewsCount, aShot.likesCount, aShot.commentsCount];
    
    // A little image cache so we only retrieve the image once,
    // and we update the row the first time it's loaded.
    // There are some redraw problems so this is probably not the best
    // code to copy directly, but it illustrates the point. If you have
    // a better solution please fork the code and share the love!
    NSNumber *identifier = [NSNumber numberWithLong:aShot.identifier];
    // this will be nil sometimes and we want it that way
    cell.imageView.image = [self.imageCache objectForKey:identifier];
    if(![self.imageRetrievedCache member:identifier]){
        [self.imageRetrievedCache addObject:identifier];
        [aShot imageTeaserWithBlock:^(UIImage *image){
            [self.imageCache setObject:image forKey:identifier];
            // We don't need to set the image here becuase when the 
            // row is reloaded cellForRowAtIndexPath will be called again
            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] 
                                  withRowAnimation:UITableViewRowAnimationNone];
        }];
    }
    
    // Configure the cell.
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // Open the shot in safari
    SPShot *aShot = [self.shots objectAtIndex:indexPath.row];
    [[UIApplication sharedApplication] openURL:aShot.url];
}

- (void)dealloc{
    [_shots release];
    [_imageRetrievedCache release];
    [_imageCache release];
    [super dealloc];
}

@end
