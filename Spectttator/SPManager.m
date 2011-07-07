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
#pragma mark Players
#pragma mark -

- (void)playerInformationForUsername:(NSString *)username 
                     runOnMainThread:(BOOL)runOnMainThread 
                           withBlock:(void (^)(SPPlayer *))block{
    NSString *urlString = [NSString stringWithFormat:@"http://api.dribbble.com/players/%@", username];
    [[SPRequest operationQueue] addOperation:[NSBlockOperation blockOperationWithBlock:^{
        NSDictionary *json = [SPRequest dataFromUrl:[NSURL URLWithString:urlString]];
        if(runOnMainThread){
            dispatch_async(dispatch_get_main_queue(), ^{
                block([[[SPPlayer alloc] initWithDictionary:json] autorelease]);
            });
        }else{
            block([[[SPPlayer alloc] initWithDictionary:json] autorelease]);
        }        
    }]];
}

#pragma mark followers

- (void)playerFollowers:(NSString *)username 
        runOnMainThread:(BOOL)runOnMainThread 
              withBlock:(void (^)(NSArray *, SPPagination *))block{
    [self playerFollowers:username 
          runOnMainThread:runOnMainThread 
                withBlock:block 
            andPagination:nil];
}

- (void)playerFollowers:(NSString *)username 
        runOnMainThread:(BOOL)runOnMainThread 
              withBlock:(void (^)(NSArray *, SPPagination *))block 
          andPagination:(NSDictionary *)pagination{
    NSString *urlString = [NSString stringWithFormat:
                           @"http://api.dribbble.com/players/%@/followers%@", 
                           username, [SPRequest pagination:pagination]];
    [SPRequest requestPlayersWithURL:[NSURL URLWithString:urlString] 
                runOnMainThread:runOnMainThread 
                      withBlock:block];
}
 
#pragma mark following

- (void)playerFollowing:(NSString *)username 
        runOnMainThread:(BOOL)runOnMainThread
              withBlock:(void (^)(NSArray *, SPPagination *))block{
    [self playerFollowing:username 
          runOnMainThread:(BOOL)runOnMainThread
                withBlock:block 
            andPagination:nil];
}

- (void)playerFollowing:(NSString *)username 
        runOnMainThread:(BOOL)runOnMainThread
              withBlock:(void (^)(NSArray *, SPPagination *))block 
          andPagination:(NSDictionary *)pagination{
    NSString *urlString = [NSString stringWithFormat:
                           @"http://api.dribbble.com/players/%@/following%@", 
                           username, [SPRequest pagination:pagination]];
    [SPRequest requestPlayersWithURL:[NSURL URLWithString:urlString] 
                runOnMainThread:runOnMainThread 
                      withBlock:block];    
}

#pragma mark draftees

- (void)playerDraftees:(NSString *)username 
       runOnMainThread:(BOOL)runOnMainThread 
             withBlock:(void (^)(NSArray *, SPPagination *))block{
    [self playerDraftees:username 
         runOnMainThread:runOnMainThread
               withBlock:block 
           andPagination:nil];
}

- (void)playerDraftees:(NSString *)username 
       runOnMainThread:(BOOL)runOnMainThread 
             withBlock:(void (^)(NSArray *, SPPagination *))block 
         andPagination:(NSDictionary *)pagination{
    NSString *urlString = [NSString stringWithFormat:
                           @"http://api.dribbble.com/players/%@/draftees%@", 
                           username, [SPRequest pagination:pagination]];
    [SPRequest requestPlayersWithURL:[NSURL URLWithString:urlString] 
                runOnMainThread:runOnMainThread 
                      withBlock:block];
}

#pragma mark -
#pragma mark Shots
#pragma mark -

- (void)shotInformationForIdentifier:(NSUInteger)identifier 
                     runOnMainThread:(BOOL)runOnMainThread 
                           withBlock:(void (^)(SPShot *))block{
    NSString *urlString = [NSString stringWithFormat:@"http://api.dribbble.com/shots/%lu", identifier];
    [[SPRequest operationQueue] addOperation:[NSBlockOperation blockOperationWithBlock:^{
        NSDictionary *json = [SPRequest dataFromUrl:[NSURL URLWithString:urlString]];
        if(runOnMainThread){
            dispatch_async(dispatch_get_main_queue(), ^{
                block([[[SPShot alloc] initWithDictionary:json] autorelease]);
            });
        }else{
            block([[[SPShot alloc] initWithDictionary:json] autorelease]);
        }
    }]];     
}

