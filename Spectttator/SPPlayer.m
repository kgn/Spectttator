//
//  SPPlayer.m
//  Spectttator
//
//  Created by David Keegan on 6/26/11.
//  Copyright 2011 InScopeApps {+}. All rights reserved.
//

#import "SPPlayer.h"
#import "SPRequest.h"

@implementation SPPlayer

@synthesize identifier = _identifier;
@synthesize name = _name;
@synthesize username = _username;
@synthesize url = _url;
@synthesize avatar_url = _avatar_url;
@synthesize location = _location;
@synthesize twitter_screen_name = _twitter_screen_name;
@synthesize drafted_by_player_id = _drafted_by_player_id;
@synthesize shots_count = _shots_count;
@synthesize draftees_count = _draftees_count;
@synthesize followers_count = _followers_count;
@synthesize following_count = _following_count;
@synthesize comments_count = _comments_count;
@synthesize comments_received_count = _comments_received_count;
@synthesize likes_count = _likes_count;
@synthesize likes_received_count = _likes_received_count;
@synthesize rebounds_count = _rebounds_count;
@synthesize rebounds_received_count = _rebounds_received_count;
@synthesize created_at = _created_at;

- (void)avatarWithBlock:(void (^)(NSImage *))block{
    [[SPRequest operationQueue] addOperation:[NSBlockOperation blockOperationWithBlock:^{
        block([[[NSImage alloc] initWithContentsOfURL:self.avatar_url] autorelease]);
    }]];    
}

- (id)initWithDictionary:(NSDictionary *)dictionary{
    if((self = [super init])){
        _identifier = [[dictionary objectForKey:@"id"] intValue];
        _name = [[NSString alloc] initWithString:[dictionary objectForKey:@"name"]];
        _username = [[NSString alloc] initWithString:[dictionary objectForKey:@"username"]];               
        _url = [[NSURL alloc] initWithString:[dictionary objectForKey:@"url"]];
        _avatar_url = [[NSURL alloc] initWithString:[dictionary objectForKey:@"avatar_url"]];
        
        if([dictionary objectForKey:@"location"] != [NSNull null]){
            _location = [[NSString alloc] initWithString:[dictionary objectForKey:@"location"]];
        }else{
            _location = nil;
        }
        
        if([dictionary objectForKey:@"twitter_screen_name"] != [NSNull null]){
            _twitter_screen_name = [[NSString alloc] initWithString:[dictionary objectForKey:@"twitter_screen_name"]];
        }else{
            _twitter_screen_name = nil;
        }
        
        if([dictionary objectForKey:@"drafted_by_player_id"] != [NSNull null]){
            _drafted_by_player_id = [[dictionary objectForKey:@"drafted_by_player_id"] intValue];
        }else{
            _drafted_by_player_id = NSNotFound;
        }        
        
        _shots_count = [[dictionary objectForKey:@"shots_count"] intValue];
        _draftees_count = [[dictionary objectForKey:@"draftees_count"] intValue];
        _followers_count = [[dictionary objectForKey:@"followers_count"] intValue];
        _following_count = [[dictionary objectForKey:@"following_count"] intValue];
        _comments_count = [[dictionary objectForKey:@"comments_count"] intValue];
        _comments_received_count = [[dictionary objectForKey:@"comments_received_count"] intValue];
        _likes_count = [[dictionary objectForKey:@"likes_count"] intValue];
        _comments_count = [[dictionary objectForKey:@"comments_count"] intValue];
        _rebounds_count = [[dictionary objectForKey:@"rebounds_count"] intValue];        
        _rebounds_received_count = [[dictionary objectForKey:@"rebounds_received_count"] intValue];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss a"];
        _created_at = [[formatter dateFromString:[dictionary objectForKey:@"created_at"]] retain];
        [formatter release];
    }
    
    return self;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"<%@ %lu Name='%@' Username='%@' URL=%@>", 
            [self className], self.identifier, self.name, self.username, self.url];
}

- (void)dealloc{
    [_name release];
    [_username release];
    [_url release];
    [_avatar_url release];
    [_location release];
    [_twitter_screen_name release];
    [_created_at release];
    [super dealloc];
}

@end
