//
//  RootViewController.h
//  SpectttatorTest-iOS
//
//  Created by David Keegan on 6/29/11.
//  Copyright 2011 David Keegan.
//

#import <UIKit/UIKit.h>
#import "ShotCell.h"

@interface RootViewController : UITableViewController <UIActionSheetDelegate>

@property (strong, nonatomic) NSString *list;
@property (strong, nonatomic) NSArray *shots;
@property (strong, nonatomic) NSMutableSet *imageRetrievedCache;
@property (strong, nonatomic) NSMutableDictionary *imageCache;

@property (strong, nonatomic) UIBarButtonItem *listButton;
@property (strong, nonatomic) UIBarButtonItem *refreshButton;

@end
