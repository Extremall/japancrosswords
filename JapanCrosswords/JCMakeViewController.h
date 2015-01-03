//
//  JCMakeViewController.h
//  JapanCrosswords
//
//  Created by Alexander Naumenko on 10.04.13.
//  Copyright (c) 2013 Alexander Naumenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JCSideView.h"
#import "JCCenterView.h"
#import "JCCrossword.h"

@interface JCMakeViewController : UIViewController<UIScrollViewDelegate, JCCenterViewDelegate>
{
    IBOutlet JCCenterView *jcv;
    IBOutlet JCSideView *jcvLeft;
    IBOutlet JCSideView *jcvTop;
    IBOutlet UIScrollView *scrollView;
    IBOutlet UIView *svLeft;
    IBOutlet UIView *svTop;
    IBOutlet UISwitch *swScroll;
    
    IBOutlet UIView *sliderView;
    CGPoint startPoint;
    BOOL insideSlider;
    
    JCCrossword *jcCrossword;
}

@property (nonatomic, retain) JCCrossword *jcCrossword;

- (IBAction)swChange:(id)sender;

@end
