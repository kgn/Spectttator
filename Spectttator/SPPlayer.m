//
//  SPPlayer.m
//  Spectttator
//
//  Created by David Keegan on 6/26/11.
//  Copyright 2011 David Keegan.
//

#import "SPPlayer.h"

@interface SPPlayer()
@property (copy, nonatomic, readwrite) NSString *name;
@property (copy, nonatomic, readwrite) NSString *username;
@property (retain, nonatomic, readwrite) NSURL *url;
@property (retain, nonatomic, readwrite) NSURL *avatarUrl;
@property (copy, nonatomic, readwrite) NSString *location;
@property (copy, nonatomic, readwrite) NSString *twitterScreenName;
@property (nonatomic, readwrite) NSUInteger draftedByPlayerId;
@property (nonatomic, readwrite) NSUInteger shotsCount;
@property (nonatomic, readwrite) NSUInteger drafteesCount;
@property (nonatomic, readwrite) NSUInteger followersCount;
@property (nonatomic, readwrite) NSUInteger followingCount;
@property (nonatomic, readwrite) NSUInteger commentsCount;
@property (nonatomic, readwrite) NSUInteger commentsReceivedCount;
@property (nonatomic, readwrite) NSUInteger likesCount;
@property (nonatomic, readwrite) NSUInteger likesReceivedCount;
@property (nonatomic, readwrite) NSUInteger reboundsCount;
@property (nonatomic, readwrite) NSUInteger reboundsReceivedCount;
@end

@implementation SPPlayer
    
- (void)avatarRunOnMainThread:(BOOL)runOnMainThread 
                    withBlock:(void (^)(SPImage *image))block{
    [SPMethods requestImageWithURL:self.avatarUrl
                   runOnMainThread:runOnMainThread 
                         withBlock:block];
}

- (id)initWithDictionary:(NSDictionary *)dictionary{
    if((self = [super initWithDictionary:dictionary])){
        self.name = [dictionary stringSafelyFromKey:@"name"];
        self.username = [dictionary stringSafelyFromKey:@"username"];
        self.url = [dictionary URLSafelyFromKey:@"url"];
        self.avatarUrl = [dictionary URLSafelyFromKey:@"avatar_url"];
        self.location = [dictionary stringSafelyFromKey:@"location"];
        self.twitterScreenName = [[dictionary stringSafelyFromKey:@"twitter_screen_name"] retain];
        self.draftedByPlayerId = [dictionary uintSafelyFromKey:@"drafted_by_player_id"];
        self.shotsCount = [dictionary uintSafelyFromKey:@"shots_count"];
        self.drafteesCount = [dictionary uintSafelyFromKey:@"draftees_count"];
        self.followersCount = [dictionary uintSafelyFromKey:@"followers_count"];
        self.followingCount = [dictionary uintSafelyFromKey:@"following_count"];
        self.commentsCount = [dictionary uintSafelyFromKey:@"comments_count"];
        self.commentsReceivedCount = [dictionary uintSafelyFromKey:@"comments_received_count"];
        self.likesCount = [dictionary uintSafelyFromKey:@"likes_count"];
        self.likesReceivedCount = [dictionary uintSafelyFromKey:@"likes_received_count"];
        self.reboundsCount = [dictionary uintSafelyFromKey:@"rebounds_count"];
        self.reboundsReceivedCount = [dictionary uintSafelyFromKey:@"rebounds_received_count"];
    }
    
    return self;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"<%@ %lu Name='%@' Username='%@' URL=%@>", 
            [self class], (unsigned long)self.identifier, self.name, self.username, self.url];
}

- (void)dealloc{
    [_name release];
    [_username release];
    [_url release];
    [_avatarUrl release];
    [_location release];
    [_twitterScreenName release];
    [super dealloc];
}

@end
