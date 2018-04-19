//
//  BG_SQLiteManager.m
//  BG_SQLite
//
//  Created by zhangzhiliang on 2018/4/19.
//  Copyright © 2018年 zhangzhiliang. All rights reserved.
//

#import "BG_SQLiteManager.h"
#import <sqlite3.h>
#import <UIKit/UIKit.h>

@interface BG_SQLiteManager (){
    
    sqlite3 *db;
}


@end

@implementation BG_SQLiteManager

+ (BG_SQLiteManager *)shareManager {
    static BG_SQLiteManager *manager = nil;
    static dispatch_once_t onceToken;//只创建一次
    dispatch_once(&onceToken, ^{
        manager = [[BG_SQLiteManager alloc] init];
    });
    
    return manager;
}

- (void)open {
    
    //确定存放路径(放在沙盒)
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSLog(@"%@",documentPath);
    //SQLite路径
    NSString *SQLitePath = [documentPath stringByAppendingPathComponent:@"Database.sqlite"];
    
    //打开数据库
    int result = sqlite3_open(SQLitePath.UTF8String, &db);
    
    //判断数据库是否打开成功
    if (result == SQLITE_OK) {
//        __weak typeof(self) weakSelf = self;
        [self alertMessage:@"打开成功" block:nil];
    } else {
        [self alertMessage:@"打开失败" block:nil];
    }
}

- (void)close {
    
    int result = sqlite3_close(db);
    
    //判断结果
    if (result == SQLITE_OK) {
        [self alertMessage:@"关闭成功" block:nil];
    } else {
        [self alertMessage:@"关闭失败" block:nil];
    }
}

- (void)create {
    
    //sql语句
    NSString *sqlString = @"create table Person (id integer primary key, name text, age integer)";
    
    char *error = nil;
    //执行sql
    sqlite3_exec(db, sqlString.UTF8String, nil, nil, &error);
    
    //判断是否出现错误
    if (error == nil) {
        [self alertMessage:@"创建表成功" block:nil];
    } else {
        [self alertMessage:@"创建表失败" block:nil];
    }
}

- (void)insert {
    
    NSString *sqlString = @"insert into Person ('name', 'age') values ('张三',18)";
    
    char *error;
    
    sqlite3_exec(db, sqlString.UTF8String, nil, nil, &error);
    
    //判断是否出现错误
    if (error == nil) {
        [self alertMessage:@"插入成功" block:nil];
    } else {
        [self alertMessage:@"插入失败" block:nil];
    }
}

- (void)update {
    
    NSString *sqlString = @"update Person set 'name' = '李四' where id = 1";
    
    char *error;
    
    sqlite3_exec(db, sqlString.UTF8String, nil, nil, &error);
    
    //判断是否出现错误
    if (error == nil) {
        [self alertMessage:@"更新成功" block:nil];
    } else {
        [self alertMessage:@"更新失败" block:nil];
    }
}

- (void)deleteData {
    
    NSString *sqlString = @"drop table Person";
    
    char *error;
    
    sqlite3_exec(db, sqlString.UTF8String, nil, nil, &error);
    
    //判断是否出现错误
    if (error == nil) {
        [self alertMessage:@"删除成功" block:nil];
    } else {
        [self alertMessage:@"删除失败" block:nil];
    }
}

- (void)select {
    
    NSString *sqlString = @"select * from Person";
    
    //准备sql
    sqlite3_stmt *stmt = nil;
    sqlite3_prepare(db, sqlString.UTF8String, -1, &stmt, nil);
    
    //单步执行语句
    while (sqlite3_step(stmt) == SQLITE_ROW) {
        int ID = sqlite3_column_int(stmt, 0);
        const unsigned char * name = sqlite3_column_text(stmt, 1);
        NSString *nameString = [NSString stringWithUTF8String:(const char*)name];
        int age = sqlite3_column_int(stmt, 2);
        NSLog(@"id--%d\n name--%@\n age--%d", ID, nameString, age);
    }
    
    //释放
    sqlite3_finalize(stmt);
}

#pragma mark ------------------- 消息弹出框--------------------
- (void)alertMessage:(NSString *)message block:(void(^)(void))block {
    //这里的block可以做回调使用
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"数据库执行结果" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alertVC addAction:action];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
}

@end