#pragma mark for list...

- (void)shotsForList:(NSString *)list 
     runOnMainThread:(BOOL)runOnMainThread 
           withBlock:(void (^)(NSArray *, SPPagination *))block{
    [self shotsForList:list 
       runOnMainThread:runOnMainThread 
             withBlock:block 
         andPagination:nil];
}

- (void)shotsForList:(NSString *)list 
     runOnMainThread:(BOOL)runOnMainThread 
           withBlock:(void (^)(NSArray *, SPPagination *))block 
       andPagination:(NSDictionary *)pagination{
    NSString *urlString = [NSString stringWithFormat:
                           @"http://api.dribbble.com/shots/%@%@", 
                           list, [SPRequest pagination:pagination]];
    [SPRequest requestShotsWithURL:[NSURL URLWithString:urlString] 
                runOnMainThread:runOnMainThread 
                      withBlock:block];  
}

#pragma mark for player...

- (void)shotsForPlayer:(NSString *)username 
       runOnMainThread:(BOOL)runOnMainThread 
             withBlock:(void (^)(NSArray *, SPPagination *))block{
    [self shotsForPlayer:username 
         runOnMainThread:runOnMainThread
               withBlock:block 
           andPagination:nil];
}

- (void)shotsForPlayer:(NSString *)username 
       runOnMainThread:(BOOL)runOnMainThread 
             withBlock:(void (^)(NSArray *, SPPagination *))block 
         andPagination:(NSDictionary *)pagination{
    NSString *urlString = [NSString stringWithFormat:
                           @"http://api.dribbble.com/players/%@/shots%@", 
                           username, [SPRequest pagination:pagination]];
    [SPRequest requestShotsWithURL:[NSURL URLWithString:urlString] 
              runOnMainThread:runOnMainThread 
                    withBlock:block];
}

#pragma mark -
#pragma mark for player following...

- (void)shotsForPlayerFollowing:(NSString *)username 
                runOnMainThread:(BOOL)runOnMainThread
                      withBlock:(void (^)(NSArray *, SPPagination *))block{
    [self shotsForPlayerFollowing:username 
                  runOnMainThread:runOnMainThread
                        withBlock:block 
                    andPagination:nil];
}

- (void)shotsForPlayerFollowing:(NSString *)username 
                runOnMainThread:(BOOL)runOnMainThread
                      withBlock:(void (^)(NSArray *, SPPagination *))block 
                  andPagination:(NSDictionary *)pagination{
    NSString *urlString = [NSString stringWithFormat:
                           @"http://api.dribbble.com/players/%@/shots/following%@", 
                           username, [SPRequest pagination:pagination]];
    [SPRequest requestShotsWithURL:[NSURL URLWithString:urlString] 
              runOnMainThread:runOnMainThread 
                    withBlock:block];
}

#pragma mark -
#pragma mark for player likes...

- (void)shotsForPlayerLikes:(NSString *)username 
            runOnMainThread:(BOOL)runOnMainThread
                  withBlock:(void (^)(NSArray *, SPPagination *))block{
    [self shotsForPlayerLikes:username 
              runOnMainThread:runOnMainThread
                    withBlock:block 
                andPagination:nil];
}

- (void)shotsForPlayerLikes:(NSString *)username 
            runOnMainThread:(BOOL)runOnMainThread
                  withBlock:(void (^)(NSArray *, SPPagination *))block 
              andPagination:(NSDictionary *)pagination{
    NSString *urlString = [NSString stringWithFormat:
                           @"http://api.dribbble.com/players/%@/shots/likes%@", 
                           username, [SPRequest pagination:pagination]];
    [SPRequest requestShotsWithURL:[NSURL URLWithString:urlString] 
              runOnMainThread:runOnMainThread 
                    withBlock:block];   
}

#pragma mark -
#pragma mark Singleton
#pragma mark -

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
