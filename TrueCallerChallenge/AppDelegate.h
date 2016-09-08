//
//  AppDelegate.h
//  TrueCallerChallenge
//
//  Created by Adam Lovastyik on 2016. 07. 11..
//  Copyright © 2016. Adam Lovastyik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

/**
 *  Displays network indicator
 */
- (void)increaseNetworkIndicatorCount;

/**
 *  Hides network indicator when not needed anymore
 */
- (void)decreaseNetworkIndicatorCount;

@end

