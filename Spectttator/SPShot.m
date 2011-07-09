//
//  SPShot.m
//  Spectttator
//
//  Created by David Keegan on 6/26/11.
//  Copyright 2011 David Keegan.
//

#import "SPShot.h"
#import "SPMethods.h"
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

- (void)imageRunOnMainThread:(BOOL)runOnMainThread 
                   withBlock:(void (^)(
#if TARGET_OS_IPHONE                                       
                                       UIImage *
#else
                                       NSImage *
#endif
                                       ))block{
    [SPMethods requestImageWithURL:self.imageUrl
                   runOnMainThread:runOnMainThread 
                   withBlock:block];
}
    
- (void)imageTeaserRunOnMainThread:(BOOL)runOnMainThread 
                         withBlock:(void (^)(
#if TARGET_OS_IPHONE                                       
                                             UIImage *
#else
                                             NSImage *
#endif
                                             ))block{
    [SPMethods requestImageWithURL:self.imageTeaserUrl
                   runOnMainThread:runOnMainThread 
                         withBlock:block];
}

- (void)reboundsWithPagination:(NSDictionary *)pagination
               runOnMainThread:(BOOL)runOnMainThread 
                     withBlock:(void (^)(NSArray *, SPPagination *))block{
    NSString *urlString = [NSString stringWithFormat:
                           @"http://api.dribbble.com/shots/%lu/rebounds", 
                           self.identifier, [SPMethods pagination:pagination]];
    [SPMethods requestShotsWithURL:[NSURL URLWithString:urlString] 
                   runOnMainThread:runOnMainThread 
                         withBlock:block];
}

- (void)commentsWithPagination:(NSDictionary *)pagination
               runOnMainThread:(BOOL)runOnMainThread 
                     withBlock:(void (^)(NSArray *, SPPagination *))block{
    NSString *urlString = [NSString stringWithFormat:
                           @"http://api.dribbble.com/shots/%lu/comments", 
                           self.identifier, [SPMethods pagination:pagination]];
    [SPMethods requestCommentsWithURL:[NSURL URLWithString:urlString] 
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
        _createdAt = [formatter dateFromString:[dictionary objectForKey:@"created_at"]];
        
        _player = [[SPPlayer alloc] initWithDictionary:[dictionary objectForKey:@"player"]];
    }
    
    return self;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"<%@ %lu Title='%@' Player=%@ URL=%@>", 
            [self class], self.identifier, self.title, self.player.username, self.url];
}

@end
