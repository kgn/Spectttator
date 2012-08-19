//
//  SPShot.m
//  Spectttator
//
//  Created by David Keegan on 6/26/11.
//  Copyright 2011 David Keegan.
//

#import "SPShot.h"
#import "SPComment.h"
#import "SPPagination.h"
#import "SPPlayer.h"

@interface SPShot()
@property (copy, nonatomic, readwrite) NSString *title;
@property (retain, nonatomic, readwrite) NSURL *url;
@property (retain, nonatomic, readwrite) NSURL *shortUrl;
@property (retain, nonatomic, readwrite) NSURL *imageUrl;
@property (retain, nonatomic, readwrite) NSURL *imageTeaserUrl;
@property (nonatomic, readwrite) NSUInteger width;
@property (nonatomic, readwrite) NSUInteger height;
@property (nonatomic, readwrite) NSUInteger viewsCount;
@property (nonatomic, readwrite) NSUInteger likesCount;
@property (nonatomic, readwrite) NSUInteger commentsCount;
@property (nonatomic, readwrite) NSUInteger reboundsCount;
@property (nonatomic, readwrite) NSUInteger reboundSourceId;
@property (retain, nonatomic, readwrite) SPPlayer *player;
@end

@implementation SPShot

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
                           @"http://api.dribbble.com/shots/%lu/rebounds%@", 
                           self.identifier, [SPMethods pagination:pagination]];
    [SPMethods requestShotsWithURL:[NSURL URLWithString:urlString] 
                   runOnMainThread:runOnMainThread 
                         withBlock:block];
}

- (void)commentsWithPagination:(NSDictionary *)pagination
               runOnMainThread:(BOOL)runOnMainThread 
                     withBlock:(void (^)(NSArray *comments, SPPagination *pagination))block{
    NSString *urlString = [NSString stringWithFormat:
                           @"http://api.dribbble.com/shots/%lu/comments%@", 
                           self.identifier, [SPMethods pagination:pagination]];
    [SPMethods requestCommentsWithURL:[NSURL URLWithString:urlString] 
                   runOnMainThread:runOnMainThread 
                         withBlock:block];
}

- (id)initWithDictionary:(NSDictionary *)dictionary{
    if((self = [super initWithDictionary:dictionary])){
        self.title = [dictionary stringSafelyFromKey:@"title"];
        self.url = [dictionary URLSafelyFromKey:@"url"];
        self.shortUrl = [dictionary URLSafelyFromKey:@"short_url"];
        self.imageUrl = [dictionary URLSafelyFromKey:@"image_url"];
        self.imageTeaserUrl = [dictionary URLSafelyFromKey:@"image_teaser_url"];
        self.width = [dictionary uintSafelyFromKey:@"width"];
        self.height = [dictionary uintSafelyFromKey:@"height"];
        self.viewsCount = [dictionary uintSafelyFromKey:@"views_count"];
        self.likesCount = [dictionary uintSafelyFromKey:@"likes_count"];
        self.commentsCount = [dictionary uintSafelyFromKey:@"comments_count"];
        self.reboundsCount = [dictionary uintSafelyFromKey:@"rebounds_count"];
        self.reboundSourceId = [dictionary uintSafelyFromKey:@"rebound_source_id"];
        
        NSDictionary *player = [dictionary objectSafelyFromKey:@"player"];
        if(player != nil){
            self.player = [[[SPPlayer alloc] initWithDictionary:player] autorelease];
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
