//
//  RootViewController.m
//  SpectttatorTest-iOS
//
//  Created by David Keegan on 6/29/11.
//  Copyright 2011 David Keegan.
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
        // There is a pretty long delay between when the data is recieved and the table shows the new data,
        // if you know how to fix this please fork the code and share the love :)
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 68.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return[self.shots count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ShotCell";
    
    ShotCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
        cell = [topLevelObjects objectAtIndex:0];
    }
    
    SPShot *aShot = [self.shots objectAtIndex:indexPath.row];
    
    NSNumber *identifier = [NSNumber numberWithLong:aShot.identifier];
    [cell loadShot:aShot withImage:[self.imageCache objectForKey:identifier]];
    
    // A little image cache so we only retrieve the image once,
    // and we update the row the first time it's loaded.
    if(![self.imageRetrievedCache member:identifier]){
        [self.imageRetrievedCache addObject:identifier];
        [aShot imageTeaserWithBlock:^(UIImage *image){
            [self.imageCache setObject:image forKey:identifier];
            cell.shot.image = image;
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
