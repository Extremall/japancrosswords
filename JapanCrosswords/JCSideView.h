//
//  JCSideView.h
//  JapanCrosswords
//
//  Created by Alexander Naumenko on 11.04.13.
//  Copyright (c) 2013 Alexander Naumenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JCView.h"

#define kLabelSideCellTag 133221

typedef enum
{
    JCSideViewTypeTop,
    JCSideViewTypeLeft
}
JCSideViewType;

@interface JCSideView : JCView
{
    JCSideViewType sideViewType;
}

@property (nonatomic, assign) JCSideViewType sideViewType;

- (void)refreshDescriptionForRow:(NSInteger)row col:(NSInteger)col;
- (void)refreshDescription;

@end
