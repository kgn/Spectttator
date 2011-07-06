//
//  ShotCell.h
//  SpectttatorTest-iOS
//
//  Created by David Keegan on 6/30/11.
//  Copyright 2011 David Keegan.
//

#import <UIKit/UIKit.h>
#import "Spectttator.h"

@interface ShotCell : UITableViewCell {
    UILabel *_title;
    UILabel *_player;
    UILabel *_info;
    UIImageView *_shot;
}

@property (nonatomic, retain) IBOutlet UILabel *title;
@property (nonatomic, retain) IBOutlet UILabel *player;
@property (nonatomic, retain) IBOutlet UILabel *info;
@property (nonatomic, retain) IBOutlet UIImageView *shot;

- (void)loadShot:(SPShot *)aShot withImage:(UIImage *)image;

@end
