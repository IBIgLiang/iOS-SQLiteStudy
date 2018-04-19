//
//  ViewController.m
//  BG_SQLite
//
//  Created by zhangzhiliang on 2018/4/19.
//  Copyright © 2018年 zhangzhiliang. All rights reserved.
//

/**
 数据持久化:
 1 文件读写(NSSting NSArray NSDictionary NSData)
 2 归档 数据转化成NSData存起来
 3 NSUserDefaults(小数据)
 4 SQLite(轻量级,占用内存小,速度快,跨平台(iOS 安卓))
 
 SQL: 创建(Create) 插入(Insert) 更新(Update) 查询(Select)
 
 在iOS中实现SQLite数据库操作
    1.导入框架
    2.导入头文件 #import <sqlite3.h>
 */

#import "ViewController.h"
#import <sqlite3.h>
#import "BG_SQLiteManager.h"

@interface ViewController ()

@end

@implementation ViewController
- (IBAction)openDatabase:(id)sender {
    
    [[BG_SQLiteManager shareManager] open];
}

- (IBAction)createTable:(id)sender {
    [[BG_SQLiteManager shareManager] create];
}

- (IBAction)insertData:(id)sender {
    [[BG_SQLiteManager shareManager] insert];
}

- (IBAction)updateData:(id)sender {
    [[BG_SQLiteManager shareManager] update];
}

- (IBAction)selectData:(id)sender {
    [[BG_SQLiteManager shareManager] select];
}

- (IBAction)deleteData:(id)sender {
    [[BG_SQLiteManager shareManager] deleteData];
}

- (IBAction)closeData:(id)sender {
    [[BG_SQLiteManager shareManager] close];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
