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
@synthesize short_url = _short_url;
@synthesize image_url = _image_url;
@synthesize image_teaser_url = _image_teaser_url;
@synthesize width = _width;
@synthesize height = _height;
@synthesize views_count = _views_count;
@synthesize likes_count = _likes_count;
@synthesize comments_count = _comments_count;
@synthesize rebounds_count = _rebounds_count;
@synthesize rebound_source_id = _rebound_source_id;
@synthesize created_at = _created_at;
@synthesize player = _player;

- (void)reboundsWithBlock:(void (^)(NSArray *, SPPagination *))block{
    [self reboundsWithBlock:block forPagination:nil];
}

- (void)reboundsWithBlock:(void (^)(NSArray *, SPPagination *))block forPagination:(NSDictionary *)pagination{
    NSString *urlString = [NSString stringWithFormat:
                           @"http://api.dribbble.com/shots/%lu/rebounds", 
                           self.identifier, [SPRequest pagination:pagination]];
    [[SPRequest operationQueue] addOperation:[NSBlockOperation blockOperationWithBlock:^{
        NSDictionary *json = [SPRequest dataFromUrl:[NSURL URLWithString:urlString]];
        NSArray *shots = [json objectForKey:@"shots"];
        NSMutableArray *mshots = [[NSMutableArray alloc] initWithCapacity:[shots count]];
        @autoreleasepool {
            for(NSDictionary *shotData in shots){
                SPShot *shot = [[SPShot alloc] initWithDictionary:shotData];
                [mshots addObject:shot];
                [shot release];
            }
        }
        block(mshots, [SPPagination paginationWithDictionary:json]);
    }]];    
}

- (void)commentsWithBlock:(void (^)(NSArray *, SPPagination *))block{
    [self commentsWithBlock:block forPagination:nil];
}

- (void)commentsWithBlock:(void (^)(NSArray *, SPPagination *))block forPagination:(NSDictionary *)pagination{
    NSString *urlString = [NSString stringWithFormat:
                           @"http://api.dribbble.com/shots/%lu/comments", 
                           self.identifier, [SPRequest pagination:pagination]];
    [[SPRequest operationQueue] addOperation:[NSBlockOperation blockOperationWithBlock:^{
        NSDictionary *json = [SPRequest dataFromUrl:[NSURL URLWithString:urlString]];
        NSArray *comments = [json objectForKey:@"comments"];
        NSMutableArray *mcomments = [[NSMutableArray alloc] initWithCapacity:[comments count]];
        @autoreleasepool {
            for(NSDictionary *commentData in comments){
                SPComment *comment = [[SPComment alloc] initWithDictionary:commentData];
                [mcomments addObject:comment];
                [comment release];
            }
        }
        block(mcomments, [SPPagination paginationWithDictionary:json]);
    }]];    
}

- (id)initWithDictionary:(NSDictionary *)dictionary{
    if((self = [super init])){
        _identifier = [[dictionary objectForKey:@"id"] intValue];
        _title = [[NSString alloc] initWithString:[dictionary objectForKey:@"title"]];
        _url = [[NSURL alloc] initWithString:[dictionary objectForKey:@"url"]];
        _short_url = [[NSURL alloc] initWithString:[dictionary objectForKey:@"short_url"]];
        _image_url = [[NSURL alloc] initWithString:[dictionary objectForKey:@"image_url"]];
        _image_teaser_url = [[NSURL alloc] initWithString:[dictionary objectForKey:@"image_teaser_url"]];
        _width = [[dictionary objectForKey:@"width"] intValue];
        _height = [[dictionary objectForKey:@"height"] intValue];
        _views_count = [[dictionary objectForKey:@"views_count"] intValue];
        _likes_count = [[dictionary objectForKey:@"likes_count"] intValue];
        _comments_count = [[dictionary objectForKey:@"comments_count"] intValue];
        _rebounds_count = [[dictionary objectForKey:@"rebounds_count"] intValue];
        
        if([dictionary objectForKey:@"rebound_source_id"] != [NSNull null]){
            _rebound_source_id = [[dictionary objectForKey:@"rebound_source_id"] intValue];
        }else{
            _rebound_source_id = NSNotFound;
        }
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss a"];
        _created_at = [[formatter dateFromString:[dictionary objectForKey:@"created_at"]] retain];
        [formatter release];
        
        _player = [[SPPlayer alloc] initWithDictionary:[dictionary objectForKey:@"player"]];
    }
    
    return self;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"<%@ %lu Title='%@' Player=%@ URL=%@>", 
            [self className], self.identifier, self.title, self.player.username, self.url];
}

- (void)dealloc{
    [_title release];
    [_url release];
    [_short_url release];
    [_image_url release];
    [_image_teaser_url release];
    [_created_at release];
    [super dealloc];
}

@end
