//
//  SPManager.m
//  Spectttator
//
//  Created by David Keegan on 6/25/11.
//  Copyright 2011 InScopeApps {+}. All rights reserved.
//

#import "SPManager.h"
#import "SPRequest.h"

static SPManager *sharedInstance = nil;

@implementation SPManager

#pragma mark -
#pragma mark shot

- (void)shotInformationForIdentifier:(NSUInteger)identifier withBlock:(void (^)(SPShot *))block{
    NSString *urlString = [NSString stringWithFormat:@"http://api.dribbble.com/shots/%lu", identifier];
    [[SPRequest operationQueue] addOperation:[NSBlockOperation blockOperationWithBlock:^{
        NSDictionary *json = [SPRequest dataFromUrl:[NSURL URLWithString:urlString]];
        block([[[SPShot alloc] initWithDictionary:json] autorelease]);
    }]];     
}

#pragma mark -
#pragma mark player

- (void)playerInformationForUsername:(NSString *)player withBlock:(void (^)(SPPlayer *))block{
    NSString *urlString = [NSString stringWithFormat:@"http://api.dribbble.com/players/%@", player];
    [[SPRequest operationQueue] addOperation:[NSBlockOperation blockOperationWithBlock:^{
        NSDictionary *json = [SPRequest dataFromUrl:[NSURL URLWithString:urlString]];
        block([[[SPPlayer alloc] initWithDictionary:json] autorelease]);
    }]];     
}

#pragma mark -
#pragma mark player followers

- (void)playerFollowers:(NSString *)player withBlock:(void (^)(NSArray *, SPPagination *))block{
    [self playerFollowers:player withBlock:block andPagination:nil];
}

- (void)playerFollowers:(NSString *)player withBlock:(void (^)(NSArray *, SPPagination *))block andPagination:(NSDictionary *)pagination{
    NSString *urlString = [NSString stringWithFormat:
                           @"http://api.dribbble.com/players/%@/followers%@", 
                           player, [SPRequest pagination:pagination]];
    [[SPRequest operationQueue] addOperation:[NSBlockOperation blockOperationWithBlock:^{
        NSDictionary *json = [SPRequest dataFromUrl:[NSURL URLWithString:urlString]];
        NSArray *players = [json objectForKey:@"players"];
        NSMutableArray *mplayers = [[NSMutableArray alloc] initWithCapacity:[players count]];
        @autoreleasepool {
            for(NSDictionary *playerData in players){
                SPPlayer *player = [[SPPlayer alloc] initWithDictionary:playerData];
                [mplayers addObject:player];
                [player release];
            }
        }
        block(mplayers, [SPPagination paginationWithDictionary:json]);
    }]];     
}

#pragma mark -
#pragma mark player following

- (void)playerFollowing:(NSString *)player withBlock:(void (^)(NSArray *, SPPagination *))block{
    [self playerFollowing:player withBlock:block andPagination:nil];
}

- (void)playerFollowing:(NSString *)player withBlock:(void (^)(NSArray *, SPPagination *))block andPagination:(NSDictionary *)pagination{
    NSString *urlString = [NSString stringWithFormat:
                           @"http://api.dribbble.com/players/%@/following%@", 
                           player, [SPRequest pagination:pagination]];
    [[SPRequest operationQueue] addOperation:[NSBlockOperation blockOperationWithBlock:^{
        NSDictionary *json = [SPRequest dataFromUrl:[NSURL URLWithString:urlString]];
        NSArray *players = [json objectForKey:@"players"];
        NSMutableArray *mplayers = [[NSMutableArray alloc] initWithCapacity:[players count]];
        @autoreleasepool {
            for(NSDictionary *playerData in players){
                SPPlayer *player = [[SPPlayer alloc] initWithDictionary:playerData];
                [mplayers addObject:player];
                [player release];
            }
        }
        block(mplayers, [SPPagination paginationWithDictionary:json]);
    }]];     
}

#pragma mark -
#pragma mark player draftees

- (void)playerDraftees:(NSString *)player withBlock:(void (^)(NSArray *, SPPagination *))block{
    [self playerDraftees:player withBlock:block andPagination:nil];
}

- (void)playerDraftees:(NSString *)player withBlock:(void (^)(NSArray *, SPPagination *))block andPagination:(NSDictionary *)pagination{
    NSString *urlString = [NSString stringWithFormat:
                           @"http://api.dribbble.com/players/%@/draftees%@", 
                           player, [SPRequest pagination:pagination]];
    [[SPRequest operationQueue] addOperation:[NSBlockOperation blockOperationWithBlock:^{
        NSDictionary *json = [SPRequest dataFromUrl:[NSURL URLWithString:urlString]];
        NSArray *players = [json objectForKey:@"players"];
        NSMutableArray *mplayers = [[NSMutableArray alloc] initWithCapacity:[players count]];
        @autoreleasepool {
            for(NSDictionary *playerData in players){
                SPPlayer *player = [[SPPlayer alloc] initWithDictionary:playerData];
                [mplayers addObject:player];
                [player release];
            }
        }
        block(mplayers, [SPPagination paginationWithDictionary:json]);
    }]];     
}

#pragma mark -
#pragma mark shots for list

- (void)shotsForList:(NSString *)list withBlock:(void (^)(NSArray *, SPPagination *))block{
    [self shotsForList:list withBlock:block andPagination:nil];
}

