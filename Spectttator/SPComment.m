//
//  SPComment.m
//  Spectttator
//
//  Created by David Keegan on 6/27/11.
//  Copyright 2011 David Keegan.
//

#import "SPComment.h"
#import "SPMethods.h"

@implementation SPComment

@synthesize identifier = _identifier;
@synthesize body = _body;
@synthesize likesCount = _likesCount;
@synthesize createdAt = _createdAt;
@synthesize player = _player;

- (id)initWithDictionary:(NSDictionary *)dictionary{
    if((self = [super init])){
        _identifier = [dictionary uintSafelyFromKey:@"id"];
        _body = [dictionary stringSafelyFromKey:@"body"];
        _likesCount = [dictionary uintSafelyFromKey:@"likes_count"];

        NSString *createdAt = [dictionary stringSafelyFromKey:@"created_at"];
        if(createdAt != nil){
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss '-0400'"];//TODO: find a better way to match the timezone
            _createdAt = [formatter dateFromString:[dictionary objectForKey:@"created_at"]];
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
        return (self.identifier == [(SPComment *)object identifier]);
    }
    return NO;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"<%@ %lu Username='%@' Body=%@>",
            [self class], self.identifier, self.player.username, self.body];
}

@end
