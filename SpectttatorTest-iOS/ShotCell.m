//
//  ShotCell.m
//  SpectttatorTest-iOS
//
//  Created by David Keegan on 6/30/11.
//  Copyright 2011 David Keegan.
//

#import "ShotCell.h"

@implementation ShotCell

@synthesize title = _title;
@synthesize player = _player;
@synthesize info = _info;
@synthesize shot = _shot;

- (void)loadShot:(SPShot *)aShot withImage:(UIImage *)image{
    self.title.text = aShot.title;
    self.player.text = aShot.player.name;
    self.info.text = [NSString stringWithFormat:@"👀%lu  💓%lu  📢%lu", 
                       aShot.viewsCount, aShot.likesCount, aShot.commentsCount];
    self.shot.image = image;
}

@end
