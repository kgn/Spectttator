//
//  SPManager.m
//  Spectttator
//
//  Created by David Keegan on 6/25/11.
//  Copyright 2011 David Keegan.
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

- (void)playerInformationForUsername:(NSString *)username withBlock:(void (^)(SPPlayer *))block{
    NSString *urlString = [NSString stringWithFormat:@"http://api.dribbble.com/players/%@", username];
    [[SPRequest operationQueue] addOperation:[NSBlockOperation blockOperationWithBlock:^{
        NSDictionary *json = [SPRequest dataFromUrl:[NSURL URLWithString:urlString]];
        block([[[SPPlayer alloc] initWithDictionary:json] autorelease]);
    }]];     
}

#pragma mark -
#pragma mark player followers

- (void)playerFollowers:(NSString *)username withBlock:(void (^)(NSArray *, SPPagination *))block{
    [self playerFollowers:username withBlock:block andPagination:nil];
}

- (void)playerFollowers:(NSString *)username withBlock:(void (^)(NSArray *, SPPagination *))block andPagination:(NSDictionary *)pagination{
    NSString *urlString = [NSString stringWithFormat:
                           @"http://api.dribbble.com/players/%@/followers%@", 
                           username, [SPRequest pagination:pagination]];
    [[SPRequest operationQueue] addOperation:[NSBlockOperation blockOperationWithBlock:^{
        NSDictionary *json = [SPRequest dataFromUrl:[NSURL URLWithString:urlString]];
        NSArray *players = [json objectForKey:@"players"];
        NSMutableArray *mplayers = [[NSMutableArray alloc] initWithCapacity:[players count]];
        NSAutoreleasePool *pool =  [[NSAutoreleasePool alloc] init];
            for(NSDictionary *playerData in players){
                SPPlayer *player = [[SPPlayer alloc] initWithDictionary:playerData];
                [mplayers addObject:player];
                [player release];
            }
        [pool drain];
        block(mplayers, [SPPagination paginationWithDictionary:json]);
    }]];     
}

#pragma mark -
#pragma mark player following

- (void)playerFollowing:(NSString *)username withBlock:(void (^)(NSArray *, SPPagination *))block{
    [self playerFollowing:username withBlock:block andPagination:nil];
}

- (void)playerFollowing:(NSString *)username withBlock:(void (^)(NSArray *, SPPagination *))block andPagination:(NSDictionary *)pagination{
    NSString *urlString = [NSString stringWithFormat:
                           @"http://api.dribbble.com/players/%@/following%@", 
                           username, [SPRequest pagination:pagination]];
    [[SPRequest operationQueue] addOperation:[NSBlockOperation blockOperationWithBlock:^{
        NSDictionary *json = [SPRequest dataFromUrl:[NSURL URLWithString:urlString]];
        NSArray *players = [json objectForKey:@"players"];
        NSMutableArray *mplayers = [[NSMutableArray alloc] initWithCapacity:[players count]];
        NSAutoreleasePool *pool =  [[NSAutoreleasePool alloc] init];
            for(NSDictionary *playerData in players){
                SPPlayer *player = [[SPPlayer alloc] initWithDictionary:playerData];
                [mplayers addObject:player];
                [player release];
            }
        [pool drain];
        block(mplayers, [SPPagination paginationWithDictionary:json]);
    }]];     
}

#pragma mark -
#pragma mark player draftees

- (void)playerDraftees:(NSString *)username withBlock:(void (^)(NSArray *, SPPagination *))block{
    [self playerDraftees:username withBlock:block andPagination:nil];
}

- (void)playerDraftees:(NSString *)username withBlock:(void (^)(NSArray *, SPPagination *))block andPagination:(NSDictionary *)pagination{
    NSString *urlString = [NSString stringWithFormat:
                           @"http://api.dribbble.com/players/%@/draftees%@", 
                           username, [SPRequest pagination:pagination]];
    [[SPRequest operationQueue] addOperation:[NSBlockOperation blockOperationWithBlock:^{
        NSDictionary *json = [SPRequest dataFromUrl:[NSURL URLWithString:urlString]];
        NSArray *players = [json objectForKey:@"players"];
        NSMutableArray *mplayers = [[NSMutableArray alloc] initWithCapacity:[players count]];
        NSAutoreleasePool *pool =  [[NSAutoreleasePool alloc] init];
            for(NSDictionary *playerData in players){
                SPPlayer *player = [[SPPlayer alloc] initWithDictionary:playerData];
                [mplayers addObject:player];
                [player release];
            }
        [pool drain];
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
        NSAutoreleasePool *pool =  [[NSAutoreleasePool alloc] init];
            for(NSDictionary *shotData in shots){
                SPShot *shot = [[SPShot alloc] initWithDictionary:shotData];
                [mshots addObject:shot];
                [shot release];
            }
        [pool drain];
        block(mshots, [SPPagination paginationWithDictionary:json]);
    }]];    
}

