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

- (void)playerFollowers:(NSString *)username 
         withPagination:(NSDictionary *)pagination
        runOnMainThread:(BOOL)runOnMainThread 
              withBlock:(void (^)(NSArray *, SPPagination *))block{
    NSString *urlString = [NSString stringWithFormat:
                           @"http://api.dribbble.com/players/%@/followers%@", 
                           username, [SPRequest pagination:pagination]];
    [SPRequest requestPlayersWithURL:[NSURL URLWithString:urlString] 
                runOnMainThread:runOnMainThread 
                      withBlock:block];
}

- (void)playerFollowing:(NSString *)username 
         withPagination:(NSDictionary *)pagination
        runOnMainThread:(BOOL)runOnMainThread
              withBlock:(void (^)(NSArray *, SPPagination *))block{
    NSString *urlString = [NSString stringWithFormat:
                           @"http://api.dribbble.com/players/%@/following%@", 
                           username, [SPRequest pagination:pagination]];
    [SPRequest requestPlayersWithURL:[NSURL URLWithString:urlString] 
                runOnMainThread:runOnMainThread 
                      withBlock:block];    
}

- (void)playerDraftees:(NSString *)username 
        withPagination:(NSDictionary *)pagination
       runOnMainThread:(BOOL)runOnMainThread 
             withBlock:(void (^)(NSArray *, SPPagination *))block{
    NSString *urlString = [NSString stringWithFormat:
                           @"http://api.dribbble.com/players/%@/draftees%@", 
                           username, [SPRequest pagination:pagination]];
    [SPRequest requestPlayersWithURL:[NSURL URLWithString:urlString] 
                runOnMainThread:runOnMainThread 
                      withBlock:block];
}

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

- (void)shotsForList:(NSString *)list 
      withPagination:(NSDictionary *)pagination
     runOnMainThread:(BOOL)runOnMainThread 
           withBlock:(void (^)(NSArray *, SPPagination *))block{
    NSString *urlString = [NSString stringWithFormat:
                           @"http://api.dribbble.com/shots/%@%@", 
                           list, [SPRequest pagination:pagination]];
    [SPRequest requestShotsWithURL:[NSURL URLWithString:urlString] 
                runOnMainThread:runOnMainThread 
                      withBlock:block];  
}

- (void)shotsForPlayer:(NSString *)username 
        withPagination:(NSDictionary *)pagination
       runOnMainThread:(BOOL)runOnMainThread 
             withBlock:(void (^)(NSArray *, SPPagination *))block{
    NSString *urlString = [NSString stringWithFormat:
                           @"http://api.dribbble.com/players/%@/shots%@", 
                           username, [SPRequest pagination:pagination]];
    [SPRequest requestShotsWithURL:[NSURL URLWithString:urlString] 
              runOnMainThread:runOnMainThread 
                    withBlock:block];
}

- (void)shotsForPlayerFollowing:(NSString *)username 
                 withPagination:(NSDictionary *)pagination
                runOnMainThread:(BOOL)runOnMainThread
                      withBlock:(void (^)(NSArray *, SPPagination *))block{
    NSString *urlString = [NSString stringWithFormat:
                           @"http://api.dribbble.com/players/%@/shots/following%@", 
                           username, [SPRequest pagination:pagination]];
    [SPRequest requestShotsWithURL:[NSURL URLWithString:urlString] 
              runOnMainThread:runOnMainThread 
                    withBlock:block];
}

- (void)shotsForPlayerLikes:(NSString *)username 
             withPagination:(NSDictionary *)pagination
            runOnMainThread:(BOOL)runOnMainThread
                  withBlock:(void (^)(NSArray *, SPPagination *))block{
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
