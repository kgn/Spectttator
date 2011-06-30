//
//  SPShot.m
//  Spectttator
//
//  Created by David Keegan on 6/26/11.
//  Copyright 2011 InScopeApps {+}. All rights reserved.
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

#if (TARGET_IPHONE_SIMULATOR || TARGET_OS_IPHONE)
- (void)imageWithBlock:(void (^)(UIImage *))block{
#else
- (void)imageWithBlock:(void (^)(NSImage *))block{
#endif
    [[SPRequest operationQueue] addOperation:[NSBlockOperation blockOperationWithBlock:^{
        #if (TARGET_IPHONE_SIMULATOR || TARGET_OS_IPHONE)
        block([UIImage imageWithData:[NSData dataWithContentsOfURL:self.imageUrl]]);
        #else        
        block([[[NSImage alloc] initWithContentsOfURL:self.imageUrl] autorelease]);
        #endif
    }]];
}
    
#if (TARGET_IPHONE_SIMULATOR || TARGET_OS_IPHONE)
- (void)imageTeaserWithBlock:(void (^)(UIImage *))block{
#else
- (void)imageTeaserWithBlock:(void (^)(NSImage *))block{
#endif
    [[SPRequest operationQueue] addOperation:[NSBlockOperation blockOperationWithBlock:^{
        #if (TARGET_IPHONE_SIMULATOR || TARGET_OS_IPHONE)
        block([UIImage imageWithData:[NSData dataWithContentsOfURL:self.imageTeaserUrl]]);
        #else        
        block([[[NSImage alloc] initWithContentsOfURL:self.imageTeaserUrl] autorelease]);
        #endif
    }]];
}

- (void)reboundsWithBlock:(void (^)(NSArray *, SPPagination *))block{
    [self reboundsWithBlock:block andPagination:nil];
}

- (void)reboundsWithBlock:(void (^)(NSArray *, SPPagination *))block andPagination:(NSDictionary *)pagination{
    NSString *urlString = [NSString stringWithFormat:
                           @"http://api.dribbble.com/shots/%lu/rebounds", 
                           self.identifier, [SPRequest pagination:pagination]];
    [[SPRequest operationQueue] addOperation:[NSBlockOperation blockOperationWithBlock:^{
        NSDictionary *json = [SPRequest dataFromUrl:[NSURL URLWithString:urlString]];
        NSArray *shots = [json objectForKey:@"shots"];
        NSMutableArray *mshots = [[NSMutableArray alloc] initWithCapacity:[shots count]];
        NSAutoreleasePool *pool =  [[NSAutoreleasePool alloc] init];
            for(NSDictionary *shotData in shots){
                SPShot *shot = [[SPShot alloc] initWithDictionary:shotData];
                [mshots addObject:shot];
                [shot release];
            }
        [pool drain];
        block(mshots, [SPPagination paginationWithDictionary:json]);
    }]];    
}

- (void)commentsWithBlock:(void (^)(NSArray *, SPPagination *))block{
    [self commentsWithBlock:block andPagination:nil];
}

- (void)commentsWithBlock:(void (^)(NSArray *, SPPagination *))block andPagination:(NSDictionary *)pagination{
    NSString *urlString = [NSString stringWithFormat:
                           @"http://api.dribbble.com/shots/%lu/comments", 
                           self.identifier, [SPRequest pagination:pagination]];
    [[SPRequest operationQueue] addOperation:[NSBlockOperation blockOperationWithBlock:^{
        NSDictionary *json = [SPRequest dataFromUrl:[NSURL URLWithString:urlString]];
        NSArray *comments = [json objectForKey:@"comments"];
        NSMutableArray *mcomments = [[NSMutableArray alloc] initWithCapacity:[comments count]];
        NSAutoreleasePool *pool =  [[NSAutoreleasePool alloc] init];
            for(NSDictionary *commentData in comments){
                SPComment *comment = [[SPComment alloc] initWithDictionary:commentData];
                [mcomments addObject:comment];
                [comment release];
            }
        [pool drain];
        block(mcomments, [SPPagination paginationWithDictionary:json]);
    }]];    
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
