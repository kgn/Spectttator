//
//  ShotCell.h
//  SpectttatorTest-iOS
//
//  Created by David Keegan on 6/30/11.
//  Copyright 2011 David Keegan.
//

#import <UIKit/UIKit.h>
#import "Spectttator.h"

@interface ShotCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *player;
@property (strong, nonatomic) IBOutlet UILabel *info;
@property (strong, nonatomic) IBOutlet UIImageView *shot;

- (void)loadShot:(SPShot *)aShot withImage:(UIImage *)image;

@end
