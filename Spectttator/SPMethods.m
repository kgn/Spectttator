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

@implementation SPMethods

+ (NSOperationQueue *)operationQueue{
    static NSOperationQueue *kQueue = nil;
    if(kQueue == nil){
        kQueue = [[NSOperationQueue alloc] init];
        [kQueue setMaxConcurrentOperationCount:
         NSOperationQueueDefaultMaxConcurrentOperationCount];
    }
    return kQueue;    
}

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
                    withBlock:(void (^)(NSArray *, SPPagination *))block{
    [[SPMethods operationQueue] addOperation:[NSBlockOperation blockOperationWithBlock:^{
        NSDictionary *json = [SPMethods jsonDataFromUrl:url];
        NSArray *players = [json objectForKey:@"players"];
        NSMutableArray *mplayers = [[NSMutableArray alloc] initWithCapacity:[players count]];
        @autoreleasepool {
            for(NSDictionary *playerData in players){
                [mplayers addObject:[[SPPlayer alloc] initWithDictionary:playerData]];
            }
        }
        if(runOnMainThread){
            dispatch_async(dispatch_get_main_queue(), ^{
                block(mplayers, [SPPagination paginationWithDictionary:json]);
            });
        }else{
            block(mplayers, [SPPagination paginationWithDictionary:json]);
        }  
    }]];
}

+ (void)requestShotsWithURL:(NSURL *)url 
            runOnMainThread:(BOOL)runOnMainThread 
                  withBlock:(void (^)(NSArray *, SPPagination *))block{
    [[SPMethods operationQueue] addOperation:[NSBlockOperation blockOperationWithBlock:^{
        NSDictionary *json = [SPMethods jsonDataFromUrl:url];
        NSArray *shots = [json objectForKey:@"shots"];
        NSMutableArray *mshots = [[NSMutableArray alloc] initWithCapacity:[shots count]];
        @autoreleasepool {
            for(NSDictionary *shotData in shots){
                [mshots addObject:[[SPShot alloc] initWithDictionary:shotData]];
            }
        }
        if(runOnMainThread){
            dispatch_async(dispatch_get_main_queue(), ^{
                block(mshots, [SPPagination paginationWithDictionary:json]);
            });            
        }else{
            block(mshots, [SPPagination paginationWithDictionary:json]);
        }
    }]]; 
}

+ (void)requestCommentsWithURL:(NSURL *)url 
               runOnMainThread:(BOOL)runOnMainThread 
                     withBlock:(void (^)(NSArray *, SPPagination *))block{
    [[SPMethods operationQueue] addOperation:[NSBlockOperation blockOperationWithBlock:^{
        NSDictionary *json = [SPMethods jsonDataFromUrl:url];
        NSArray *comments = [json objectForKey:@"comments"];
        NSMutableArray *mcomments = [[NSMutableArray alloc] initWithCapacity:[comments count]];
        @autoreleasepool {
            for(NSDictionary *commentData in comments){
                [mcomments addObject:[[SPComment alloc] initWithDictionary:commentData]];
            }
        }
        if(runOnMainThread){
            dispatch_async(dispatch_get_main_queue(), ^{
                block(mcomments, [SPPagination paginationWithDictionary:json]);
            });            
        }else{
            block(mcomments, [SPPagination paginationWithDictionary:json]);
        }
    }]];
}

+ (void)requestImageWithURL:(NSURL *)url 
            runOnMainThread:(BOOL)runOnMainThread 
                  withBlock:(void (^)(
#if TARGET_OS_IPHONE
                                      UIImage *
#else
                                      NSImage *
#endif
                                      ))block{
    [[SPMethods operationQueue] addOperation:[NSBlockOperation blockOperationWithBlock:^{
#if TARGET_OS_IPHONE
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
#else
        NSImage *image = [[NSImage alloc] initWithContentsOfURL:url];
#endif
        
        if(runOnMainThread){
            dispatch_async(dispatch_get_main_queue(), ^{
                block(image);
            });
        }else{
            block(image);
        }
    }]];
}

+ (NSData *)dataFromUrl:(NSURL *)url{
    NSURLRequest *request = [NSURLRequest requestWithURL:url
                                             cachePolicy:NSURLRequestReloadIgnoringCacheData
                                         timeoutInterval:20.0f];
    NSError *error;
    NSURLResponse *response;
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    return data;
}

+ (id)jsonDataFromUrl:(NSURL *)url{
    NSError *error;
    NSData *data = [self dataFromUrl:url];
    if(data){
        return [NSJSONSerialization JSONObjectWithData:data 
                                               options:NSJSONReadingMutableContainers 
                                                 error:&error];
    }
    return nil;
}

@end
