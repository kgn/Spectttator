//
//  SPPagination.m
//  Spectttator
//
//  Created by David Keegan on 6/26/11.
//  Copyright 2011 David Keegan.
//

#import "SPPagination.h"

@implementation SPPagination

@synthesize page = _page;
@synthesize pages = _pages;
@synthesize perPage = _perPage;
@synthesize total = _total;

+ (NSDictionary *)page:(NSUInteger)page{
    return [SPPagination page:page perPage:NSNotFound];
}

+ (NSDictionary *)perPage:(NSUInteger)perPage{
    return [SPPagination page:NSNotFound perPage:perPage];
}

+ (NSDictionary *)page:(NSUInteger)page perPage:(NSUInteger)perPage{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    if(page != NSNotFound && page > 0){
        [dictionary setObject:[NSNumber numberWithLong:page] forKey:@"page"];
    }
    if(perPage != NSNotFound && perPage > 0){
        [dictionary setObject:[NSNumber numberWithLong:perPage] forKey:@"perPage"];
    }    
    return dictionary;
}

+ (id)paginationWithDictionary:(NSDictionary *)dictionary{
    return [[SPPagination alloc] initWithDictionary:dictionary];
}

- (id)initWithDictionary:(NSDictionary *)dictionary{
    if((self = [super init])){
        if([dictionary objectForKey:@"page"] != [NSNull null]){
            _page = [[dictionary objectForKey:@"page"] intValue];
        }else{
            _page = NSNotFound;
        }
        
        if([dictionary objectForKey:@"pages"] != [NSNull null]){
            _pages = [[dictionary objectForKey:@"pages"] intValue];
        }else{
            _pages = NSNotFound;
        }
        
        if([dictionary objectForKey:@"per_page"] != [NSNull null]){
            _perPage = [[dictionary objectForKey:@"per_page"] intValue];
        }else{
            _perPage = NSNotFound;
        }
        
        if([dictionary objectForKey:@"total"] != [NSNull null]){
            _total = [[dictionary objectForKey:@"total"] intValue];
        }else{
            _total = NSNotFound;
        }
    }
    return self;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"<%@ Page=%lu Pages=%lu PerPage=%lu Total=%lu>", 
            [self class], self.page, self.pages, self.perPage, self.total];
}

@end
