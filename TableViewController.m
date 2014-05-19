//
//  TableViewController.m
//  lab04
//
//  Created by 堀江直人 on 2014/05/10.
//  Copyright (c) 2014年 堀江直人. All rights reserved.
//

#import "TableViewController.h"
#import "AppDelegate.h"
#import "SQLiteManager.h"

@interface TableViewController ()

@end

@implementation TableViewController{
    AppDelegate *appDelegate;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //デリゲートにある変数の初期化
    appDelegate= (AppDelegate*)[[UIApplication sharedApplication] delegate];
    if(appDelegate.TitleArray == NULL){
        appDelegate.TitleArray = [[NSMutableArray alloc] init];
        appDelegate.ItemArray = [[NSMutableArray alloc] init];
        appDelegate.ValueArray = [[NSMutableArray alloc] init];
        appDelegate.HowToArray = [[NSMutableArray alloc] init];
    }
    //テーブルビューのリロード
    [self.ListTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

    //ビューが表示された時
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if([appDelegate.TitleArray count] > 0){
        /*
        NSLog(@"TitleArray:%@",[appDelegate.TitleArray objectAtIndex:1]);
        NSLog(@"ItemArray:%@",[appDelegate.ItemArray objectAtIndex:1]);
        NSLog(@"HowToArray:%@",[appDelegate.HowToArray objectAtIndex:1]);
        
        NSLog(@"TitleArray:%@",appDelegate.TitleArray);
        NSLog(@"ItemArray:%@",appDelegate.ItemArray);
        NSLog(@"HowToArray:%@",appDelegate.HowToArray);
        */
    }
    
    //テーブルビューをリロード
    [self.ListTableView reloadData];
    
    //appDelegate.RTitleString = nil;

   
}

/*          テーブル            */

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return appDelegate.TitleArray.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // セルが作成されていないか?
    if (!cell) { // yes
        // セルを作成
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    //セルのテキストラベルにタイトルを指定する
    cell.textLabel.text = [appDelegate.TitleArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath*) indexPath{

    //appDelegate.index = indexPath.row;
    // toViewController
    [self performSegueWithIdentifier:@"toViewController" sender:self];
}


@end


