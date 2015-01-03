//
//  JCCrossword.m
//  JapanCrosswords
//
//  Created by Alexander Naumenko on 25.04.13.
//  Copyright (c) 2013 Alexander Naumenko. All rights reserved.
//

#import "JCCrossword.h"

@implementation JCCrossword

@synthesize description;
@synthesize solution;

- (void)dealloc
{
    [description release];
    [solution release];
    [super dealloc];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        description = [[aDecoder decodeObjectForKey:@"description"] retain];
        solution = [[aDecoder decodeObjectForKey:@"solution"] retain];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:description forKey:@"description"];
    [aCoder encodeObject:solution forKey:@"solution"];
}

@end