- (void)shotsForList:(NSString *)list withBlock:(void (^)(NSArray *, SPPagination *))block andPagination:(NSDictionary *)pagination{
    NSString *urlString = [NSString stringWithFormat:
                           @"http://api.dribbble.com/shots/%@%@", 
                           list, [SPRequest pagination:pagination]];
    [[SPRequest operationQueue] addOperation:[NSBlockOperation blockOperationWithBlock:^{
        NSDictionary *json = [SPRequest dataFromUrl:[NSURL URLWithString:urlString]];
        NSArray *shots = [json objectForKey:@"shots"];
        NSMutableArray *mshots = [[NSMutableArray alloc] initWithCapacity:[shots count]];
        @autoreleasepool {
            for(NSDictionary *shotData in shots){
                SPShot *shot = [[SPShot alloc] initWithDictionary:shotData];
                [mshots addObject:shot];
                [shot release];
            }
        }
        block(mshots, [SPPagination paginationWithDictionary:json]);
    }]];    
}

#pragma mark -
#pragma mark shots for player

- (void)shotsForPlayer:(NSString *)player withBlock:(void (^)(NSArray *, SPPagination *))block{
    [self shotsForPlayer:player withBlock:block andPagination:nil];
}

- (void)shotsForPlayer:(NSString *)player withBlock:(void (^)(NSArray *, SPPagination *))block andPagination:(NSDictionary *)pagination{
    NSString *urlString = [NSString stringWithFormat:
                           @"http://api.dribbble.com/players/%@/shots%@", 
                           player, [SPRequest pagination:pagination]];
    [[SPRequest operationQueue] addOperation:[NSBlockOperation blockOperationWithBlock:^{
        NSDictionary *json = [SPRequest dataFromUrl:[NSURL URLWithString:urlString]];
        NSArray *shots = [json objectForKey:@"shots"];
        NSMutableArray *mshots = [[NSMutableArray alloc] initWithCapacity:[shots count]];
        @autoreleasepool {
            for(NSDictionary *shotData in shots){
                SPShot *shot = [[SPShot alloc] initWithDictionary:shotData];
                [mshots addObject:shot];
                [shot release];
            }
        }
        block(mshots, [SPPagination paginationWithDictionary:json]);
    }]];    
}

#pragma mark -
#pragma mark shots for player following

- (void)shotsForPlayerFollowing:(NSString *)player withBlock:(void (^)(NSArray *, SPPagination *))block{
    [self shotsForPlayerFollowing:player withBlock:block andPagination:nil];
}

- (void)shotsForPlayerFollowing:(NSString *)player withBlock:(void (^)(NSArray *, SPPagination *))block andPagination:(NSDictionary *)pagination{
    NSString *urlString = [NSString stringWithFormat:
                           @"http://api.dribbble.com/players/%@/shots/following%@", 
                           player, [SPRequest pagination:pagination]];
    [[SPRequest operationQueue] addOperation:[NSBlockOperation blockOperationWithBlock:^{
        NSDictionary *json = [SPRequest dataFromUrl:[NSURL URLWithString:urlString]];
        NSArray *shots = [json objectForKey:@"shots"];
        NSMutableArray *mshots = [[NSMutableArray alloc] initWithCapacity:[shots count]];
        @autoreleasepool {
            for(NSDictionary *shotData in shots){
                SPShot *shot = [[SPShot alloc] initWithDictionary:shotData];
                [mshots addObject:shot];
                [shot release];
            }
        }
        block(mshots, [SPPagination paginationWithDictionary:json]);
    }]];    
}

#pragma mark -
#pragma mark shots for player likes

- (void)shotsForPlayerLikes:(NSString *)player withBlock:(void (^)(NSArray *, SPPagination *))block{
    [self shotsForPlayerLikes:player withBlock:block andPagination:nil];
}

- (void)shotsForPlayerLikes:(NSString *)player withBlock:(void (^)(NSArray *, SPPagination *))block andPagination:(NSDictionary *)pagination{
    NSString *urlString = [NSString stringWithFormat:
                           @"http://api.dribbble.com/players/%@/shots/likes%@", 
                           player, [SPRequest pagination:pagination]];
    [[SPRequest operationQueue] addOperation:[NSBlockOperation blockOperationWithBlock:^{
        NSDictionary *json = [SPRequest dataFromUrl:[NSURL URLWithString:urlString]];
        NSArray *shots = [json objectForKey:@"shots"];
        NSMutableArray *mshots = [[NSMutableArray alloc] initWithCapacity:[shots count]];
        @autoreleasepool {
            for(NSDictionary *shotData in shots){
                SPShot *shot = [[SPShot alloc] initWithDictionary:shotData];
                [mshots addObject:shot];
                [shot release];
            }
        }
        block(mshots, [SPPagination paginationWithDictionary:json]);
    }]];    
}

#pragma mark -
#pragma mark singleton

+ (void)initialize{
    if(!sharedInstance){
        [[[self alloc] init] release];
    }
}

+ (id)sharedManager{
    return sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone{
    return [sharedInstance retain] ?: [super allocWithZone:zone];
}

- (id)init{
    if(!sharedInstance){
        self = [super init];
        sharedInstance = [self retain];
    }else if(self != sharedInstance){
        [self release];
        self = [sharedInstance retain];
    }
    
    return self;
}

@end
