//
//  RootViewController.h
//  SpectttatorTest-iOS
//
//  Created by David Keegan on 6/29/11.
//  Copyright 2011 David Keegan.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UITableViewController{
    NSArray *_shots;
    NSMutableSet *_imageRetrievedCache;
    NSMutableDictionary *_imageCache;
}

@property (retain, nonatomic) NSArray *shots;
@property (retain, nonatomic) NSMutableSet *imageRetrievedCache;
@property (retain, nonatomic) NSMutableDictionary *imageCache;

@end
