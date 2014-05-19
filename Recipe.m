//
//  Recipe.m
//  lab04
//
//  Created by 堀江直人 on 2014/05/17.
//  Copyright (c) 2014年 堀江直人. All rights reserved.
//

#import "Recipe.h"

@implementation Recipe{
    
    NSMutableArray *RecipeList;
    
}

NSMutableArray *RTitle;
NSMutableArray *RItems;
NSMutableArray *RValue;
NSMutableArray *RHowTo;

+(void)initialize{
    if(!RTitle || !RItems || !RValue || !RHowTo ){
        RTitle = [[NSMutableArray alloc] init];
        RItems = [[NSMutableArray alloc] init];
        RValue = [[NSMutableArray alloc] init];
        RHowTo = [[NSMutableArray alloc] init];
    }
}

//レシピデータの追加メソッド
//タイトル食材数量方法などをここでいつのデータにまとめ
- (void) addRecipe:(NSString *)title Items:(NSMutableArray *)item Value:(NSMutableArray *)value HowTo:(NSMutableArray *)howto{
    
    [RTitle addObject:title];
    [RItems addObject:item];
    [RValue addObject:value];
    [RHowTo addObject:howto];
    
}


//getRecipeメソッドの定義
//
- (NSString) getRecipe:(int *)index{
    NSString *str[] = {[RTitle objectAtIndex:index], [RItems objectAtIndex:index], [RValue objectAtIndex:index], [RHowTo objectAtIndex:index]};
    
    return str;
}

- (NSString) getTitle(int *)index{
    
    NSString *str = [RTitle objectAtIndex:index];
    return [NSString stringWithFormat:str];
    
}


@end
