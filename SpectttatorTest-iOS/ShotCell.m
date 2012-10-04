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
                      (unsigned long)aShot.viewsCount, (unsigned long)aShot.likesCount,
                      (unsigned long)aShot.commentsCount];
    self.shot.image = image;
}

- (void)dealloc {
    [_title release];
    [_player release];
    [_info release];
    [_shot release];
    [super dealloc];
}
@end
