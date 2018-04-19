//
//  BG_SQLiteManager.h
//  BG_SQLite
//
//  Created by zhangzhiliang on 2018/4/19.
//  Copyright © 2018年 zhangzhiliang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BG_SQLiteManager : NSObject

/**
 单例方法
 */
+ (BG_SQLiteManager *)shareManager;

/**
打开数据库
*/
- (void)open;

/**
 关闭数据库
 */
- (void)close;

/**
 创建表
 */
- (void)create;

/**
 插入数据
 */
- (void)insert;

/**
 更新数据
 */
- (void)update;

/**
 删除数据
 */
- (void)deleteData;

/**
 查询数据
 */
- (void)select;

@end
