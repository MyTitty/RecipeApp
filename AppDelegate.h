//
//  AppDelegate.h
//  lab04
//
//  Created by 堀江直人 on 2014/05/01.
//  Copyright (c) 2014年 堀江直人. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property NSMutableArray *TitleArray;
@property NSMutableArray *ItemArray;
@property NSMutableArray *ValueArray;
@property NSMutableArray *HowToArray;
@property NSInteger *index;

@end
