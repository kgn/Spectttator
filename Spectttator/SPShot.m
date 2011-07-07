//
//  SPShot.m
//  Spectttator
//
//  Created by David Keegan on 6/26/11.
//  Copyright 2011 David Keegan.
//

#import "SPShot.h"
#import "SPRequest.h"
#import "SPComment.h"

@implementation SPShot

@synthesize identifier = _identifier;
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
@synthesize createdAt = _createdAt;
@synthesize player = _player;

#if TARGET_OS_IPHONE
- (void)imageRunOnMainThread:(BOOL)runOnMainThread 
                   withBlock:(void (^)(UIImage *))block{
#else
- (void)imageRunOnMainThread:(BOOL)runOnMainThread 
                   withBlock:(void (^)(NSImage *))block{
#endif
    [SPRequest requestImageWithURL:self.imageUrl
                   runOnMainThread:runOnMainThread 
                   withBlock:block];
}
    
#if TARGET_OS_IPHONE
- (void)imageTeaserRunOnMainThread:(BOOL)runOnMainThread 
                         withBlock:(void (^)(UIImage *))block{
#else
- (void)imageTeaserRunOnMainThread:(BOOL)runOnMainThread 
                         withBlock:(void (^)(NSImage *))block{
#endif
    [SPRequest requestImageWithURL:self.imageTeaserUrl
                   runOnMainThread:runOnMainThread 
                         withBlock:block];
}

- (void)reboundsRunOnMainThread:(BOOL)runOnMainThread 
                      withBlock:(void (^)(NSArray *, SPPagination *))block{
    [self reboundsRunOnMainThread:runOnMainThread 
                        withBlock:block 
                    andPagination:nil];
}

- (void)reboundsRunOnMainThread:(BOOL)runOnMainThread 
                      withBlock:(void (^)(NSArray *, SPPagination *))block 
                  andPagination:(NSDictionary *)pagination{
    NSString *urlString = [NSString stringWithFormat:
                           @"http://api.dribbble.com/shots/%lu/rebounds", 
                           self.identifier, [SPRequest pagination:pagination]];
    [SPRequest requestShotsWithURL:[NSURL URLWithString:urlString] 
                   runOnMainThread:runOnMainThread 
                         withBlock:block];
}

- (void)commentsRunOnMainThread:(BOOL)runOnMainThread 
                      withBlock:(void (^)(NSArray *, SPPagination *))block{
    [self commentsRunOnMainThread:runOnMainThread 
                        withBlock:block 
                    andPagination:nil];
}

- (void)commentsRunOnMainThread:(BOOL)runOnMainThread 
                         withBlock:(void (^)(NSArray *, SPPagination *))block 
                         andPagination:(NSDictionary *)pagination{
    NSString *urlString = [NSString stringWithFormat:
                           @"http://api.dribbble.com/shots/%lu/comments", 
                           self.identifier, [SPRequest pagination:pagination]];
    [SPRequest requestCommentsWithURL:[NSURL URLWithString:urlString] 
                   runOnMainThread:runOnMainThread 
                         withBlock:block];
}

- (id)initWithDictionary:(NSDictionary *)dictionary{
    if((self = [super init])){
        _identifier = [[dictionary objectForKey:@"id"] intValue];
        _title = [[NSString alloc] initWithString:[dictionary objectForKey:@"title"]];
        _url = [[NSURL alloc] initWithString:[dictionary objectForKey:@"url"]];
        _shortUrl = [[NSURL alloc] initWithString:[dictionary objectForKey:@"short_url"]];
        _imageUrl = [[NSURL alloc] initWithString:[dictionary objectForKey:@"image_url"]];
        _imageTeaserUrl = [[NSURL alloc] initWithString:[dictionary objectForKey:@"image_teaser_url"]];
        _width = [[dictionary objectForKey:@"width"] intValue];
        _height = [[dictionary objectForKey:@"height"] intValue];
        _viewsCount = [[dictionary objectForKey:@"views_count"] intValue];
        _likesCount = [[dictionary objectForKey:@"likes_count"] intValue];
        _commentsCount = [[dictionary objectForKey:@"comments_count"] intValue];
        _reboundsCount = [[dictionary objectForKey:@"rebounds_count"] intValue];
        
        if([dictionary objectForKey:@"rebound_source_id"] != [NSNull null]){
            _reboundSourceId = [[dictionary objectForKey:@"rebound_source_id"] intValue];
        }else{
            _reboundSourceId = NSNotFound;
        }
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss a"];
        _createdAt = [[formatter dateFromString:[dictionary objectForKey:@"created_at"]] retain];
        [formatter release];
        
        _player = [[SPPlayer alloc] initWithDictionary:[dictionary objectForKey:@"player"]];
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
    [_createdAt release];
    [super dealloc];
}

@end
