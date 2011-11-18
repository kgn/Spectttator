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
        _identifier = [dictionary uintSafelyFromKey:@"id"];
        _name = [[dictionary stringSafelyFromKey:@"name"] retain];
        _username = [[dictionary stringSafelyFromKey:@"username"] retain];
        _url = [[dictionary URLSafelyFromKey:@"url"] retain];
        _avatarUrl = [[dictionary URLSafelyFromKey:@"avatar_url"] retain];
        _location = [[dictionary stringSafelyFromKey:@"location"] retain];
        _twitterScreenName = [[dictionary stringSafelyFromKey:@"twitter_screen_name"] retain];
        _draftedByPlayerId = [dictionary uintSafelyFromKey:@"drafted_by_player_id"];
        
        _shotsCount = [dictionary uintSafelyFromKey:@"shots_count"];
        _drafteesCount = [dictionary uintSafelyFromKey:@"draftees_count"];
        _followersCount = [dictionary uintSafelyFromKey:@"followers_count"];
        _followingCount = [dictionary uintSafelyFromKey:@"following_count"];
        _commentsCount = [dictionary uintSafelyFromKey:@"comments_count"];
        _commentsReceivedCount = [dictionary uintSafelyFromKey:@"comments_received_count"];
        _likesCount = [dictionary uintSafelyFromKey:@"likes_count"];
        _likesReceivedCount = [dictionary uintSafelyFromKey:@"likes_received_count"];
        _reboundsCount = [dictionary uintSafelyFromKey:@"rebounds_count"];
        _reboundsReceivedCount = [dictionary uintSafelyFromKey:@"rebounds_received_count"];
        
        NSString *createdAt = [dictionary stringSafelyFromKey:@"created_at"];
        if(createdAt != nil){
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss '-0400'"];//TODO: find a better way to match the timezone
            _createdAt = [[formatter dateFromString:[dictionary objectForKey:@"created_at"]] retain];
            [formatter release];
        }else{
            _createdAt = nil;
        }
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

- (void)dealloc{
    [_name release];
    [_username release];
    [_url release];
    [_avatarUrl release];
    [_location release];
    [_twitterScreenName release];
    [_createdAt release];
    [super dealloc];
}

@end
