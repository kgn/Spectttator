//
//  SPPagination.m
//  Spectttator
//
//  Created by David Keegan on 6/26/11.
//  Copyright 2011 David Keegan.
//

#import "SPPagination.h"
#import "SPMethods.h"

NSUInteger const SPPerPageDefault = 15;
NSUInteger const SPPerPageMax = 50;

@interface SPPagination()
@property(nonatomic, readwrite) NSUInteger page;
@property(nonatomic, readwrite) NSUInteger pages;
@property(nonatomic, readwrite) NSUInteger perPage;
@property(nonatomic, readwrite) NSUInteger total;
@end

@implementation SPPagination

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
        self.page = [dictionary uintSafelyFromKey:@"page"];
        self.pages = [dictionary uintSafelyFromKey:@"pages"];
        self.perPage = [dictionary uintSafelyFromKey:@"per_page"];
        self.total = [dictionary uintSafelyFromKey:@"total"];
    }
    return self;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"<%@ Page=%lu Pages=%lu PerPage=%lu Total=%lu>",
            [self class], (unsigned long)self.page, (unsigned long)self.pages,
            (unsigned long)self.perPage, (unsigned long)self.total];
}

@end
