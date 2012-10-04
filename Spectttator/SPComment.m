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
@property (strong, nonatomic, readwrite) NSString *body;
@property (nonatomic, readwrite) NSUInteger likesCount;
@property (strong, nonatomic, readwrite) SPPlayer *player;
@end

@implementation SPComment

- (id)initWithDictionary:(NSDictionary *)dictionary{
    if((self = [super initWithDictionary:dictionary])){
        self.body = [dictionary stringSafelyFromKey:@"body"];
        self.likesCount = [dictionary uintSafelyFromKey:@"likes_count"];
        
        NSDictionary *player = [dictionary objectSafelyFromKey:@"player"];
        if(player != nil){
            self.player = [[SPPlayer alloc] initWithDictionary:player];
        }
    }
    
    return self;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"<%@ %lu Username='%@' Body=%@>", 
            [self class], (unsigned long)self.identifier, self.player.username, self.body];
}


@end
