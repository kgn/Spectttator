//
//  SPComment.h
//  Spectttator
//
//  Created by David Keegan on 6/27/11.
//  Copyright 2011 InScopeApps {+}. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPPlayer.h"

@interface SPComment : NSObject{
    NSUInteger _identifier;
    NSString *_body;
    NSUInteger _likes_count;
    NSDate *_created_at;
    SPPlayer *_player;
}

@property (readonly) NSUInteger identifier;
@property (readonly) NSString *body;
@property (readonly) NSUInteger likes_count;
@property (readonly) NSDate *created_at;
@property (readonly) SPPlayer *player;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
