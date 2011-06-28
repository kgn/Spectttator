//
//  SPShot.h
//  Spectttator
//
//  Created by David Keegan on 6/26/11.
//  Copyright 2011 InScopeApps {+}. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPPagination.h"
#import "SPPlayer.h"

@interface SPShot : NSObject {
    NSUInteger _identifier;
    NSString *_title;
    NSURL *_url;
    NSURL *_short_url;
    NSURL *_image_url;
    NSURL *_image_teaser_url;
    NSUInteger _width;
    NSUInteger _height;
    NSUInteger _views_count;
    NSUInteger _likes_count;
    NSUInteger _comments_count;
    NSUInteger _rebounds_count;
    NSUInteger _rebound_source_id;
    NSDate *_created_at;
    SPPlayer *_player;
}

@property (readonly) NSUInteger identifier;
@property (readonly) NSString *title;
@property (readonly) NSURL *url;
@property (readonly) NSURL *short_url;
@property (readonly) NSURL *image_url;
@property (readonly) NSURL *image_teaser_url;
@property (readonly) NSUInteger width;
@property (readonly) NSUInteger height;
@property (readonly) NSUInteger views_count;
@property (readonly) NSUInteger likes_count;
@property (readonly) NSUInteger comments_count;
@property (readonly) NSUInteger rebounds_count;
@property (readonly) NSUInteger rebound_source_id;//the id or NSNotFound
@property (readonly) NSDate *created_at;
@property (readonly) SPPlayer *player;

- (void)imageWithBlock:(void (^)(NSImage *))block;
- (void)imageTeaserWithBlock:(void (^)(NSImage *))block;

- (void)reboundsWithBlock:(void (^)(NSArray *, SPPagination *))block;
- (void)reboundsWithBlock:(void (^)(NSArray *, SPPagination *))block andPagination:(NSDictionary *)pagination;
- (void)commentsWithBlock:(void (^)(NSArray *, SPPagination *))block;
- (void)commentsWithBlock:(void (^)(NSArray *, SPPagination *))block andPagination:(NSDictionary *)pagination;
    
- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
