//
//  ViewController.m
//  lab04
//
//  Created by 堀江直人 on 2014/05/01.
//  Copyright (c) 2014年 堀江直人. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "TableViewController.h"
#import "SQLiteManager.h"

@interface ViewController ()
- (IBAction)AddHowToCellButton:(UIButton *)sender;
- (IBAction)closeKeyBoard:(id)sender;
- (IBAction)AddCellButton:(UIButton *)sender;
@end

@implementation ViewController
    BOOL TableName;
    BOOL *KeyBoard = NO;
    NSString *Title;
    NSMutableArray *Items;
    NSMutableArray *Value;
    NSMutableArray *HowTo;
    UIScrollView *myScrollView;

- (void)viewDidLoad
{
    [super viewDidLoad];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*          アクションメソッド           */

    //食材を追加するボタンが押されたときのイベント処理
- (IBAction)AddCellButton:(UIButton *)sender {
    
    TableName = YES;
    
    //Itemsが空の時初期化する
    if(!Items){
        Items = [[NSMutableArray alloc] init];
        Value = [[NSMutableArray alloc] init];
    }
    
    //テキストフィールドのデータを配列に格納
    [Items addObject:self.RName.text];
    [Value addObject:self.RValue.text];
    
    [self.ItemTableView reloadData];
    
}

    //調理方法を追加するボタンが押されたときのイベント処理
- (IBAction)AddHowToCellButton:(UIButton *)sender {
    
    TableName = NO;
    
    if(!HowTo){
        HowTo = [[NSMutableArray alloc] init];
    }
    
    [HowTo addObject:self.HText.text];
    
    [self.HowToTableView reloadData];
}

    //キーボードを隠すイベント処理
- (IBAction)closeKeyBoard:(id)sender {
    [self.view endEditing:YES];
}


/*          テーブル            */

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(TableName){
        return Items.count;
    }else{
        return HowTo.count;
    }
    
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
    

    if(TableName){
        cell.textLabel.text = [Items objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = [Value objectAtIndex:indexPath.row];
    }else{
        cell.textLabel.text = [HowTo objectAtIndex:indexPath.row];
    }
    
    // Configure the cell...
    
    return cell;
}

/*              キーボード・ナビゲーションコントローラー             */


// viewが表示される時に呼び出されます
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // キーボードの表示・非表示はNotificationCenterから通知されます
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
}

// viewが非表示になる時に呼び出されます
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // ちゃんとremoveしてあげましょう
    // 今回はviewWillAppearで通知登録なので、viewWillDisappearでやります
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    //ナビゲーションコントローラーのbackが押された
    if (![self.navigationController.viewControllers containsObject:self] && ![self.RTitle.text isEqualToString: @""]) {

        //デリゲートにTitle,Item,HowToのデータを保存
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        [appDelegate.TitleArray addObject: self.RTitle.text];
        [appDelegate.ItemArray addObject: Items];
        [appDelegate.ValueArray addObject: Value];
        [appDelegate.HowToArray addObject: HowTo];
        
        /*
        NSLog(@"TitleArray:%@",appDelegate.TitleArray);
        NSLog(@"ItemArray:%@",appDelegate.ItemArray);
        NSLog(@"HowToArray:%@",appDelegate.HowToArray);
        */
        
        //テキストとテーブルを初期化とリロード
        
        self.RTitle.text = @"";
        [Items removeAllObjects];
        [HowTo removeAllObjects];
        
        [self.ItemTableView reloadData];
        [self.HowToTableView reloadData];
         
    }
}

// キーボードが表示される時に呼び出されますー
- (void)keyboardWillShow:(NSNotification *)notification {
    // キーボードのサイズ
    CGRect keyboardRect = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // キーボード表示アニメーションのduration
    NSTimeInterval duration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    if(KeyBoard){
        // viewのアニメーション
        [UIView animateWithDuration:duration animations:^{
            // ここをframeわざわざ計算してる人おおいですねー
            CGAffineTransform transform = CGAffineTransformMakeTranslation(0, -keyboardRect.size.height);
            self.view.transform = transform;
        }completion:NULL];
    }
    
}

// キーボードが非表示になる時に呼び出されますー
- (void)keyboardWillHide:(NSNotification *)notification {
    // キーボード表示アニメーションのduration
    NSTimeInterval duration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    __weak typeof(self) _self = self;
    [UIView animateWithDuration:duration animations:^{
        // tranformで動かしておけば、戻すときはこれだけ！
        _self.view.transform = CGAffineTransformIdentity;
    } completion:NULL];
}

// キーボードで確定がタップされた時に呼び出されますー
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    // キーボードを非表示にするにはこう！
    [textField resignFirstResponder];
    return YES;
}




@end
