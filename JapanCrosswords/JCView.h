//
//  JCView.h
//  JapanCrosswords
//
//  Created by Alexander Naumenko on 10.04.13.
//  Copyright (c) 2013 Alexander Naumenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JCDescription.h"

@interface JCView : UIControl
{
    int rowCount;
    int colCount;
    UIEdgeInsets insets;
    CGFloat cellsDistance;
    CGFloat blocksDistance;
    
    NSMutableArray *matrViews;
    
    NSInteger currentColor;
    JCDescription *jcDescription;
}

@property (nonatomic, assign) int rowCount;
@property (nonatomic, assign) int colCount;
@property (nonatomic, assign) UIEdgeInsets insets;
@property (nonatomic, assign) CGFloat cellsDistance;
@property (nonatomic, assign) CGFloat blocksDistance;

@property (nonatomic, assign) NSInteger currentColor;
@property (nonatomic, retain) JCDescription *jcDescription;

- (void)createCells;
- (void)createCellsWithCellSize:(CGSize)cellSize;
- (void)reloadCells;
- (void)reloadSizes;
- (void)reloadSizesWithCellSize:(CGSize)cellSize;

@end
