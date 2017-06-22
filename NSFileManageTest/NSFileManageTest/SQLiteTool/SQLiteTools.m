//
//  SQLiteTools.m
//  NSFileManageTest
//
//  Created by SmartFun on 2017/6/21.
//  Copyright © 2017年 SmartFun. All rights reserved.
//

#import "SQLiteTools.h"
#import "FMDB.h"

#define SQLiteString @"warehouse.sqlite"

#define IS_DB_OPEN if (![_fmdb open]) {\
return;\
}

#define IS_BLOCK_SUCCESS if (success) {\
self.successblock = success;\
}

#define IS_BLOCK_FAIL if (fail) {\
self.failBlock = fail;\
}

@implementation SQLiteTools

static FMDatabase *_fmdb;

+ (SQLiteTools *)shareInstance{
    static SQLiteTools *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (instancetype)init{
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:SQLiteString];
    //初始化
    _fmdb = [FMDatabase databaseWithPath:filePath];
    
    [self openDB];
    
    return self;
}

- (void)openDB{
    BOOL successOpen = [_fmdb open];
 
    if (successOpen)
    {
        NSLog(@"数据库创建成功");
        /**  sqlite3 数据类型
         *   NULL：标识一个NULL值
         *   INTERGER：整数类型
         *   REAL：浮点数
         *   TEXT：字符串
         *   BLOB：二进制数
         */
        
       
        /*  sqlite3存储数据的约束条件
         
         PRIMARY KEY - 主键：
         1）主键的值必须唯一，用于标识每一条记录，如学生的学号
         2）主键同时也是一个索引，通过主键查找记录速度较快
         3）主键如果是整数类型，该列的值可以自动增长
     
         NOT NULL - 非空：
         约束列记录不能为空，否则报错
         
         UNIQUE - 唯一：
         除主键外，约束其他列的数据的值唯一
         
         CHECK - 条件检查：
         约束该列的值必须符合条件才可存入
         
         DEFAULT - 默认值：
         列数据中的值基本都是一样的，这样的字段列可设为默认值
         
         */
        NSString *creatString = @"CREATE TABLE IF NOT EXISTS t_model(id INTEGER PRIMARY KEY, ID_num INTEGER, sender2 TEXT, sender3 TEXT);";
    
        BOOL stateFordb = [_fmdb executeUpdate:creatString];
        
        if (stateFordb) {
            NSLog(@"数据库已打开");
        }
        else{
            NSLog(@"数据库打开失败");
        }
        
        
    }
    
}

//插入数据
- (void)insertData:(SQLiteModel *)model success:(successBlock)success fail:(failBlock)fail{
    IS_DB_OPEN
    IS_BLOCK_SUCCESS
    IS_BLOCK_FAIL
    
    NSString *insertString = [NSString stringWithFormat:@"INSERT INTO t_model(ID_num,sender2,sender3)  VALUES('%zd','%@','%@');",model.ID_num,model.sender2,model.sender3];
   
    BOOL stateForinsert = [_fmdb executeUpdate:insertString];
    
    if (stateForinsert) {
        NSLog(@"插入数据库成功");
        
        self.successblock(SQLiteToolsInsertSuccees);
        
    }
    else{
        NSLog(@"插入数据库失败");
        
        self.failBlock(SQLiteToolsInsertFail);
    }
}

//查询数据
- (void)selectData:(NSInteger)ID success:(valueBlock)success fail:(failBlock)fail{
    IS_DB_OPEN
    IS_BLOCK_FAIL
    
    NSString *selectString = @"SELECT * FROM t_model;";

    NSMutableArray *arrM = [NSMutableArray array];
    
    FMResultSet *set =  [_fmdb executeQuery:selectString];
    
    while ([set next]) {
        
        NSLog(@"%@",set);
        
        NSString *value1 = [set stringForColumn: @"ID_num"];
        NSString *value2 = [set stringForColumn: @"sender2"];
        NSString *value3 = [set stringForColumn: @"sender3"];
        NSLog( @"va1: %@ , va2 : %@,va3: %@" , value1 ,value2,value3 );
        
        SQLiteModel *model = [[SQLiteModel alloc] init];
        model.ID_num = value1.integerValue;
        model.sender2 = value2;
        model.sender3 = value3;
        
        [arrM addObject:model];
        
    }
    success(arrM);
}

//删除
- (BOOL)deleteData:(NSInteger)tag{

    NSString *deleteString = [NSString stringWithFormat:@"DELETE FROM t_model WHERE ID_num = '%zd';",tag];
    BOOL state = [_fmdb executeUpdate:deleteString];
    return state;
}

//改

//- (void)updateData{
     //这个根据自己的情况需要改什么 指导语法怎么用就行

//    NSString *uSql = @"UPDATE TEST SET ID_No = ? WHERE  ID_num = ?";
//    
//    BOOL res = [_fmdb executeUpdate:uSql];
//    
//    if (!res) {
//    
//        NSLog(@"error to UPDATE data");
//        
//    } else {
//    
//        NSLog(@"succ to UPDATE data");
//        
//    }
//
//
//}



@end
