//
//  SPComment.m
//  Spectttator
//
//  Created by David Keegan on 6/27/11.
//  Copyright 2011 David Keegan.
//

#import "SPComment.h"

@implementation SPComment

@synthesize body = _body;
@synthesize likesCount = _likesCount;
@synthesize player = _player;

- (id)initWithDictionary:(NSDictionary *)dictionary{
    if((self = [super initWithDictionary:dictionary])){
        _body = [[dictionary stringSafelyFromKey:@"body"] retain];
        _likesCount = [dictionary uintSafelyFromKey:@"likes_count"];
        
        NSDictionary *player = [dictionary objectSafelyFromKey:@"player"];
        if(player != nil){
            _player = [[SPPlayer alloc] initWithDictionary:player];
        }else{
            _player = nil;
        }
    }
    
    return self;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"<%@ %lu Username='%@' Body=%@>", 
            [self class], (unsigned long)self.identifier, self.player.username, self.body];
}

- (void)dealloc{
    [_body release];
    [_player release];
    [super dealloc];
}

@end
