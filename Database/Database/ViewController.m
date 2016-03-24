//
//  ViewController.m
//  Database
//
//  Created by Ansel on 16/3/21.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "ViewController.h"
#import "DatabaseQueue.h"
#import "Database.h"
#import "Database+Transaction.h"

@interface ViewController ()

@property (nonatomic, strong) DatabaseQueue *databaseQueue;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *databasePath = [documentDirectory stringByAppendingPathComponent:@"database.db"];
    _databaseQueue = [[DatabaseQueue alloc] initWithDatabasePath:databasePath];
    
//   BOOL result = [_database executeUpdate:@"create table if not exists Person (rowId integer primary key autoincrement, name text, age integer)"];
    
    [_databaseQueue inDatabase:^(Database *db) {
        [db executeUpdate:@"insert into Person(name, age) values ('Ansel', 29)"];
        NSArray<NSDictionary *> *resuts = [db executeQuery:@"select * from Person"];
        NSLog(@"%@", resuts);
    }];

    [_databaseQueue inExclusiveTransaction:^(Database *db, BOOL *rollback) {
        
        [db startSavePointWithName:@"1"];
        
        [db releaseSavePointWithName:@"1"];

        
        *rollback = [db executeUpdate:@"insert into Person(name, age) values ('Ansel', 29)"];
        
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
