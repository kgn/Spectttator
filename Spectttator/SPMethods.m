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

@implementation NSDictionary(Spectttator)

- (NSUInteger)uintSafelyFromKey:(id)key{
    if([self objectForKey:key] != [NSNull null] && [self objectForKey:key] != nil){
        return [[self objectForKey:key] intValue];
    }
    return NSNotFound;    
}

- (NSString *)stringSafelyFromKey:(id)key{
    if([self objectForKey:key] != [NSNull null] && [self objectForKey:key] != nil){
        return [NSString stringWithString:[self objectForKey:key]];
    }
    return nil;         
}

- (NSURL *)URLSafelyFromKey:(id)key{
    if([self objectForKey:key] != [NSNull null] && [self objectForKey:key] != nil){
        NSString *urlString = [[self objectForKey:key] 
                               stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];      
        return [NSURL URLWithString:urlString];
    }
    return nil;    
}

- (id)objectSafelyFromKey:(id)key{
    if([self objectForKey:key] != [NSNull null] && [self objectForKey:key] != nil){
        return [self objectForKey:key];
    }
    return nil;     
}

@end

@implementation SPMethods

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
    [[SPMethods operationQueue] addOperation:[NSBlockOperation blockOperationWithBlock:^{
        NSDictionary *json = [SPMethods jsonDataFromUrl:url];
        NSArray *players = [json objectForKey:@"players"];
        NSMutableArray *mplayers = [[NSMutableArray alloc] initWithCapacity:[players count]];
        NSAutoreleasePool *pool =  [[NSAutoreleasePool alloc] init];
        for(NSDictionary *playerData in players){
            SPPlayer *player = [[SPPlayer alloc] initWithDictionary:playerData];
            [mplayers addObject:player];
            [player release];
        }
        [pool drain];
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
    }]];
}

+ (void)requestShotsWithURL:(NSURL *)url
            runOnMainThread:(BOOL)runOnMainThread
                  withBlock:(void (^)(NSArray *, SPPagination *))block{
    [[SPMethods operationQueue] addOperation:[NSBlockOperation blockOperationWithBlock:^{
        NSDictionary *json = [SPMethods jsonDataFromUrl:url];
        NSArray *shots = [json objectForKey:@"shots"];
        NSMutableArray *mshots = [[NSMutableArray alloc] initWithCapacity:[shots count]];
        NSAutoreleasePool *pool =  [[NSAutoreleasePool alloc] init];
        for(NSDictionary *shotData in shots){
            SPShot *shot = [[SPShot alloc] initWithDictionary:shotData];
            [mshots addObject:shot];
            [shot release];
        }
        [pool drain];
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
    }]];
}

+ (void)requestCommentsWithURL:(NSURL *)url
            runOnMainThread:(BOOL)runOnMainThread
                  withBlock:(void (^)(NSArray *, SPPagination *))block{
    [[SPMethods operationQueue] addOperation:[NSBlockOperation blockOperationWithBlock:^{
        NSDictionary *json = [SPMethods jsonDataFromUrl:url];
        NSArray *comments = [json objectForKey:@"comments"];
        NSMutableArray *mcomments = [[NSMutableArray alloc] initWithCapacity:[comments count]];
        NSAutoreleasePool *pool =  [[NSAutoreleasePool alloc] init];
        for(NSDictionary *commentData in comments){
            SPComment *comment = [[SPComment alloc] initWithDictionary:commentData];
            [mcomments addObject:comment];
            [comment release];
        }
        [pool drain];
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
        NSImage *image = nil;        
        NSData *imageData = [[self class] dataFromUrl:url];
        if(imageData != nil){
            image = [[[NSImage alloc] initWithData:imageData] autorelease];
            // For some reason the size can be inccorect so make a CGImage, which seems
            // to always have the correct size, and then set the size based on what
            // the CGImage says it is.
            CGImageRef cgimage = [[NSBitmapImageRep imageRepWithData:imageData] CGImage];
            NSSize realSize = NSMakeSize(CGImageGetWidth(cgimage), CGImageGetHeight(cgimage));
            [image setSize:realSize];
        }
        #endif

        // if the image has no size it was not loaded so return nil
        if(image != nil && image.size.width == 0 && image.size.height == 0){
            image = nil;
        }
        
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
    NSData *data = [self dataFromUrl:url];
    return [[self parser] objectWithData:data];
}

@end
