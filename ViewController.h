//
//  ViewController.h
//  lab04
//
//  Created by 堀江直人 on 2014/05/01.
//  Copyright (c) 2014年 堀江直人. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
    @property (assign) IBOutlet UITextField *RTitle;
    @property (assign) IBOutlet UITextField *RName;
    @property (assign) IBOutlet UITextField *RValue;

    @property IBOutlet UITableView *ItemTableView;
    @property IBOutlet UITableView *HowToTableView;

    @property (assign) IBOutlet UITextField *HText;

    @property IBOutlet UIScrollView *myScrollView;



@end
