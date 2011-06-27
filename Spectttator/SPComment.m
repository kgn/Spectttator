//
//  SPComment.m
//  Spectttator
//
//  Created by David Keegan on 6/27/11.
//  Copyright 2011 InScopeApps {+}. All rights reserved.
//

#import "SPComment.h"

@implementation SPComment

@synthesize identifier = _identifier;
@synthesize body = _body;
@synthesize likes_count = _likes_count;
@synthesize created_at = _created_at;
@synthesize player = _player;

- (id)initWithDictionary:(NSDictionary *)dictionary{
    if((self = [super init])){
        _identifier = [[dictionary objectForKey:@"id"] intValue];
        _body = [[NSString alloc] initWithString:[dictionary objectForKey:@"body"]];
        _likes_count = [[dictionary objectForKey:@"likes_count"] intValue];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss a"];
        _created_at = [[formatter dateFromString:[dictionary objectForKey:@"created_at"]] retain];
        [formatter release];
        
        _player = [[SPPlayer alloc] initWithDictionary:[dictionary objectForKey:@"player"]];
    }
    
    return self;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"<%@ %lu Username='%@' Body=%@>", 
            [self className], self.identifier, self.player.username, self.body];
}

- (void)dealloc{
    [_body release];
    [_created_at release];
    [_player release];
    [super dealloc];
}

@end
