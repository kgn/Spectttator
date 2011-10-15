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
        _identifier = [dictionary uintSafelyFromKey:@"id"];
        _title = [dictionary stringSafelyFromKey:@"title"];
        _url = [dictionary URLSafelyFromKey:@"url"];
        _shortUrl = [dictionary URLSafelyFromKey:@"short_url"];
        _imageUrl = [dictionary URLSafelyFromKey:@"image_url"];
        _imageTeaserUrl = [dictionary URLSafelyFromKey:@"image_teaser_url"];
        _width = [dictionary uintSafelyFromKey:@"width"];
        _height = [dictionary uintSafelyFromKey:@"height"];
        _viewsCount = [dictionary uintSafelyFromKey:@"views_count"];
        _likesCount = [dictionary uintSafelyFromKey:@"likes_count"];
        _commentsCount = [dictionary uintSafelyFromKey:@"comments_count"];
        _reboundsCount = [dictionary uintSafelyFromKey:@"rebounds_count"];
        _reboundSourceId = [dictionary uintSafelyFromKey:@"rebound_source_id"];

        NSString *createdAt = [dictionary stringSafelyFromKey:@"created_at"];
        if(createdAt != nil){
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss '-0400'"];//TODO: find a better way to match the timezone
            _createdAt = [[formatter dateFromString:[dictionary objectForKey:@"created_at"]] retain];
            [formatter release];
        }else{
            _createdAt = nil;
        }

        NSDictionary *player = [dictionary objectSafelyFromKey:@"player"];
        if(player != nil){
        _player = [[SPPlayer alloc] initWithDictionary:player];
        }else{
            _player = nil;
        }
    }

    return self;
}

- (NSUInteger)hash{
    return self.identifier;
}

- (BOOL)isEqual:(id)object{
    if([object isKindOfClass:[self class]]){
        return (self.identifier == [(SPShot *)object identifier]);
    }
    return NO;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"<%@ %lu Title='%@' Player=%@ URL=%@>",
            [self class], self.identifier, self.title, self.player.username, self.url];
}

@end