#pragma mark -
#pragma mark shots for player

- (void)shotsForPlayer:(NSString *)username withBlock:(void (^)(NSArray *, SPPagination *))block{
    [self shotsForPlayer:username withBlock:block andPagination:nil];
}

- (void)shotsForPlayer:(NSString *)username withBlock:(void (^)(NSArray *, SPPagination *))block andPagination:(NSDictionary *)pagination{
    NSString *urlString = [NSString stringWithFormat:
                           @"http://api.dribbble.com/players/%@/shots%@", 
                           username, [SPRequest pagination:pagination]];
    [[SPRequest operationQueue] addOperation:[NSBlockOperation blockOperationWithBlock:^{
        NSDictionary *json = [SPRequest dataFromUrl:[NSURL URLWithString:urlString]];
        NSArray *shots = [json objectForKey:@"shots"];
        NSMutableArray *mshots = [[NSMutableArray alloc] initWithCapacity:[shots count]];
        NSAutoreleasePool *pool =  [[NSAutoreleasePool alloc] init];
            for(NSDictionary *shotData in shots){
                SPShot *shot = [[SPShot alloc] initWithDictionary:shotData];
                [mshots addObject:shot];
                [shot release];
            }
        [pool drain];
        block(mshots, [SPPagination paginationWithDictionary:json]);
    }]];    
}

#pragma mark -
#pragma mark shots for player following

- (void)shotsForPlayerFollowing:(NSString *)username withBlock:(void (^)(NSArray *, SPPagination *))block{
    [self shotsForPlayerFollowing:username withBlock:block andPagination:nil];
}

- (void)shotsForPlayerFollowing:(NSString *)username withBlock:(void (^)(NSArray *, SPPagination *))block andPagination:(NSDictionary *)pagination{
    NSString *urlString = [NSString stringWithFormat:
                           @"http://api.dribbble.com/players/%@/shots/following%@", 
                           username, [SPRequest pagination:pagination]];
    [[SPRequest operationQueue] addOperation:[NSBlockOperation blockOperationWithBlock:^{
        NSDictionary *json = [SPRequest dataFromUrl:[NSURL URLWithString:urlString]];
        NSArray *shots = [json objectForKey:@"shots"];
        NSMutableArray *mshots = [[NSMutableArray alloc] initWithCapacity:[shots count]];
        NSAutoreleasePool *pool =  [[NSAutoreleasePool alloc] init];
            for(NSDictionary *shotData in shots){
                SPShot *shot = [[SPShot alloc] initWithDictionary:shotData];
                [mshots addObject:shot];
                [shot release];
            }
        [pool drain];
        block(mshots, [SPPagination paginationWithDictionary:json]);
    }]];    
}

#pragma mark -
#pragma mark shots for player likes

- (void)shotsForPlayerLikes:(NSString *)username withBlock:(void (^)(NSArray *, SPPagination *))block{
    [self shotsForPlayerLikes:username withBlock:block andPagination:nil];
}

- (void)shotsForPlayerLikes:(NSString *)username withBlock:(void (^)(NSArray *, SPPagination *))block andPagination:(NSDictionary *)pagination{
    NSString *urlString = [NSString stringWithFormat:
                           @"http://api.dribbble.com/players/%@/shots/likes%@", 
                           username, [SPRequest pagination:pagination]];
    [[SPRequest operationQueue] addOperation:[NSBlockOperation blockOperationWithBlock:^{
        NSDictionary *json = [SPRequest dataFromUrl:[NSURL URLWithString:urlString]];
        NSArray *shots = [json objectForKey:@"shots"];
        NSMutableArray *mshots = [[NSMutableArray alloc] initWithCapacity:[shots count]];
        NSAutoreleasePool *pool =  [[NSAutoreleasePool alloc] init];
            for(NSDictionary *shotData in shots){
                SPShot *shot = [[SPShot alloc] initWithDictionary:shotData];
                [mshots addObject:shot];
                [shot release];
            }
        [pool drain];
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
