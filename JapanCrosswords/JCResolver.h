//
//  JCResolver.h
//  JapanCrosswords
//
//  Created by Alexander Naumenko on 19.04.13.
//  Copyright (c) 2013 Alexander Naumenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JCDescription.h"

@interface JCResolver : NSObject
{
    NSArray *cells;
    NSArray *codes;
    
    NSMutableArray *positions;
    
    NSMutableArray *solution;
}

+ (void)printMatr:(NSArray *)rows;
- (BOOL)resolveMatrStep:(NSMutableArray *)rows jcDescription:(JCDescription *)jcDescription;
- (void)resolveMatr:(NSMutableArray *)rows jcDescription:(JCDescription *)jcDescription;
- (NSArray *)resolveJCDescription:(JCDescription *)jcDescription;

@end
