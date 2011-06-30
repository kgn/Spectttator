//
//  SPRequest.m
//  Spectttator
//
//  Created by David Keegan on 6/27/11.
//  Copyright 2011 David Keegan.
//

#import "SPRequest.h"

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

+ (id)dataFromUrl:(NSURL *)url{
    NSURLRequest *request = [NSURLRequest requestWithURL:url
                                             cachePolicy:NSURLRequestReloadIgnoringCacheData
                                         timeoutInterval:20.0f];
    NSError *error;
    NSURLResponse *response;
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    
    return [[self parser] objectWithData:data];
}

@end
