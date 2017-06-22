//
//  SQLiteTools.h
//  NSFileManageTest
//
//  Created by SmartFun on 2017/6/21.
//  Copyright © 2017年 SmartFun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQLiteModel.h"

typedef enum : NSUInteger {
    SQLiteToolsInsertSuccees = 0,
    SQLiteToolsInsertFail,
    SQLiteToolsDeleteSuccees,
    SQLiteToolsDeleteFail,
    SQLiteToolsUpdateSuccees,
    SQLiteToolsUpdateFail,
    SQLiteToolsSelectSuccees,
    SQLiteToolsSelectFail,
} SQLiteToolsState;


@interface SQLiteTools : NSObject

typedef void (^successBlock)(SQLiteToolsState successState);

typedef void (^failBlock)(SQLiteToolsState failState);

typedef void (^valueBlock) (NSMutableArray *dataArray);

@property (nonatomic, strong) successBlock successblock;

@property (nonatomic, strong) failBlock failBlock;

+ (SQLiteTools *)shareInstance;

//插入
- (void)insertData:(SQLiteModel *)model success:(successBlock)success fail:(failBlock)fail;
//查找
- (void)selectData:(NSInteger)ID success:(valueBlock)success fail:(failBlock)fail;
//删除
- (BOOL)deleteData:(NSInteger)tag;

@end
