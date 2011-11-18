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

@property (retain, nonatomic) NSString *list;
@property (retain, nonatomic) NSArray *shots;
@property (retain, nonatomic) NSMutableSet *imageRetrievedCache;
@property (retain, nonatomic) NSMutableDictionary *imageCache;

@property (retain, nonatomic) UIBarButtonItem *listButton;
@property (retain, nonatomic) UIBarButtonItem *refreshButton;

@end
