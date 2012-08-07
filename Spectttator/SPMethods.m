//
//  SPMethods.m
//  Spectttator
//
//  Created by David Keegan on 6/27/11.
//  Copyright 2011 David Keegan.
//

#import "SPMethods.h"

#import "SPPlayer.h"
#import "SPComment.h"
#import "SPShot.h"
#import "AFJSONRequestOperation.h"
#import "AFImageRequestOperation.h"
#import "AFHTTPRequestOperation.h"

@implementation NSDictionary(Spectttator)

- (NSUInteger)uintSafelyFromKey:(id)key{
    if([self objectForKey:key] == [NSNull null] || [self objectForKey:key] == nil){
        return NSNotFound;
    }
    return [[self objectForKey:key] integerValue];
}

- (NSString *)stringSafelyFromKey:(id)key{
    if([self objectForKey:key] == [NSNull null] || [self objectForKey:key] == nil){
        return nil;
    }
    return [NSString stringWithString:[self objectForKey:key]];
}

- (NSURL *)URLSafelyFromKey:(id)key{
    if([self objectForKey:key] == [NSNull null] || [self objectForKey:key] == nil){
        return nil;
    }
    NSString *urlString = 
    [[self objectForKey:key] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];      
    return [NSURL URLWithString:urlString];  
}

- (id)objectSafelyFromKey:(id)key{
    if([self objectForKey:key] == [NSNull null] || [self objectForKey:key] == nil){
        return nil;
    }    
    return [self objectForKey:key];  
}

@end

@implementation SPMethods

+ (NSString *)pagination:(NSDictionary *)pagination{
    NSNumber *page = [pagination objectForKey:@"page"];
    NSNumber *perPage = [pagination objectForKey:@"perPage"];
    if(page && perPage){
        return [NSString stringWithFormat:@"?page=%lu&per_page=%lu", [page longValue], [perPage longValue]];
    }else if(page){
        return [NSString stringWithFormat:@"?page=%lu", [page longValue]];
    }else if(perPage){
        return [NSString stringWithFormat:@"?per_page=%lu", [perPage longValue]];
    }
    return @"";
}

+ (void)requestPlayersWithURL:(NSURL *)url
              runOnMainThread:(BOOL)runOnMainThread
                    withBlock:(void (^)(NSArray *players, SPPagination *pagination))block{
    [[AFJSONRequestOperation
      JSONRequestOperationWithRequest:[NSURLRequest requestWithURL:url]
      success:^(NSURLRequest *request, NSHTTPURLResponse *response, NSDictionary *json){
          NSArray *players = [json objectForKey:@"players"];
          NSMutableArray *mplayers = [[NSMutableArray alloc] initWithCapacity:[players count]];
          for(NSDictionary *playerData in players){
              @autoreleasepool{
                  SPPlayer *player = [[SPPlayer alloc] initWithDictionary:playerData];
                  [mplayers addObject:player];
                  [player release];
              }
          }
          if([mplayers count] == 0){
              [mplayers release];
              mplayers = nil;
          }
          if(runOnMainThread){
              dispatch_async(dispatch_get_main_queue(), ^{
                  block(mplayers, [SPPagination paginationWithDictionary:json]);
              });
          }else{
              block(mplayers, [SPPagination paginationWithDictionary:json]);
          }
          if(mplayers != nil){
              [mplayers release];
          }
      } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON){
          if(runOnMainThread){
              dispatch_async(dispatch_get_main_queue(), ^{
                  block(nil, nil);
              });
          }else{
              block(nil, nil);
          }         
      }] start];
}

