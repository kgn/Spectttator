//
//  SPRequest.m
//  Spectttator
//
//  Created by David Keegan on 6/27/11.
//  Copyright 2011 David Keegan.
//

#import "SPRequest.h"

#import "SPPlayer.h"
#import "SPComment.h"
#import "SPShot.h"

@implementation SPRequest

+ (SBJsonParser *)parser{
    static SBJsonParser *kParser = nil;
    if(kParser == nil){
        kParser = [[SBJsonParser alloc] init];
    }
    return kParser;
}

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
    [[SPRequest operationQueue] addOperation:[NSBlockOperation blockOperationWithBlock:^{
        NSDictionary *json = [SPRequest dataFromUrl:url];
        NSArray *players = [json objectForKey:@"players"];
        NSMutableArray *mplayers = [[NSMutableArray alloc] initWithCapacity:[players count]];
        NSAutoreleasePool *pool =  [[NSAutoreleasePool alloc] init];
        for(NSDictionary *playerData in players){
            SPPlayer *player = [[SPPlayer alloc] initWithDictionary:playerData];
            [mplayers addObject:player];
            [player release];
        }
        [pool drain];
        if(runOnMainThread){
            dispatch_async(dispatch_get_main_queue(), ^{
                block(mplayers, [SPPagination paginationWithDictionary:json]);
            });
        }else{
            block(mplayers, [SPPagination paginationWithDictionary:json]);
        }  
        [mplayers release];
    }]];
}

+ (void)requestShotsWithURL:(NSURL *)url 
            runOnMainThread:(BOOL)runOnMainThread 
                  withBlock:(void (^)(NSArray *, SPPagination *))block{
    [[SPRequest operationQueue] addOperation:[NSBlockOperation blockOperationWithBlock:^{
        NSDictionary *json = [SPRequest dataFromUrl:url];
        NSArray *shots = [json objectForKey:@"shots"];
        NSMutableArray *mshots = [[NSMutableArray alloc] initWithCapacity:[shots count]];
        NSAutoreleasePool *pool =  [[NSAutoreleasePool alloc] init];
        for(NSDictionary *shotData in shots){
            SPShot *shot = [[SPShot alloc] initWithDictionary:shotData];
            [mshots addObject:shot];
            [shot release];
        }
        [pool drain];
        if(runOnMainThread){
            dispatch_async(dispatch_get_main_queue(), ^{
                block(mshots, [SPPagination paginationWithDictionary:json]);
            });            
        }else{
            block(mshots, [SPPagination paginationWithDictionary:json]);
        }
        [mshots release];
    }]]; 
}

+ (void)requestCommentsWithURL:(NSURL *)url 
            runOnMainThread:(BOOL)runOnMainThread 
                  withBlock:(void (^)(NSArray *, SPPagination *))block{
    [[SPRequest operationQueue] addOperation:[NSBlockOperation blockOperationWithBlock:^{
        NSDictionary *json = [SPRequest dataFromUrl:url];
        NSArray *comments = [json objectForKey:@"comments"];
        NSMutableArray *mcomments = [[NSMutableArray alloc] initWithCapacity:[comments count]];
        NSAutoreleasePool *pool =  [[NSAutoreleasePool alloc] init];
        for(NSDictionary *commentData in comments){
            SPComment *comment = [[SPComment alloc] initWithDictionary:commentData];
            [mcomments addObject:comment];
            [comment release];
        }
        [pool drain];
        if(runOnMainThread){
            dispatch_async(dispatch_get_main_queue(), ^{
                block(mcomments, [SPPagination paginationWithDictionary:json]);
            });            
        }else{
            block(mcomments, [SPPagination paginationWithDictionary:json]);
        }
        [mcomments release];
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
    [[SPRequest operationQueue] addOperation:[NSBlockOperation blockOperationWithBlock:^{
        #if TARGET_OS_IPHONE
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
        #else
        NSImage *image = [[[NSImage alloc] initWithContentsOfURL:url] autorelease];
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

+ (id)dataFromUrl:(NSURL *)url{
    NSURLRequest *request = [NSURLRequest requestWithURL:url
                                             cachePolicy:NSURLRequestReloadIgnoringCacheData
                                         timeoutInterval:20.0f];
    NSError *error;
    NSURLResponse *response;
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    
    return [NSJSONSerialization JSONObjectWithData:data 
                                           options:NSJSONReadingMutableContainers 
                                             error:&error];
}

@end
