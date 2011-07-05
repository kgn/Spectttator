//
//  ShotCell.h
//  SpectttatorTest-iOS
//
//  Created by David Keegan on 6/30/11.
//  Copyright 2011 InScopeApps {+}. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Spectttator.h"

@interface ShotCell : UITableViewCell {
    UILabel *title;
    UILabel *player;
    UILabel *info;
    UIImageView *shot;
    UIImage *cachedImage;
}

@property (nonatomic, retain) IBOutlet UILabel *title;
@property (nonatomic, retain) IBOutlet UILabel *player;
@property (nonatomic, retain) IBOutlet UILabel *info;
@property (nonatomic, retain) IBOutlet UIImageView *shot;
@property (nonatomic, retain) UIImage *cachedImage;

- (void)loadShot:(SPShot *)aShot withImage:(UIImage *)image;

@end
