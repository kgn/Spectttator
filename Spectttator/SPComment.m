//
//  SPComment.m
//  Spectttator
//
//  Created by David Keegan on 6/27/11.
//  Copyright 2011 David Keegan.
//

#import "SPComment.h"
#import "SPPlayer.h"

@interface SPComment()
@property (copy, nonatomic, readwrite) NSString *body;
@property (nonatomic, readwrite) NSUInteger likesCount;
@property (retain, nonatomic, readwrite) SPPlayer *player;
@end

@implementation SPComment

- (id)initWithDictionary:(NSDictionary *)dictionary{
    if((self = [super initWithDictionary:dictionary])){
        self.body = [[dictionary stringSafelyFromKey:@"body"] retain];
        self.likesCount = [dictionary uintSafelyFromKey:@"likes_count"];
        
        NSDictionary *player = [dictionary objectSafelyFromKey:@"player"];
        if(player != nil){
            self.player = [[[SPPlayer alloc] initWithDictionary:player] autorelease];
        }
    }
    
    return self;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"<%@ %lu Username='%@' Body=%@>", 
            [self class], self.identifier, self.player.username, self.body];
}

- (void)dealloc{
    [_body release];
    [_player release];
    [super dealloc];
}

@end
