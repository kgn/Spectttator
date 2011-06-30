//
//  ShotCell.m
//  SpectttatorTest-iOS
//
//  Created by David Keegan on 6/30/11.
//  Copyright 2011 InScopeApps {+}. All rights reserved.
//

#import "ShotCell.h"

@implementation ShotCell
@synthesize title;
@synthesize player;
@synthesize info;
@synthesize shot;
@synthesize cachedImage;

- (void)loadShot:(SPShot *)aShot withImage:(UIImage *)image{
    self.title.text = aShot.title;
    self.player.text = aShot.player.name;
    self.info.text = [NSString stringWithFormat:@"👀%lu  💓%lu  📢%lu", 
                       aShot.viewsCount, aShot.likesCount, aShot.commentsCount];
    self.shot.image = image;
}

- (void)dealloc {
    [title release];
    [player release];
    [info release];
    [shot release];
    [cachedImage release];
    [super dealloc];
}
@end
