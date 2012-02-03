//
//  SPShot.m
//  Spectttator
//
//  Created by David Keegan on 6/26/11.
//  Copyright 2011 David Keegan.
//

#import "SPShot.h"
#import "SPComment.h"

@implementation SPShot

@synthesize title = _title;
@synthesize url = _url;
@synthesize shortUrl = _shortUrl;
@synthesize imageUrl = _imageUrl;
@synthesize imageTeaserUrl = _imageTeaserUrl;
@synthesize width = _width;
@synthesize height = _height;
@synthesize viewsCount = _viewsCount;
@synthesize likesCount = _likesCount;
@synthesize commentsCount = _commentsCount;
@synthesize reboundsCount = _reboundsCount;
@synthesize reboundSourceId = _reboundSourceId;
@synthesize player = _player;

- (void)imageRunOnMainThread:(BOOL)runOnMainThread 
                   withBlock:(void (^)(SPImage *image))block{
    [SPMethods requestImageWithURL:self.imageUrl
                   runOnMainThread:runOnMainThread 
                   withBlock:block];
}
    
- (void)imageTeaserRunOnMainThread:(BOOL)runOnMainThread 
                         withBlock:(void (^)(SPImage *image))block{
    [SPMethods requestImageWithURL:self.imageTeaserUrl
                   runOnMainThread:runOnMainThread 
                         withBlock:block];
}

- (void)reboundsWithPagination:(NSDictionary *)pagination
               runOnMainThread:(BOOL)runOnMainThread 
                     withBlock:(void (^)(NSArray *shots, SPPagination *pagination))block{
    NSString *urlString = [NSString stringWithFormat:
                           @"http://api.dribbble.com/shots/%lu/rebounds", 
                           self.identifier, [SPMethods pagination:pagination]];
    [SPMethods requestShotsWithURL:[NSURL URLWithString:urlString] 
                   runOnMainThread:runOnMainThread 
                         withBlock:block];
}

- (void)commentsWithPagination:(NSDictionary *)pagination
               runOnMainThread:(BOOL)runOnMainThread 
                     withBlock:(void (^)(NSArray *comments, SPPagination *pagination))block{
    NSString *urlString = [NSString stringWithFormat:
                           @"http://api.dribbble.com/shots/%lu/comments", 
                           self.identifier, [SPMethods pagination:pagination]];
    [SPMethods requestCommentsWithURL:[NSURL URLWithString:urlString] 
                   runOnMainThread:runOnMainThread 
                         withBlock:block];
}

- (id)initWithDictionary:(NSDictionary *)dictionary{
    if((self = [super initWithDictionary:dictionary])){
        _title = [[dictionary stringSafelyFromKey:@"title"] retain];
        _url = [[dictionary URLSafelyFromKey:@"url"] retain];
        _shortUrl = [[dictionary URLSafelyFromKey:@"short_url"] retain];
        _imageUrl = [[dictionary URLSafelyFromKey:@"image_url"] retain];
        _imageTeaserUrl = [[dictionary URLSafelyFromKey:@"image_teaser_url"] retain];
        _width = [dictionary uintSafelyFromKey:@"width"];
        _height = [dictionary uintSafelyFromKey:@"height"];
        _viewsCount = [dictionary uintSafelyFromKey:@"views_count"];
        _likesCount = [dictionary uintSafelyFromKey:@"likes_count"];
        _commentsCount = [dictionary uintSafelyFromKey:@"comments_count"];
        _reboundsCount = [dictionary uintSafelyFromKey:@"rebounds_count"];
        _reboundSourceId = [dictionary uintSafelyFromKey:@"rebound_source_id"];
        
        NSDictionary *player = [dictionary objectSafelyFromKey:@"player"];
        if(player != nil){
            _player = [[SPPlayer alloc] initWithDictionary:player];
        }else{
            _player = nil;
        }
    }
    
    return self;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"<%@ %lu Title='%@' Player=%@ URL=%@>", 
            [self class], self.identifier, self.title, self.player.username, self.url];
}

- (void)dealloc{
    [_title release];
    [_url release];
    [_shortUrl release];
    [_imageUrl release];
    [_imageTeaserUrl release];
    [_player release];
    [super dealloc];
}

@end
