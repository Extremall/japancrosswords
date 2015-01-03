//
//  JCCenterView.h
//  JapanCrosswords
//
//  Created by Alexander Naumenko on 11.04.13.
//  Copyright (c) 2013 Alexander Naumenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JCView.h"
#import "JCSolution.h"

@class JCCenterView;

@protocol JCCenterViewDelegate <NSObject>

- (void)jcCenterViewDidSelectCell:(JCCenterView *)jcView cell:(UIView *)cell row:(NSInteger)row col:(NSInteger)col;

@end

@interface JCCenterView : JCView
{
    id<JCCenterViewDelegate> delegate;
    JCSolution *jcSolution;
    NSMutableArray *matrCells;
}

@property (nonatomic, assign) id<JCCenterViewDelegate> delegate;
@property (nonatomic, retain) JCSolution *jcSolution;

- (void)loadCellsWithCellSize:(CGSize)cellSize;

@end
