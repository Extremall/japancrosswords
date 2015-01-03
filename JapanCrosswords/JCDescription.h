//
//  JCDescription.h
//  JapanCrosswords
//
//  Created by Alexander Naumenko on 12.04.13.
//  Copyright (c) 2013 Alexander Naumenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JCLine : NSObject<NSCoding>
{
    NSInteger length;
    NSInteger color;
}

@property (nonatomic, assign) NSInteger length;
@property (nonatomic, assign) NSInteger color;


@end

@interface JCDescription : NSObject<NSCoding>
{
    NSMutableArray *leftMatr;
    NSMutableArray *topMatr;
    
    NSMutableArray *colorMatr;
}

@property (nonatomic, retain) NSMutableArray *leftMatr;
@property (nonatomic, retain) NSMutableArray *topMatr;
@property (nonatomic, retain) NSArray *colorMatr;


@end
