//
//  SPRequest.m
//  Spectttator
//
//  Created by David Keegan on 6/25/11.
//  Copyright 2011 David Keegan.
//

#import "SPRequest.h"
#import "SPMethods.h"
#import "AFJSONRequestOperation.h"

@implementation SPRequest

#pragma mark Players
#pragma mark -

+ (void)playerInformationForUsername:(NSString *)username
                     runOnMainThread:(BOOL)runOnMainThread
                           withBlock:(void (^)(SPPlayer *player))block{
    NSString *urlString = [NSString stringWithFormat:@"http://api.dribbble.com/players/%@", username];
    [[AFJSONRequestOperation
      JSONRequestOperationWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]
      success:^(NSURLRequest *request, NSHTTPURLResponse *response, NSDictionary *json){
          SPPlayer *player = nil;
          if(![json[@"message"] isEqualToString:@"Not found"]){
              player = [[SPPlayer alloc] initWithDictionary:json];
          }
          if(runOnMainThread){
              dispatch_async(dispatch_get_main_queue(), ^{
                  block([player autorelease]);
              });
          }else{
              block([player autorelease]);
          }
      } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON){
          if(runOnMainThread){
              dispatch_async(dispatch_get_main_queue(), ^{
                  block(nil);
              });
          }else{
              block(nil);
          }         
      }] start];
}

+ (void)playerFollowers:(NSString *)username
         withPagination:(NSDictionary *)pagination
        runOnMainThread:(BOOL)runOnMainThread
              withBlock:(void (^)(NSArray *players, SPPagination *pagination))block{
    NSString *urlString = [NSString stringWithFormat:
                           @"http://api.dribbble.com/players/%@/followers%@",
                           username, [SPMethods pagination:pagination]];
    [SPMethods requestPlayersWithURL:[NSURL URLWithString:urlString]
                runOnMainThread:runOnMainThread
                      withBlock:block];
}

+ (void)playerFollowing:(NSString *)username
         withPagination:(NSDictionary *)pagination
        runOnMainThread:(BOOL)runOnMainThread
              withBlock:(void (^)(NSArray *players, SPPagination *pagination))block{
    NSString *urlString = [NSString stringWithFormat:
                           @"http://api.dribbble.com/players/%@/following%@",
                           username, [SPMethods pagination:pagination]];
    [SPMethods requestPlayersWithURL:[NSURL URLWithString:urlString]
                runOnMainThread:runOnMainThread
                      withBlock:block];
}

+ (void)playerDraftees:(NSString *)username
        withPagination:(NSDictionary *)pagination
       runOnMainThread:(BOOL)runOnMainThread
             withBlock:(void (^)(NSArray *players, SPPagination *pagination))block{
    NSString *urlString = [NSString stringWithFormat:
                           @"http://api.dribbble.com/players/%@/draftees%@",
                           username, [SPMethods pagination:pagination]];
    [SPMethods requestPlayersWithURL:[NSURL URLWithString:urlString]
                runOnMainThread:runOnMainThread
                      withBlock:block];
}

#pragma mark Shots
#pragma mark -

+ (void)shotInformationForIdentifier:(NSUInteger)identifier
                     runOnMainThread:(BOOL)runOnMainThread
                           withBlock:(void (^)(SPShot *shot))block{
    NSString *urlString = [NSString stringWithFormat:@"http://api.dribbble.com/shots/%lu", identifier];
    [[AFJSONRequestOperation
     JSONRequestOperationWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]
     success:^(NSURLRequest *request, NSHTTPURLResponse *response, NSDictionary *json){
        SPShot *shot = nil;
        if(![json[@"message"] isEqualToString:@"Not found"]){
            shot = [[SPShot alloc] initWithDictionary:json];
        }
        if(runOnMainThread){
            dispatch_async(dispatch_get_main_queue(), ^{
                block([shot autorelease]);
            });
        }else{
            block([shot autorelease]);
        }
     } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON){
         if(runOnMainThread){
             dispatch_async(dispatch_get_main_queue(), ^{
                 block(nil);
             });
         }else{
             block(nil);
         }         
     }] start];
}

+ (void)shotsForList:(NSString *)list
      withPagination:(NSDictionary *)pagination
     runOnMainThread:(BOOL)runOnMainThread
           withBlock:(void (^)(NSArray *shots, SPPagination *pagination))block{
    NSString *urlString = [NSString stringWithFormat:
                           @"http://api.dribbble.com/shots/%@%@",
                           list, [SPMethods pagination:pagination]];
    [SPMethods requestShotsWithURL:[NSURL URLWithString:urlString]
                runOnMainThread:runOnMainThread
                      withBlock:block];
}

+ (void)shotsForPlayer:(NSString *)username
        withPagination:(NSDictionary *)pagination
       runOnMainThread:(BOOL)runOnMainThread
             withBlock:(void (^)(NSArray *shots, SPPagination *pagination))block{
    NSString *urlString = [NSString stringWithFormat:
                           @"http://api.dribbble.com/players/%@/shots%@",
                           username, [SPMethods pagination:pagination]];
    [SPMethods requestShotsWithURL:[NSURL URLWithString:urlString]
              runOnMainThread:runOnMainThread
                    withBlock:block];
}

+ (void)shotsForPlayerFollowing:(NSString *)username
                 withPagination:(NSDictionary *)pagination
                runOnMainThread:(BOOL)runOnMainThread
                      withBlock:(void (^)(NSArray *shots, SPPagination *pagination))block{
    NSString *urlString = [NSString stringWithFormat:
                           @"http://api.dribbble.com/players/%@/shots/following%@",
                           username, [SPMethods pagination:pagination]];
    [SPMethods requestShotsWithURL:[NSURL URLWithString:urlString]
              runOnMainThread:runOnMainThread
                    withBlock:block];
}

+ (void)shotsForPlayerLikes:(NSString *)username
             withPagination:(NSDictionary *)pagination
            runOnMainThread:(BOOL)runOnMainThread
                  withBlock:(void (^)(NSArray *shots, SPPagination *pagination))block{
    NSString *urlString = [NSString stringWithFormat:
                           @"http://api.dribbble.com/players/%@/shots/likes%@",
                           username, [SPMethods pagination:pagination]];
    [SPMethods requestShotsWithURL:[NSURL URLWithString:urlString]
              runOnMainThread:runOnMainThread
                    withBlock:block];
}

@end
