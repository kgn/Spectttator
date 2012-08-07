//
//  SPPagination.m
//  Spectttator
//
//  Created by David Keegan on 6/26/11.
//  Copyright 2011 David Keegan.
//

#import "SPPagination.h"
#import "SPMethods.h"

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
        [dictionary setObject:@(page) forKey:@"page"];
    }
    if(perPage != NSNotFound && perPage > 0){
        [dictionary setObject:@(perPage) forKey:@"perPage"];
    }    
    return dictionary;
}

+ (id)paginationWithDictionary:(NSDictionary *)dictionary{
    return [[[SPPagination alloc] initWithDictionary:dictionary] autorelease];
}

- (id)initWithDictionary:(NSDictionary *)dictionary{
    if((self = [super init])){
        _page = [dictionary uintSafelyFromKey:@"page"];
        _pages = [dictionary uintSafelyFromKey:@"pages"];
        _perPage = [dictionary uintSafelyFromKey:@"per_page"];
        _total = [dictionary uintSafelyFromKey:@"total"];
    }
    return self;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"<%@ Page=%lu Pages=%lu PerPage=%lu Total=%lu>",
            [self class], (unsigned long)self.page, (unsigned long)self.pages,
            (unsigned long)self.perPage, (unsigned long)self.total];
}

@end
