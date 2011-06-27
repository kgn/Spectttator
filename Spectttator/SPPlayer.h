//
//  SPPlayer.h
//  Spectttator
//
//  Created by David Keegan on 6/26/11.
//  Copyright 2011 InScopeApps {+}. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPPlayer : NSObject {
    NSUInteger _identifier;
    NSString *_name;
    NSString *_username;
    NSURL *_url;
    NSURL *_avatar_url;
    NSString *_location;
    NSString *_twitter_screen_name;
    NSUInteger _drafted_by_player_id;
    NSUInteger _shots_count;
    NSUInteger _draftees_count;
    NSUInteger _followers_count;
    NSUInteger _following_count;
    NSUInteger _comments_count;
    NSUInteger _comments_received_count;
    NSUInteger _likes_count;
    NSUInteger _likes_received_count;
    NSUInteger _rebounds_count;
    NSUInteger _rebounds_received_count;
    NSDate *_created_at;
}

@property (readonly) NSUInteger identifier;
@property (readonly) NSString *name;
@property (readonly) NSString *username;
@property (readonly) NSURL *url;
@property (readonly) NSURL *avatar_url;
@property (readonly) NSString *location;
@property (readonly) NSString *twitter_screen_name;
@property (readonly) NSUInteger drafted_by_player_id;//id or NSNotFound
@property (readonly) NSUInteger shots_count;
@property (readonly) NSUInteger draftees_count;
@property (readonly) NSUInteger followers_count;
@property (readonly) NSUInteger following_count;
@property (readonly) NSUInteger comments_count;
@property (readonly) NSUInteger comments_received_count;
@property (readonly) NSUInteger likes_count;
@property (readonly) NSUInteger likes_received_count;
@property (readonly) NSUInteger rebounds_count;
@property (readonly) NSUInteger rebounds_received_count;
@property (readonly) NSDate *created_at;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
