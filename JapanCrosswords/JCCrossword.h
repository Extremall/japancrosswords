//
//  JCCrossword.h
//  JapanCrosswords
//
//  Created by Alexander Naumenko on 25.04.13.
//  Copyright (c) 2013 Alexander Naumenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JCDescription.h"
#import "JCSolution.h"

@interface JCCrossword : NSObject <NSCoding>
{
    JCDescription *description;
    JCSolution *solution;
}

@property (nonatomic, retain) JCDescription *description;
@property (nonatomic, retain) JCSolution *solution;

@end
