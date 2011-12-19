//
//  SPObject.m
//  Spectttator
//
//  Created by David Keegan on 12/19/11.
//  Copyright (c) 2011 David Keegan. All rights reserved.
//

#import "SPObject.h"

@implementation SPObject

@synthesize identifier = _identifier;
@synthesize createdAt = _createdAt;

- (id)initWithDictionary:(NSDictionary *)dictionary{
    if((self = [super init])){
        _identifier = [dictionary uintSafelyFromKey:@"id"];
        NSString *createdAt = [dictionary stringSafelyFromKey:@"created_at"];
        if(createdAt != nil){
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy/MM/dd HH:mm:ss ZZZZ"];
            _createdAt = [[formatter dateFromString:createdAt] retain];
            [formatter release];
        }else{
            _createdAt = nil;
        }
    }
    
    return self;
}

- (NSUInteger)hash{
    return self.identifier;
}

- (BOOL)isEqual:(id)object{
    if([object isKindOfClass:[self class]]){
        return (self.identifier == [(SPObject *)object identifier]);
    }
    return NO;
}

- (void)dealloc{
    [_createdAt release];
    [super dealloc];
}

@end
