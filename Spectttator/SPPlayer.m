//
//  SPPlayer.m
//  Spectttator
//
//  Created by David Keegan on 6/26/11.
//  Copyright 2011 David Keegan.
//

#import "SPPlayer.h"
#import "SPMethods.h"

@implementation SPPlayer

@synthesize identifier = _identifier;
@synthesize name = _name;
@synthesize username = _username;
@synthesize url = _url;
@synthesize avatarUrl = _avatarUrl;
@synthesize location = _location;
@synthesize twitterScreenName = _twitterScreenName;
@synthesize draftedByPlayerId = _draftedByPlayerId;
@synthesize shotsCount = _shotsCount;
@synthesize drafteesCount = _drafteesCount;
@synthesize followersCount = _followersCount;
@synthesize followingCount = _followingCount;
@synthesize commentsCount = _commentsCount;
@synthesize commentsReceivedCount = _commentsReceivedCount;
@synthesize likesCount = _likesCount;
@synthesize likesReceivedCount = _likesReceivedCount;
@synthesize reboundsCount = _reboundsCount;
@synthesize reboundsReceivedCount = _reboundsReceivedCount;
@synthesize createdAt = _createdAt;
    
- (void)avatarRunOnMainThread:(BOOL)runOnMainThread 
                    withBlock:(void (^)(
#if TARGET_OS_IPHONE
                                        UIImage *
#else
                                        NSImage *
#endif
                                        ))block{
    [SPMethods requestImageWithURL:self.avatarUrl
                   runOnMainThread:runOnMainThread 
                         withBlock:block];
}

- (id)initWithDictionary:(NSDictionary *)dictionary{
    if((self = [super init])){
        _identifier = [[dictionary objectForKey:@"id"] intValue];
        _name = [dictionary objectForKey:@"name"];
        _username = [dictionary objectForKey:@"username"];               
        _url = [NSURL URLWithString:[dictionary objectForKey:@"url"] ?: @""];
        _avatarUrl = [NSURL URLWithString:[dictionary objectForKey:@"avatar_url"] ?: @""];
        
        if([dictionary objectForKey:@"location"] != [NSNull null]){
            _location = [dictionary objectForKey:@"location"];
        }
        
        if([dictionary objectForKey:@"twitter_screen_name"] != [NSNull null]){
            _twitterScreenName = [dictionary objectForKey:@"twitter_screen_name"];
        }
        
        if([dictionary objectForKey:@"drafted_by_player_id"] != [NSNull null]){
            _draftedByPlayerId = [[dictionary objectForKey:@"drafted_by_player_id"] intValue];
        }else{
            _draftedByPlayerId = NSNotFound;
        }        
        
        _shotsCount = [[dictionary objectForKey:@"shots_count"] intValue];
        _drafteesCount = [[dictionary objectForKey:@"draftees_count"] intValue];
        _followersCount = [[dictionary objectForKey:@"followers_count"] intValue];
        _followingCount = [[dictionary objectForKey:@"following_count"] intValue];
        _commentsCount = [[dictionary objectForKey:@"comments_count"] intValue];
        _commentsReceivedCount = [[dictionary objectForKey:@"comments_received_count"] intValue];
        _likesCount = [[dictionary objectForKey:@"likes_count"] intValue];
        _likesReceivedCount = [[dictionary objectForKey:@"likes_received_count"] intValue];
        _reboundsCount = [[dictionary objectForKey:@"rebounds_count"] intValue];
        _reboundsReceivedCount = [[dictionary objectForKey:@"rebounds_received_count"] intValue];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss a"];
        _createdAt = [formatter dateFromString:[dictionary objectForKey:@"created_at"]];
    }
    
    return self;
}

- (NSUInteger)hash{
    return self.identifier;
}

- (BOOL)isEqual:(id)object{
    if([object isKindOfClass:[self class]]){
        return (self.identifier == [(SPPlayer *)object identifier]);
    }
    return NO;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"<%@ %lu Name='%@' Username='%@' URL=%@>", 
            [self class], self.identifier, self.name, self.username, self.url];
}

@end