+ (void)requestShotsWithURL:(NSURL *)url
            runOnMainThread:(BOOL)runOnMainThread
                  withBlock:(void (^)(NSArray *shots, SPPagination *pagination))block{
    [[AFJSONRequestOperation
      JSONRequestOperationWithRequest:[NSURLRequest requestWithURL:url] 
      success:^(NSURLRequest *request, NSHTTPURLResponse *response, NSDictionary *json){
          NSArray *shots = [json objectForKey:@"shots"];
          NSMutableArray *mshots = [[NSMutableArray alloc] initWithCapacity:[shots count]];
          for(NSDictionary *shotData in shots){
              @autoreleasepool{
                  SPShot *shot = [[SPShot alloc] initWithDictionary:shotData];
                  [mshots addObject:shot];
                  [shot release];
              }
          }
          if([mshots count] == 0){
              [mshots release];            
              mshots = nil;
          }
          if(runOnMainThread){
              dispatch_async(dispatch_get_main_queue(), ^{
                  block(mshots, [SPPagination paginationWithDictionary:json]);
              });
          }else{
              block(mshots, [SPPagination paginationWithDictionary:json]);
          }
          if(mshots != nil){
              [mshots release];
          } 
      } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON){
          if(runOnMainThread){
              dispatch_async(dispatch_get_main_queue(), ^{
                  block(nil, nil);
              });
          }else{
              block(nil, nil);
          }         
      }] start];
}

+ (void)requestCommentsWithURL:(NSURL *)url
            runOnMainThread:(BOOL)runOnMainThread
                  withBlock:(void (^)(NSArray *comments, SPPagination *pagination))block{
    [[AFJSONRequestOperation
      JSONRequestOperationWithRequest:[NSURLRequest requestWithURL:url] 
      success:^(NSURLRequest *request, NSHTTPURLResponse *response, NSDictionary *json){
          NSArray *comments = [json objectForKey:@"comments"];
          NSMutableArray *mcomments = [[NSMutableArray alloc] initWithCapacity:[comments count]];
          for(NSDictionary *commentData in comments){
              @autoreleasepool{
                  SPComment *comment = [[SPComment alloc] initWithDictionary:commentData];
                  [mcomments addObject:comment];
                  [comment release];
              }
          }
          if([mcomments count] == 0){
              [mcomments release];
              mcomments = nil;
          }
          if(runOnMainThread){
              dispatch_async(dispatch_get_main_queue(), ^{
                  block(mcomments, [SPPagination paginationWithDictionary:json]);
              });
          }else{
              block(mcomments, [SPPagination paginationWithDictionary:json]);
          }
          if(mcomments != nil){
              [mcomments release];
          }
      } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON){
          if(runOnMainThread){
              dispatch_async(dispatch_get_main_queue(), ^{
                  block(nil, nil);
              });
          }else{
              block(nil, nil);
          }         
      }] start];
}

+ (void)requestImageWithURL:(NSURL *)url
            runOnMainThread:(BOOL)runOnMainThread
                  withBlock:(void (^)(SPImage *image))block{
    [[AFImageRequestOperation 
      imageRequestOperationWithRequest:[NSURLRequest requestWithURL:url]
      imageProcessingBlock:nil
      success:^(NSURLRequest *request, NSHTTPURLResponse *response, SPImage *image){
          if(runOnMainThread){
              dispatch_async(dispatch_get_main_queue(), ^{
                  block(image);
              });
          }else{
              block(image);
          }
      } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
          if(runOnMainThread){
              dispatch_async(dispatch_get_main_queue(), ^{
                  block(nil);
              });
          }else{
              block(nil);
          }
      }] start];
}

+ (void)requestDataWithURL:(NSURL *)url
            runOnMainThread:(BOOL)runOnMainThread
                  withBlock:(void (^)(NSData *data))block{
    AFHTTPRequestOperation *operation = 
    [[[AFHTTPRequestOperation alloc] initWithRequest:[NSURLRequest requestWithURL:url]] autorelease];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject){
        if(runOnMainThread){
            dispatch_async(dispatch_get_main_queue(), ^{
                block(operation.responseData);
            });
        }else{
            block(operation.responseData);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        if(runOnMainThread){
            dispatch_async(dispatch_get_main_queue(), ^{
                block(nil);
            });
        }else{
            block(nil);
        }
    }];
    [operation start];
}

@end
