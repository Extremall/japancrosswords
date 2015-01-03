//
//  AppDelegate.h
//  JapanCrosswords
//
//  Created by Alexander Naumenko on 10.04.13.
//  Copyright (c) 2013 Alexander Naumenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UINavigationController *navController;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

@end
