//
//  ViewController.m
//  NSFileManageTest
//
//  Created by SmartFun on 2017/6/21.
//  Copyright © 2017年 SmartFun. All rights reserved.
//

#import "ViewController.h"
#import "SQLiteTools.h"
#import "SQLiteModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
#pragma mark - 获取文件路径的方法
    /* 这些是获取路径的方法 */
    
    //沙盒路径
    NSString *path = NSHomeDirectory();
    NSLog(@"沙盒路径--%@",path);
    
    /* 	当前应用的沙盒下存在
     * data containers: 存储数据的文件
     * bundle container: 存放app的文件 程序包本身
     * icloud container: 手机云备份
     */
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSLog(@"document路径--%@",documentPath);
    
    NSString *libarary = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    NSLog(@"libarary路径--%@",libarary);
    
    
    /**
     * NSSearchPathForDirectoriesInDomains方法用于查找目录
     * directory: 要搜索的目录名称
     * domainMask: 指定搜索范围
     * expandTilde: 路径是否展开
     */
    NSString *cachesDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSLog(@"libarary路径--%@",cachesDir);
    
#pragma mark - 获取应用程序程序包中资源文件路径的方法
    /* 获取bundle文件的方法 */
    
    NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
    
    NSString *bundle = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"good"];
    NSLog(@"----%@",bundle);
    
    NSLog(@"bundlePath--%@",bundlePath);
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"apple" ofType:@"bundle"];
    NSLog(@"%@",imagePath);

    
    SQLiteModel *model = [[SQLiteModel alloc] init];
    model.ID_num = 1;
    model.sender2 = @"你说你是啥>?";
    model.sender3 = @"我曹啊这屁玩意这么多坑呢.";
    
    
    [[SQLiteTools shareInstance] insertData:model success:^(SQLiteToolsState successState) {
        
        NSLog(@"成功类型:%ld",successState);
        
    } fail:^(SQLiteToolsState failState) {
        
        NSLog(@"失败类型:%ld",failState);
        
    }];
    
    [[SQLiteTools shareInstance] selectData:1 success:^(NSMutableArray *dataArray) {
        
        BOOL state = [[SQLiteTools shareInstance] deleteData:1];
        
        NSLog(@"删除状态:%d",state);
        
    } fail:^(SQLiteToolsState failState) {
        
    }];
    
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
