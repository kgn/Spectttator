//
//  SPComment.m
//  Spectttator
//
//  Created by David Keegan on 6/27/11.
//  Copyright 2011 David Keegan.
//

#import "SPComment.h"

@implementation SPComment

@synthesize identifier = _identifier;
@synthesize body = _body;
@synthesize likesCount = _likesCount;
@synthesize createdAt = _createdAt;
@synthesize player = _player;

- (id)initWithDictionary:(NSDictionary *)dictionary{
    if((self = [super init])){
        _identifier = [[dictionary objectForKey:@"id"] intValue];
        _body = [dictionary objectForKey:@"body"];
        _likesCount = [[dictionary objectForKey:@"likes_count"] intValue];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss a"];
        _createdAt = [formatter dateFromString:[dictionary objectForKey:@"created_at"]];
        
        _player = [[SPPlayer alloc] initWithDictionary:[dictionary objectForKey:@"player"]];
    }
    
    return self;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"<%@ %lu Username='%@' Body=%@>", 
            [self class], self.identifier, self.player.username, self.body];
}

@end
